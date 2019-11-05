import 'package:course_008/App/models/index.dart';
import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {
  static const routeName = 'edit';
  @override
  State<StatefulWidget> createState() {
    return _EditPageState();
  }
}

class _EditPageState extends State<EditPage> {
  final _formKey = GlobalKey<FormState>();

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
    _formKey.currentState.save();
    print(_editedProduct.id);
    print(_editedProduct.title);
    print(_editedProduct.description);
    print(_editedProduct.price);
    print(_editedProduct.imageURL);
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

  @override
  Widget build(BuildContext context) {
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
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                onSaved: (value) {
                  _editedProduct = Product(
                    id: _editedProduct.id,
                    title: value,
                    description: _editedProduct.description,
                    imageURL: _editedProduct.imageURL,
                    price: _editedProduct.price,
                  );
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
                onSaved: (value) {
                  _editedProduct = Product(
                    id: _editedProduct.id,
                    title: _editedProduct.title,
                    description: _editedProduct.description,
                    imageURL: _editedProduct.imageURL,
                    price: double.parse(value),
                  );
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
                onSaved: (value) {
                  _editedProduct = Product(
                    id: _editedProduct.id,
                    title: _editedProduct.title,
                    description: value,
                    imageURL: _editedProduct.imageURL,
                    price: _editedProduct.price,
                  );
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
                      onSaved: (value) {
                        _editedProduct = Product(
                          id: _editedProduct.id,
                          title: _editedProduct.title,
                          description: _editedProduct.description,
                          imageURL: value,
                          price: _editedProduct.price,
                        );
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
  }
}
