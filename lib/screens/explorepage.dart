import 'package:flutter/material.dart';

import 'package:nectar/database/itemModel.dart';
import 'package:nectar/database/lists.dart';
import 'package:nectar/screens/products.dart';
import 'package:nectar/services/providermodel.dart';
import 'package:nectar/widgets/searchbar.dart';
import 'package:provider/provider.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Find Products",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: ListView(
          children: [
            const MySearchBar(),
            const SizedBox(height: 20),
            Consumer<Model>(builder: (context, model, child) {
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                ),
                itemCount: model
                    .categories.length, // Set your actual number of items here
                itemBuilder: (context, i) {
                  return InkWell(
                    onTap: () async {
                      try {
                        var productsdata = await model.Mydb.getdata(
                            "SELECT DISTINCT Products.* FROM Products JOIN Categories ON ${model.categories[i]['id']} = Products.category_id ");

                        model.categoriesproducts = productsdata
                            .map<Item>((item) => Item(
                                id: item['id'],
                                imageUrl: item['image_url'],
                                title: item['name'],
                                price: item['price'],
                                categoryId: item['category_id'],
                                rating: item['rating'],
                                description: item['description']))
                            .toList();
                      } catch (e) {
                        print(e);
                      }
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Products(
                                  products: model.categoriesproducts,
                                  title: model.categories[i]["name"])));
                      print(
                          "products length= ${model.categoriesproducts.length} ===============================");
                    },
                    child: Container(
                      height: 198.11,
                      width: 174.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(17),
                        border: Border.all(
                            width: 2,
                            color: outliecolors[i % outliecolors.length]),
                        color: colors[i % colors.length],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            model.categories[i]["image_url"],
                            width: 111.38,
                            height: 74.9,
                          ),
                          SizedBox(
                            height: 27,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 35.0),
                            child: Text(
                              model.categories[i]["name"],
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            })
          ],
        ),
      ),
    );
  }
}
