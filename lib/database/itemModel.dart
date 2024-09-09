class Item {
  int id;
  String imageUrl;
  String title;
  double price;
  int categoryId;
  int rating;
  String description;

  Item({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.categoryId,
    required this.rating,
    required this.description,
  });
}

class CartItem {
  final int productId;
  final int quantity;

  CartItem({
    required this.productId,
    required this.quantity,
  });
}
