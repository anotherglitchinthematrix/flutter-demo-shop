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
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool v) {
    setState(() {
      _isLoading = v;
    });
  }

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) async {
      isLoading = true;
      await Provider.of<OrderProvider>(context, listen: false).fetch();
      isLoading = false;
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
        child: isLoading ? Center(child: CircularProgressIndicator()) : OrderList(),
      ),
    );
  }
}
