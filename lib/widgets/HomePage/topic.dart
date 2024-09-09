import 'package:flutter/material.dart';
import 'package:nectar/screens/productdetails.dart';
import 'package:nectar/screens/products.dart';
import 'package:nectar/widgets/HomePage/productcontainer.dart';

class Topic extends StatelessWidget {
  const Topic({
    super.key,
    required this.products,
    required this.title,
  });
  final String title;
  final List products;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: SizedBox(
        height: 298.05,
        width: 289.29,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Products(
                            products: products,
                            title: title,
                          ),
                        ));
                  },
                  child: const Text(
                    "See all",
                    style: TextStyle(color: Color(0xff53B175), fontSize: 16),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 255.51,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: products.length,
                  itemBuilder: (context, i) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ProductDetails(product: products[i])));
                      },
                      child: ProductContainer(
                        product: products[i],
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
