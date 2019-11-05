import 'dart:ui' as prefix0;

import 'package:course_008/App/models/index.dart';
import 'package:course_008/App/providers/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditPageArguments {
  EditPageArguments({
    this.product,
  });

  final Product product;
}

class EditPage extends StatefulWidget {
  static const routeName = 'edit';
  @override
  State<StatefulWidget> createState() {
    return _EditPageState();
  }
}

class _EditPageState extends State<EditPage> {
  final _formKey = GlobalKey<FormState>();

  // a variable to store if the state is initialized.
  bool _isInitialized = false;
  bool _isBusy = false;

  bool get isBusy => _isBusy;
  set isBusy(bool v) {
    setState(() {
      _isBusy = v;
    });
  }

  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageTextController = TextEditingController();
  final _imageFocusNode = FocusNode();

  Product _editedProduct = Product(
    id: '',
    title: '',
    description: '',
    imageURL: '',
    price: 0,
  );

  void _saveForm() {
    final isValid = _formKey.currentState.validate();
    if (isValid) {
      this.isBusy = true;
      _formKey.currentState.save();

      // listen is false to prevent this page to rebuild by this provider.
      if (_editedProduct.id.isEmpty) {
        Provider.of<ProductsProvider>(context, listen: false).addProduct(_editedProduct).then((_) {
          this.isBusy = false;
          // if eveything is fine just return to the previos page, it's manage page in this case.
          Navigator.of(context).pop();
        }).catchError((error) {
          this.isBusy = false;
          //debug print
          print(error.toString());

          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text('An error occured'),
              content: Text('Something went wrong try again later.'),
            ),
          );
        });
      } else {
        // this.isBusy = false;
        Provider.of<ProductsProvider>(context, listen: false).patchProduct(_editedProduct);
      }

      // return to the previous page (ManagePage in this case).
      // Navigator.of(context).pop();
    }
  }

  @override
  void initState() {
    _imageFocusNode.addListener(_updateImageURL);

    super.initState();
  }

  void _updateImageURL() {
    if (!_imageFocusNode.hasFocus) {
      setState(() {
        // just call empty to inform.
      });
    }
  }

  // context is accessible here unlike the initState() and didChangeDependencies()
  // fired right after initState() but before build().
  @override
  void didChangeDependencies() {
    if (!_isInitialized) {
      final argument = ModalRoute.of(context).settings.arguments as EditPageArguments;
      if (argument != null) {
        _editedProduct = argument.product;
        // A textFormField with a external controller can't use initialValue so we have to assign like this.
        _imageTextController.text = argument.product.imageURL;
      }
      _isInitialized = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('rebuild test with provider listen:false');
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      // I preferred using onSaved instead of onFieldSubmitted because onSaved is triggered only when the formstate is saved.
      // but onFieldSubmitted will be triggered everytime when the enter key is pressed on the keyboard.
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Stack(
          children: <Widget>[
            Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  TextFormField(
                    initialValue: _editedProduct.title,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter a title for the product';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _editedProduct.title = value;
                    },
                    // maxLength: 128,
                    // maxLengthEnforced: false,
                    decoration: InputDecoration(
                      labelText: 'Title',
                      hintText: 'Title of the product',
                    ),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_priceFocusNode),
                  ),
                  TextFormField(
                    // autovalidate: true,
                    initialValue: _editedProduct.price.toString(),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Price can\'t be empty';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Plase enter a number.';
                      }
                      if (double.parse(value) <= 0) {
                        return 'Plase enter a number greater than 0';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _editedProduct.price = double.parse(value);
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Price',
                      hintText: 'Price of the product',
                    ),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_descriptionFocusNode),
                    focusNode: _priceFocusNode,
                  ),
                  TextFormField(
                    initialValue: _editedProduct.description,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Plase enter a description';
                      }

                      if (value.length < 10) {
                        return 'Description should be at least 10 characters';
                      }

                      return null;
                    },
                    onSaved: (value) {
                      _editedProduct.description = value;
                    },
                    maxLines: 3,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      hintText: 'Description of the product',
                    ),
                    focusNode: _descriptionFocusNode,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(
                          top: 8,
                          right: 8,
                        ),
                        color: Colors.red,
                        width: 96,
                        height: 96,
                        child: _imageTextController.text.isEmpty
                            ? Icon(Icons.broken_image)
                            : Image.network(
                                _imageTextController.text,
                                fit: BoxFit.cover,
                              ),
                      ),
                      Expanded(
                        child: TextFormField(
                          // initialValue: _editedProduct.imageURL,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter a image URL';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _editedProduct.imageURL = value;
                          },
                          decoration: InputDecoration(
                            labelText: 'Image URL',
                          ),
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.url,
                          controller: _imageTextController,
                          focusNode: _imageFocusNode,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (isBusy)
              BackdropFilter(
                filter: prefix0.ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                child: Center(child: CircularProgressIndicator()),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Free memory to  prevenet memory leaks.
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageTextController.dispose();

    // remove the listener before.
    _imageFocusNode.removeListener(_updateImageURL);
    _imageFocusNode.dispose();
    super.dispose();
    debugPrint('disposing done!');
  }
}
