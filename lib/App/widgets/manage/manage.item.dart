import 'package:course_008/App/models/index.dart';
import 'package:course_008/App/pages/index.dart';
import 'package:course_008/App/providers/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      EditPage.routeName,
                      arguments: EditPageArguments(
                        product: product,
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  iconSize: 20,
                  onPressed: () async {
                    bool isConfirmed = await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Confirm action'),
                        content: Text('Are you sure to delete \n${product.title}'),
                        actions: <Widget>[
                          FlatButton(
                            child: Text('Yes'),
                            onPressed: () => Navigator.of(context).pop(true),
                          ),
                          FlatButton(
                            color: Theme.of(context).primaryColor.withAlpha(64),
                            child: Text(
                              'No',
                              style: TextStyle(
                                color: Theme.of(context).primaryColorDark,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () => Navigator.of(context).pop(false),
                          ),
                        ],
                      ),
                    );
                    if (isConfirmed) {
                      // listen false to prevent to rebuild  this widget,
                      // upper widget is already consuming this provider.
                      Provider.of<ProductsProvider>(context, listen: false).deleteProduct(product);
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
