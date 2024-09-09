
import 'package:flutter/material.dart';
import 'package:nectar/database/lists.dart';
import 'package:nectar/screens/explorepage.dart';
import 'package:nectar/screens/productdetails.dart';

import 'package:nectar/services/providermodel.dart';
import 'package:nectar/widgets/HomePage/groceriescontainer.dart';
import 'package:nectar/widgets/HomePage/productcontainer.dart';
import 'package:provider/provider.dart';

class Topic2 extends StatelessWidget {
  const Topic2({
    super.key,
    required this.products,
    required this.title,
  });
  final String title;
  final List products;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 25,
      ),
      child: SizedBox(
        height: 442.51,
        width: 549.92,
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ExplorePage()));
                  },
                  child: const Text(
                    "See all",
                    style: TextStyle(color: Color(0xff53B175), fontSize: 16),
                  ),
                )
              ],
            ),
            SizedBox(
                height: 120,
                child: Consumer<Model>(builder: (context, model, child) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: model.categories.length,
                    itemBuilder: (context, i) {
                      return GroceriesContainer(
                          imageurl: model.categories[i]["image_url"],
                          title: model.categories[i]["name"],
                          color: colors[i % colors.length]);
                    },
                  );
                })),
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
                                builder: (context) => ProductDetails(
                                      product: products[i],
                                    )));
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
