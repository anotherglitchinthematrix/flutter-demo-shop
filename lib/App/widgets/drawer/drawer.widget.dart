import 'package:flutter/material.dart';
import 'package:course_008/App/pages/index.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 128,
          ),
          ListTile(
            leading: Icon(Icons.grid_on),
            title: Text('Products'),
            onTap: () => Navigator.of(context).pushReplacementNamed(ProductsPage.routeName),
          ),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Orders'),
            onTap: () => Navigator.of(context).pushReplacementNamed(OrderPage.routeName),
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Manage Products'),
            onTap: () => Navigator.of(context).pushReplacementNamed(ManagePage.routeName),
          ),
        ],
      ),
    );
  }
}
