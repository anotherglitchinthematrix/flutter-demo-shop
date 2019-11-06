import 'package:course_008/App/providers/order/order.provider.dart';
import 'package:flutter/material.dart';
import 'package:course_008/App/widgets/index.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatelessWidget {
  static const routeName = 'orders';
  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Orders'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: Provider.of<OrderProvider>(context, listen: false).fetch(),
          builder: (context, snapshot) {
            // return;
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              if (snapshot.error != null) {
                return Text('An error occured during fetching the order data.');
              }
              return OrderList();
            }
          },
        ),
      ),
    );
  }
}
