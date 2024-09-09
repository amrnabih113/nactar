import 'package:flutter/material.dart';

class GroceriesContainer extends StatelessWidget {
  const GroceriesContainer(
      {super.key,
      required this.imageurl,
      required this.title,
      required this.color});
  final String imageurl;
  final String title;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      margin: EdgeInsets.all(8),
      width: 262.19,
      height: 105,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(18)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            imageurl,
            height: 71.9,
            width: 71.9,
          ),
          Container(
            width: 150,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff3E423F)),
            ),
          )
        ],
      ),
    );
  }
}
