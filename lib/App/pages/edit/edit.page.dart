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
            ],
          ),
        ),
      ),
    );
  }
}
