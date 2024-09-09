import 'package:flutter/material.dart';

class MyDivider extends StatelessWidget {
  const MyDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: const Divider(
                color: Color(0xe2e2e2b2),
              ),
            );
  }
}