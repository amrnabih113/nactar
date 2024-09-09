import 'package:flutter/material.dart';

class SocialMediaButton extends StatelessWidget {
  SocialMediaButton(
      {super.key,
      this.onTap,
      required this.imagename,
      required this.color,
      this.imagecolor});
  final void Function()? onTap;
  final String imagename;
  final Color color;
  Color? imagecolor = null;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        height: 55,
        width: 55,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                  color: Color.fromARGB(50, 0, 0, 0), offset: Offset(-2, 6))
            ]),
        child: Image.asset(
          'images/$imagename',
          color: imagecolor,
        ),
      ),
    );
  }
}
