import 'package:flutter/material.dart';

class Productinfo extends StatefulWidget {
  Productinfo(
      {super.key,
      required this.view,
      required this.title,
      required this.details, required this.widget});
  bool view;
  final String title;
  final String details;
  final Widget widget;

  @override
  State<Productinfo> createState() => _ProductinfoState();
}

class _ProductinfoState extends State<Productinfo> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.only(right: 25, left: 25, top: 10),
        child: GestureDetector(
          onTap: () {
            setState(() {
              widget.view = !widget.view;
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Row(
                children: [
                  widget.widget,
                  Icon(widget.view
                      ? Icons.keyboard_arrow_down
                      : Icons.keyboard_arrow_right),
                ],
              ),
            ],
          ),
        ),
      ),
      if (widget.view)
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: Text(
              widget.details,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Color(0xff7C7C7C),
              ),
            ))
    ]);
  }
}
