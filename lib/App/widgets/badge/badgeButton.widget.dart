import 'package:flutter/material.dart';

class BadgeButton extends StatelessWidget {
  BadgeButton({
    Key key,
    @required this.icon,
    @required this.text,
    this.onPressed,
  }) : super(key: key);

  final IconData icon;
  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 4,
      ),
      child: Material(
        borderRadius: BorderRadius.circular(4),
        color: Theme.of(context).primaryIconTheme.color,
        type: MaterialType.button,
        child: InkWell(
          onTap: onPressed,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Icon(
                  this.icon,
                  color: Theme.of(context).primaryColor,
                ),
                SizedBox(
                  width: 4,
                ),
                Text(
                  this.text,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
