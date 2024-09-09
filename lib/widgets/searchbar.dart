import 'package:flutter/material.dart';

class MySearchBar extends StatelessWidget {
  const MySearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: SearchBar(
        shape: WidgetStatePropertyAll(
            ContinuousRectangleBorder(borderRadius: BorderRadius.circular(25))),
        backgroundColor: const WidgetStatePropertyAll(Color(0xFFF2F3F2)),
        hintText: "Search Store",
        leading: const Icon(Icons.search),
        elevation: const WidgetStatePropertyAll(0),
      ),
    );
  }
}
