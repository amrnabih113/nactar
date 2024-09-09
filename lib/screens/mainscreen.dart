import 'package:flutter/material.dart';
import 'package:nectar/screens/cartpage.dart';
import 'package:nectar/screens/explorepage.dart';
import 'package:nectar/screens/favouratespage.dart';
import 'package:nectar/screens/homepage.dart';
import 'package:nectar/screens/profilepage.dart';
import 'package:nectar/widgets/mynavigationbar.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // List of pages to navigate between
  final List<Widget> _pages = [
    const Homepage(),
    const ExplorePage(),
    const CartPage(),
    const FavouratesPage(),
    const ProfilePage()
  ];

  // Handles bottom navigation bar taps
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // Display the selected page
      bottomNavigationBar: Mynavigationbar(
        selectedindex: _selectedIndex,
        onItemTapped: _onItemTapped, // Handle taps and update the selected page
      ),
    );
  }
}
