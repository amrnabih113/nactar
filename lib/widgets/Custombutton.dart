import 'package:flutter/material.dart';

class Custombutton extends StatefulWidget {
  Custombutton(
      {super.key, required this.title, required this.onPressed, this.theme});
  final String title;
  void Function()? onPressed;
  final String? theme;

  @override
  State<Custombutton> createState() => _CustombuttonState();
}

class _CustombuttonState extends State<Custombutton> {
  Color getButtonColor() {
    if (widget.theme == "theme1") {
      return const Color(0xff53B175);
    } else if (widget.theme == "theme2") {
      return Colors.white;
    } else if (widget.theme == "theme3") {
      return Colors.transparent;
    }
    return Color(0xff53B175); // Default color
  }

  Color getTextColor() {
    if (widget.theme == "theme1") {
      return Colors.white;
    } else if (widget.theme == "theme2") {
      return Color(0xff53B175);
    } else if (widget.theme == "theme3") {
      return Colors.black; // Example color for theme 3
    }
    return Colors.white; // Default color
  }

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 0,
      onPressed: widget.onPressed,
      shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(35)),
      color: getButtonColor(), // Use the color here
      minWidth: double.infinity,
      height: 67,
      child: Text(
        widget.title,
        style: TextStyle(
            fontWeight: FontWeight.w600, fontSize: 18, color: getTextColor()),
      ),
    );
  }
}
