import 'package:flutter/material.dart';
import 'package:course_008/App/widgets/index.dart';

class OrderPage extends StatelessWidget {
  static const routeName = "order";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Orders'),
      ),
      body: OrderList(),
    );
  }
}
