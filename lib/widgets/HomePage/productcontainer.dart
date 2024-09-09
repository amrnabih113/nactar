import 'package:flutter/material.dart';
import 'package:nectar/database/itemModel.dart';
import 'package:nectar/services/providermodel.dart';
import 'package:provider/provider.dart';

class ProductContainer extends StatelessWidget {
  const ProductContainer({
    super.key,
    required this.product,
  });
  final Item product;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
            margin: const EdgeInsets.only(top: 10, right: 15),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 2, color: Color(0xffe2e2e2)),
                borderRadius: BorderRadius.circular(18),
                boxShadow: const [
                  BoxShadow(
                      blurRadius: 12,
                      offset: Offset(0, 6),
                      spreadRadius: 0,
                      color: Color.fromARGB(10, 0, 0, 0))
                ]),
            height: 250.51,
            width: 173.32,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      product.imageUrl,
                      height: 62.56,
                      width: 103.43,
                    ),
                  ),
                  const SizedBox(
                    height: 33.7,
                  ),
                  Text(
                    product.title,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xff181725)),
                  ),
                  Text(
                    "1kg, Priceg",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 14, color: Color(0xff7C7C7C)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$${product.price}",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                      Consumer<Model>(builder: (context, model, child) {
                        return TextButton(
                          onPressed: () {
                            model.addToCart(context, product.id, 1,
                                product.title);
                          },
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                                const Color(0xff53B175)),
                            shape: WidgetStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(17),
                              ),
                            ),
                            minimumSize: WidgetStateProperty.all(
                                Size(45.67, 45.67)), // Minimum size

                            padding: WidgetStateProperty.all(EdgeInsets.zero),
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        );
                      })
                    ],
                  )
                ],
              ),
            )),
        Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          height: 50,
          width: 50,
          child: Consumer<Model>(
            builder: (context, model, child) {
              // Check if the product is in favorites
             bool isFavorite = model.isItemInFavorites(product.id);
              return InkWell(
                onTap: () async {
                  if (isFavorite) {
                    await model.removeFromFavorites(product.id);
                  } else {
                    await model.addToFavorites(product.id);
                  }
                },
                child: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border_outlined,
                  size: 25,
                  color: isFavorite ? Colors.red : Colors.grey,
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
