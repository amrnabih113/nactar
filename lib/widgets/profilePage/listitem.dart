import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  const ListItem(
      {super.key,
      required this.icon,
      required this.title,
      required this.onPressed});
  final IconData? icon;
  final String title;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        minTileHeight: 62,
        leading: Icon(
          icon,
          size: 25,
        ),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
        trailing: IconButton(
            onPressed: onPressed,
            icon: Icon(
              Icons.chevron_right,
              color: Colors.black,
            )),
      ),
    );
  }
}
