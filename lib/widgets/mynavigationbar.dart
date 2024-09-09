import 'package:flutter/material.dart';

class Mynavigationbar extends StatefulWidget {
  Mynavigationbar(
      {super.key, required this.selectedindex, required this.onItemTapped});
  int selectedindex;
  final ValueChanged<int> onItemTapped;
  @override
  State<Mynavigationbar> createState() => _MynavigationbarState();
}

class _MynavigationbarState extends State<Mynavigationbar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.store_outlined),
          label: "Shop",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.manage_search_rounded),
          label: "Explore",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart_outlined),
          label: "Cart",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_outline),
          label: "Favourite",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outlined),
          label: "Account",
        )
      ],
      currentIndex: widget.selectedindex,
      onTap: widget.onItemTapped,
      selectedItemColor: const Color(0xff53B175),
      unselectedItemColor: const Color(0xff181725),
      showUnselectedLabels: true,
      elevation: 5,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
    );
  }
}
