import 'package:course_008/App/providers/index.dart';
import 'package:flutter/material.dart';
import 'package:course_008/App/pages/index.dart';
import 'package:provider/provider.dart';

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
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Log out'),
            onTap: () {
              // should close the drawer before hard switch between pages, other wise will throw some error.
              Navigator.of(context).pop();
              Provider.of<AuthenticationProvider>(context, listen: false).logOut();
            },
          ),
        ],
      ),
    );
  }
}
