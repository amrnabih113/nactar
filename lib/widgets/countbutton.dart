import 'package:flutter/material.dart';

class CountButton extends StatefulWidget {
  CountButton(
      {super.key, required this.quantity, required this.onQuantityChanged});
  final int quantity;
  final ValueChanged<int> onQuantityChanged;

  @override
  State<CountButton> createState() => _CountButtonState();
}

class _CountButtonState extends State<CountButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            widget.onQuantityChanged(widget.quantity - 1);
          },
          icon: const Icon(Icons.remove),
        ),
        Container(
          width: 45.67,
          height: 45.67,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(17),
            border: Border.all(
              width: 2,
              style: BorderStyle.solid,
              color: const Color(0xffE2E2E2),
            ),
          ),
          child: Center(
            child: Text(
              "${widget.quantity}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            widget.onQuantityChanged(widget.quantity + 1);
          },
          icon: const Icon(
            Icons.add,
            color: Color(0xff53B175),
          ),
        ),
      ],
    );
  }
}
