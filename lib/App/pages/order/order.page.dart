import 'package:course_008/App/providers/order/order.provider.dart';
import 'package:flutter/material.dart';
import 'package:course_008/App/widgets/index.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatefulWidget {
  static const routeName = "order";

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) {
      Provider.of<OrderProvider>(context, listen: false).fetch();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Orders'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: OrderList(),
      ),
    );
  }
}
