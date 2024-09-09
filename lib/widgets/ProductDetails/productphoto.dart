import 'package:flutter/material.dart';

class ProductPhoto extends StatelessWidget {
  const ProductPhoto({super.key, required this.imageurl});
  final String imageurl;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          width: double.infinity, // Make it take full screen width
          height: 371.44,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
            color: Color(0xfff2F3F2),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(35, 0, 0, 0),
                offset: Offset(0, 6),
              ),
            ],
          ),
        ),
        Image.asset(
          imageurl,
          width: 329.34,
          height: 199.18,
          fit: BoxFit.contain,
        ),
      ],
    );
  }
}
