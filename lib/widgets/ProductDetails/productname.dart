import 'package:flutter/material.dart';
import 'package:nectar/services/providermodel.dart';
import 'package:provider/provider.dart';

class ProductName extends StatelessWidget {
  const ProductName({super.key, required this.name, required this.productId});
  final String name;
  final productId;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(right: 25, left: 25, top: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Consumer<Model>(
                builder: (context, model, child) {
                  // Check if the product is in favorites
                  bool isFavorite = model.isItemInFavorites(productId);

                  return InkWell(
                    onTap: () {
                      if (isFavorite) {
                        model.removeFromFavorites(productId);
                      } else {
                        model.addToFavorites(productId);
                      }
                    },
                    child: Icon(
                      isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border_outlined,
                      size: 25,
                      color: isFavorite ? Colors.red : Colors.grey,
                    ),
                  );
                },
              )
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(right: 25, left: 25),
          child: Text(
            "1kg, Priceg",
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 16,
              color: Color(0xff7C7C7C),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
