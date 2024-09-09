import 'package:flutter/material.dart';
import 'package:nectar/screens/productdetails.dart';
import 'package:nectar/screens/products.dart';
import 'package:nectar/services/providermodel.dart';
import 'package:nectar/widgets/Custombutton.dart';
import 'package:provider/provider.dart';

class FavouratesPage extends StatefulWidget {
  const FavouratesPage({super.key});

  @override
  State<FavouratesPage> createState() => _FavouratesPageState();
}

class _FavouratesPageState extends State<FavouratesPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<Model>().getFavorites();
    });
  }

  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Success',
            style: TextStyle(
                color: Color(0xff53B175),
                fontSize: 30,
                fontWeight: FontWeight.bold),
          ),
          content: Text(message,
              style: TextStyle(
                fontSize: 18,
              )),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Container(
                height: 40,
                width: 60,
                decoration: BoxDecoration(
                    color: Color(0xff53B175),
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    'OK',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Favorites",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        shape: Border.symmetric(
          horizontal: BorderSide(width: 0.5, color: Color(0xff7C7C7C)),
        ),
      ),
      body: Consumer<Model>(builder: (context, model, child) {
        return model.favorites.isEmpty
            ? Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "You Have No Favorites",
                    style: TextStyle(
                        color: Color(0xFF53B175),
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  Consumer<Model>(builder: (context, model, child) {
                    return Padding(
                      padding: const EdgeInsets.all(45),
                      child: Custombutton(
                          title: "Add Favorites",
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Products(
                                      products: model.products,
                                      title: "All Products"),
                                ));
                          }),
                    );
                  })
                ],
              ))
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: model.favorites.length,
                      itemBuilder: (context, i) {
                        final product = model.favorites[i];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ProductDetails(product: product)));
                          },
                          child: Card(
                            child: Container(
                              padding: EdgeInsets.all(10),
                              height: 114,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        product.imageUrl,
                                        height: 80,
                                        width: 80,
                                      ),
                                      SizedBox(
                                        width: 42,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            product.title,
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "1Kg , Price",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xff7C7C7C)),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "\$${product.price}",
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      IconButton(
                                          onPressed: () {},
                                          icon: Icon(Icons.chevron_right))
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25.0, vertical: 20),
                    child: Custombutton(
                      title: "Add All To Cart",
                      onPressed: () {
                        for (var product in model.favorites) {
                          model.addToCart(context, product.id, 1,
                              product.title); // Adjust quantity if needed
                        }
                        _showDialog("Added to Cart");
                      },
                    ),
                  ),
                ],
              );
      }),
    );
  }
}
