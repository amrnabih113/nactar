import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nectar/database/database.dart';
import 'package:nectar/database/itemModel.dart';

class Model with ChangeNotifier {
  SqlDb Mydb = SqlDb();

  List<CartItem> cartitems = [];
  List<Item> cartproducts = [];
  List<Item> offers = [];
  List<Item> bestselling = [];
  List<Item> products = [];
  List<Item> favorites = []; // List for favorite products
  List categories = [];
  List categoriesproducts = [];

  String firebaseemail = FirebaseAuth.instance.currentUser!.email!;
  int? userid;

  // Get user ID by Firebase ID
  Future<void> getuserid() async {
    try {
      var users = await Mydb.getdata(
        "SELECT * FROM Users WHERE email = ?",
        [firebaseemail],
      );
      if (users.isNotEmpty) {
        userid = users[0]['id'];
      } else {
        print('User not found in database');
        userid = null;
      }
    } catch (e) {
      print("Error getting user ID: ${e.toString()}");
    }
  }

  // Fetch categories
  Future<void> getCategories() async {
    try {
      categories = await Mydb.getdata("SELECT * FROM Categories");
      notifyListeners();
    } catch (e) {
      print("Error getting categories: ${e.toString()}");
    }
  }

  // Fetch products
  Future<void> getProducts() async {
    try {
      var productsdata = await Mydb.getdata("SELECT * FROM Products");
      products = productsdata.map<Item>((item) {
        return Item(
          id: item['id'],
          imageUrl: item['image_url'],
          title: item['name'],
          price: item['price'],
          categoryId: item['category_id'],
          rating: item['rating'],
          description: item['description'],
        );
      }).toList();
      notifyListeners();
    } catch (e) {
      print("Error getting products: ${e.toString()}");
    }
  }

  // Fetch offers
  Future<void> getOffers() async {
    try {
      var offersData = await Mydb.getdata("""
        SELECT Products.* FROM Offers
        JOIN Products ON Offers.product_id = Products.id
      """);
      offers = offersData.map<Item>((item) {
        return Item(
          id: item['id'],
          imageUrl: item['image_url'],
          title: item['name'],
          price: item['price'],
          categoryId: item['category_id'],
          rating: item['rating'],
          description: item['description'],
        );
      }).toList();
      notifyListeners();
    } catch (e) {
      print("Error getting offers: ${e.toString()}");
    }
  }

  // Fetch best-selling products
  Future<void> getBestSelling() async {
    try {
      var bestSellingData = await Mydb.getdata("""
        SELECT Products.* FROM BestSelling
        JOIN Products ON BestSelling.product_id = Products.id
      """);
      bestselling = bestSellingData.map<Item>((item) {
        return Item(
          id: item['id'],
          imageUrl: item['image_url'],
          title: item['name'],
          price: item['price'],
          categoryId: item['category_id'],
          rating: item['rating'],
          description: item['description'],
        );
      }).toList();
      notifyListeners();
    } catch (e) {
      print("Error getting best-selling products: ${e.toString()}");
    }
  }

  // Fetch favorites
  Future<void> getFavorites() async {
    if (userid == null) {
      await getuserid();
    }
    if (userid != null) {
      try {
        var favoritesData = await Mydb.getdata("""
          SELECT Products.* FROM Favorites
          JOIN Products ON Favorites.product_id = Products.id
          WHERE Favorites.user_id = ?
        """, [userid]);
        favorites = favoritesData.map<Item>((item) {
          return Item(
            id: item['id'],
            imageUrl: item['image_url'],
            title: item['name'],
            price: item['price'],
            categoryId: item['category_id'],
            rating: item['rating'],
            description: item['description'],
          );
        }).toList();
        notifyListeners();
      } catch (e) {
        print("Error getting favorites: ${e.toString()}");
      }
    } else {
      print("User ID is null, cannot fetch favorites.");
    }
  }

  // Add item to favorites
  Future<void> addToFavorites(int productId) async {
    if (userid == null) {
      await getuserid();
    }
    if (userid != null) {
      try {
        int response = await Mydb.insert(
          "INSERT INTO Favorites (user_id, product_id) VALUES (?, ?)",
          [userid, productId],
        );
        print('Favorite insert response: $response');
        await getFavorites(); // Refresh the favorites list
        notifyListeners();
      } catch (e) {
        print("Error adding to favorites: ${e.toString()}");
      }
    } else {
      print("User ID is null. Cannot add to favorites.");
    }
  }

  // Remove item from favorites
  Future<void> removeFromFavorites(int productId) async {
    if (userid == null) {
      await getuserid();
    }
    if (userid != null) {
      try {
        int response = await Mydb.delete(
          "DELETE FROM Favorites WHERE product_id = ? AND user_id = ?",
          [productId, userid],
        );
        print('Favorite delete response: $response');
        await getFavorites(); // Refresh the favorites list
        notifyListeners();
      } catch (e) {
        print("Error removing from favorites: ${e.toString()}");
      }
    } else {
      print("User ID is null. Cannot remove from favorites.");
    }
  }

  // Fetch cart items
  Future<void> getCartItems() async {
    if (userid == null) {
      await getuserid();
    }
    if (userid != null) {
      try {
        cartitems = [];
        cartproducts = [];
        var cartdata = await Mydb.getdata(
            "SELECT * FROM Cart WHERE user_id = ?", [userid]);
        if (cartdata.isNotEmpty) {
          cartitems = cartdata.map<CartItem>((item) {
            return CartItem(
              productId: item['product_id'],
              quantity: item['quantity'],
            );
          }).toList();
          var productIds =
              cartitems.map((cartItem) => cartItem.productId).toList();
          String placeholders = List.filled(productIds.length, '?').join(',');
          var cartProductsData = await Mydb.getdata(
            "SELECT * FROM Products WHERE id IN ($placeholders)",
            productIds,
          );
          cartproducts = cartProductsData.map<Item>((item) {
            return Item(
              id: item['id'],
              imageUrl: item['image_url'],
              title: item['name'],
              price: item['price'],
              categoryId: item['category_id'],
              rating: item['rating'],
              description: item['description'],
            );
          }).toList();
        }
        notifyListeners();
      } catch (e) {
        print("Error getting cart items: ${e.toString()}");
      }
    } else {
      print("User ID is null. Cannot fetch cart items.");
    }
  }

  // Add item to cart
  Future<void> addToCart(BuildContext context, int productId, int quantity,
      String productname) async {
    if (userid == null) {
      await getuserid();
    }
    if (userid != null) {
      try {
        final List<Map<String, dynamic>> existingItem = await Mydb.getdata(
          "SELECT quantity FROM Cart WHERE user_id = ? AND product_id = ?",
          [userid, productId],
        );
        if (existingItem.isNotEmpty) {
          final int newQuantity = existingItem.first['quantity'] + quantity;
          await Mydb.update(
            "UPDATE Cart SET quantity = ? WHERE user_id = ? AND product_id = ?",
            [newQuantity, userid, productId],
          );
        } else {
          await Mydb.insert(
            "INSERT INTO Cart (user_id, product_id, quantity) VALUES (?, ?, ?)",
            [userid, productId, quantity],
          );
        }
        print('Cart update successful');
        await getCartItems();
        notifyListeners();
        _showAddedToCartMessage(
            context, productname, quantity); // Show the message
      } catch (e) {
        print("Error adding to cart: ${e.toString()}");
      }
    } else {
      print("User ID is null. Cannot add to cart.");
    }
  }

  // Update cart item quantity
  Future<void> updateCartItemQuantity(int productId, int newQuantity) async {
    if (userid == null) {
      await getuserid();
    }
    if (userid != null) {
      try {
        if (newQuantity <= 0) {
          await Mydb.delete(
            "DELETE FROM Cart WHERE product_id = ? AND user_id = ?",
            [productId, userid],
          );
        } else {
          await Mydb.update(
            "UPDATE Cart SET quantity = ? WHERE user_id = ? AND product_id = ?",
            [newQuantity, userid, productId],
          );
        }
        await getCartItems();
        notifyListeners();
      } catch (e) {
        print("Error updating cart item quantity: ${e.toString()}");
      }
    } else {
      print("User ID is null. Cannot update cart.");
    }
  }

  Future<void> getData() async {
    await Future.wait([
      getCategories(),
      getProducts(),
      getOffers(),
      getBestSelling(),
      getCartItems(),
      getFavorites(),
    ]);
  }

  Future<void> clearusers() async {
    await Mydb.delete(
      "DELETE FROM Users",
    );
  }

  Future<void> clearCart() async {
    if (userid == null) {
      await getuserid();
    }
    if (userid != null) {
      await Mydb.delete("DELETE FROM Cart WHERE user_id = ?", [userid]);
      cartitems.clear();
      cartproducts.clear();
      notifyListeners();
    }
  }

  bool isItemInFavorites(int productId) {
    return favorites.any((item) => item.id == productId);
  }

  double getTotalCartPrice() {
    double totalPrice = 0;
    for (int i = 0; i < cartitems.length; i++) {
      totalPrice += cartitems[i].quantity * cartproducts[i].price;
    }
    return totalPrice;
  }

  Future<void> removeFromCart(int productId) async {
    if (userid == null) {
      await getuserid();
    }
    if (userid != null) {
      await Mydb.delete("DELETE FROM Cart WHERE product_id = ? AND user_id = ?",
          [productId, userid]);
      await getCartItems();
      notifyListeners();
    }
  }

  // Helper to show added to cart message
  void _showAddedToCartMessage(
      BuildContext context, String productname, int quantity) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("$quantity x $productname added to cart"),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
