import 'package:course_008/App/models/index.dart';
import 'package:course_008/App/widgets/index.dart';
import 'package:flutter/material.dart';

class ManageList extends StatelessWidget {
  ManageList(this.list);
  final List<Product> list;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      color: Theme.of(context).primaryColor.withAlpha(32),
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return ManageListItem(list[index]);
        },
      ),
    );
  }
}
