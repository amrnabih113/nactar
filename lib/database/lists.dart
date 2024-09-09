import 'package:flutter/material.dart';

// List<Item> offers = [
//   Item(
//       imageurl: "images/apple.png",
//       title: "Red Apple",
//       price: 4.99,
//       quantity: "1kg, Priceg"),
//   Item(
//       imageurl: "images/banana.webp",
//       title: "Organic bananas",
//       price: 4.99,
//       quantity: "1kg, Priceg"),
//   Item(
//       imageurl: "images/Bell_Pepper_Red.png",
//       title: "Bell Pepper Red",
//       price: 5.99,
//       quantity: "1kg, Priceg"),
//   Item(
//       imageurl: "images/ginger.png",
//       title: "Ginger",
//       price: 8.99,
//       quantity: "1kg, Priceg")
// ];

// List<Item> bestselling = [
//   Item(
//       imageurl: "images/Bell_Pepper_Red.png",
//       title: "Bell Pepper Red",
//       price: 5.99,
//       quantity: "1kg, Priceg"),
//   Item(
//       imageurl: "images/ginger.png",
//       title: "Ginger",
//       price: 8.99,
//       quantity: "1kg, Priceg"),
//   Item(
//       imageurl: "images/apple.png",
//       title: "Red Apple",
//       price: 4.99,
//       quantity: "1kg, Priceg"),
//   Item(
//       imageurl: "images/banana.webp",
//       title: "Organic bananas",
//       price: 4.99,
//       quantity: "1kg, Priceg")
// ];

// List<Item> grocery = [
//   Item(
//       imageurl: "images/beef.png",
//       title: "Beef",
//       price: 5.99,
//       quantity: "1kg, Priceg"),
//   Item(
//       imageurl: "images/checken.png",
//       title: "Checken",
//       price: 3.99,
//       quantity: "1kg, Priceg"),
//   Item(
//       imageurl: "images/fish.png",
//       title: "salmon",
//       price: 3.99,
//      quantity: "1kg, Priceg"),
// ];


// List categories = [
//   {"imageurl": "images/veges.png", "title": " Fresh Fruits & Vegetables "},
//   {"imageurl": "images/oils.png", "title": " Cooking Oils & Ghee"},
//   {"imageurl": "images/meats.png", "title": "Meat & Fish"},
//   {"imageurl": "images/bread.png", "title": "Bakery & Snacks"},
//   {"imageurl": "images/dairy.png", "title": "Dairy & Eggs"},
//   {"imageurl": "images/drinks.png", "title": "Beverages"},
//   {"imageurl": "images/meats.png", "title": "Meats"},
//   {"imageurl": "images/pulses.png", "title": "Pulses"},
//   {"imageurl": "images/rice.png", "title": "Rice"},
// ];

  // Future<void> insertAllData() async {
  //   // try {
  //   //   // Insert Categories
  //   //   String categoriesSql =
  //   //       "INSERT INTO Categories (name, image_url) VALUES (?, ?)";
  //   //   List<List<dynamic>> categories = [
  //   //     ['Fresh Fruits & Vegetables', 'images/veges.png'],
  //   //     ['Cooking Oils & Ghee', 'images/oils.png'],
  //   //     ['Meat & Fish', 'images/meats.png'],
  //   //     ['Bakery & Snacks', 'images/bread.png'],
  //   //     ['Dairy & Eggs', 'images/dairy.png'],
  //   //     ['Beverages', 'images/drinks.png'],
  //   //     ['Meats', 'images/meats.png'],
  //   //     ['Pulses', 'images/pulses.png'],
  //   //     ['Rice', 'images/rice.png']
  //   //   ];

  //   //   for (var category in categories) {
  //   //     await Mydb.insert(categoriesSql, category);
  //   //   }
  //   //   print("Categories inserted successfully.");

  //   //   // Insert Products
  //   //   String productsSql =
  //   //       "INSERT INTO Products (image_url, name, price, category_id, rating, description) VALUES (?, ?, ?, ?, ?, ?)";
  //   //   List<List<dynamic>> products = [
  //   //     ['images/apple.png', 'Red Apple', 4.99, 1, 5, 'A fresh red apple'],
  //   //     [
  //   //       'images/banana.webp',
  //   //       'Organic Bananas',
  //   //       4.99,
  //   //       1,
  //   //       4,
  //   //       'Organic bananas, sweet and ripe'
  //   //     ],
  //   //     [
  //   //       'images/Bell_Pepper_Red.png',
  //   //       'Bell Pepper Red',
  //   //       5.99,
  //   //       1,
  //   //       4,
  //   //       'Fresh red bell pepper'
  //   //     ],
  //   //     ['images/ginger.png', 'Ginger', 8.99, 1, 5, 'Spicy fresh ginger']
  //   //   ];

  //   //   for (var product in products) {
  //   //     await Mydb.insert(productsSql, product);
  //   //   }
  //   //   print("Products inserted successfully.");

  //   //   // Insert Offers
  //   //   String offersSql = "INSERT INTO Offers (product_id) VALUES (?)";
  //   //   List<int> offerProductIds = [1, 2, 3, 4];

  //   //   for (var id in offerProductIds) {
  //   //     await Mydb.insert(offersSql, [id]);
  //   //   }
  //   //   print("Offers inserted successfully.");

  //   //   // Insert BestSelling
  //   //   String bestSellingSql = "INSERT INTO BestSelling (product_id) VALUES (?)";
  //   //   List<int> bestSellingProductIds = [3, 4, 1, 2];

  //   //   for (var id in bestSellingProductIds) {
  //   //     await Mydb.insert(bestSellingSql, [id]);
  //   //   }
  //   //   print("BestSelling items inserted successfully.");
  //   // } catch (e) {
  //   //   print("Error inserting data: ${e.toString()}");
  //   // }
  //   String productsSql =
  //       "INSERT INTO Products (image_url, name, price, category_id, rating, description) VALUES (?, ?, ?, ?, ?, ?)";
  //   List<List<dynamic>> products = [
  //     ['images/beef.png', 'Beef', 5.99, 3, 5, '1kg'],
  //     ['images/checken.png', 'Checken', 3.99, 3, 5, '1kg'],
  //     ['images/fish.png', 'Salmon', 3.99, 3, 5, '1kg']
  //   ];

  //   for (var product in products) {
  //     await Mydb.insert(productsSql, product);
  //   }
  //   setState(() {});
  // }
List<Color> colors = [
  Color(0xffE5F3EA),
  Color(0xfffef1e4),
  Color(0xfffde9e4),
  Color(0xfff4ebf7),
  Color(0xfffef9e5),
  Color(0xffedf7fd),
];
List outliecolors = [
  Color(0xffabd9bb),
  Color(0xffdbbd98),
  Color(0xffd9abab),
  Color(0xffbeb4e5),
  Color(0xffdddcae),
  Color(0xffa8d7f4),
];

