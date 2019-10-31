import 'package:flutter/material.dart';
import 'package:course_008/App/pages/index.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: ProductsPage(),
    );
  }
}
