import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:course_008/App/pages/index.dart';
import 'package:course_008/App/providers/index.dart';
import 'package:course_008/App/widgets/index.dart';

class ManagePage extends StatelessWidget {
  static const routeName = 'manage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Products'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add_box),
            tooltip: 'Add Product',
            onPressed: () => Navigator.of(context).pushNamed(EditPage.routeName),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () {
          return Provider.of<ProductsProvider>(context, listen: false).fetch();
        },
        child: Consumer<ProductsProvider>(
          builder: (context, products, _) => ManageList(products.list),
        ),
      ),
    );
  }
}
