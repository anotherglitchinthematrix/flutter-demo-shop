import 'package:flutter/material.dart';
import 'package:course_008/App/pages/index.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Inter',
        // primarySwatch: Colors.brown,
        // primarySwatch: Colors.grey,
        primarySwatch: Colors.blueGrey,
      ),
      home: ProductsPage(),
      routes: {
        ProductPage.routeName: (context) => ProductPage(),
      },
    );
  }
}
