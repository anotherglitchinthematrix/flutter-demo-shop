import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:course_008/App/pages/index.dart';
import 'package:course_008/App/providers/index.dart';
import 'package:course_008/App/widgets/index.dart';

class ManagePage extends StatelessWidget {
  static const routeName = 'manage';
  @override
  Widget build(BuildContext context) {
    // Provider.of<ProductsProvider>(context, listen: false).fetch(true);
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
      body: FutureBuilder(
          future: Provider.of<ProductsProvider>(context, listen: false).fetch(true),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            print('future builder should only trigger once.');
            return RefreshIndicator(
              onRefresh: () {
                return Provider.of<ProductsProvider>(context, listen: false).fetch(true);
              },
              child: Consumer<ProductsProvider>(
                builder: (context, products, _) => ManageList(products.list),
              ),
            );
          }),
    );
  }
}
