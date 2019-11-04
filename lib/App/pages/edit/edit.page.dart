import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {
  static const routeName = 'edit';
  @override
  State<StatefulWidget> createState() {
    return _EditPageState();
  }
}

class _EditPageState extends State<EditPage> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageTextController = TextEditingController();
  final _imageFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          child: ListView(
            children: <Widget>[
              TextFormField(
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
    _imageFocusNode.dispose();
    super.dispose();
  }
}
