import 'package:flutter/material.dart';
import 'package:nectar/screens/productdetails.dart';
import 'package:nectar/widgets/HomePage/productcontainer.dart';

class Products extends StatelessWidget {
  const Products({super.key, required this.products, required this.title});
  final List products;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new)),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.filter_list,
                size: 27,
              ))
        ],
        centerTitle: true,
      ),
      body: products.isEmpty
          ? Center(
              child: Text("No Poducts avilable for now!"),
            )
          : CustomScrollView(
              slivers: [
                SliverPadding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,

                      childAspectRatio:
                          0.7, // Adjust this to control item height
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, i) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return ProductDetails(product: products[i]);
                            }));
                          },
                          child: ProductContainer(
                            product: products[i],
                          ),
                        );
                      },
                      childCount: products.length,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
