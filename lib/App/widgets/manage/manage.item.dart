import 'package:course_008/App/models/index.dart';
import 'package:flutter/material.dart';

class ManageListItem extends StatelessWidget {
  ManageListItem(this.product);
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Row(
          children: <Widget>[
            Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image(
                  width: 48,
                  height: 48,
                  fit: BoxFit.cover,
                  color: Theme.of(context).primaryColor,
                  colorBlendMode: BlendMode.color,
                  image: NetworkImage(product.imageURL),
                ),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    product.title,
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).primaryColorDark,
                    ),
                  ),
                  Text(
                    product.description,
                    style: TextStyle(
                      color: Theme.of(context).primaryColorDark.withAlpha(128),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.edit),
                  iconSize: 20,
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  iconSize: 20,
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
