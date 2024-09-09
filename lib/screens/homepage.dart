import 'package:flutter/material.dart';
import 'package:nectar/services/providermodel.dart';
import 'package:nectar/widgets/searchbar.dart';
import 'package:nectar/widgets/HomePage/topic.dart';
import 'package:nectar/widgets/HomePage/topic2.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String location = "Mansoura, Dakahlia";
  int selectedindex = 0;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<Model>(context, listen: false).getData();
     // Provider.of<Model>(context, listen: false).clearusers();
    });
   // print("users deleted");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "images/logo_colored.png",
              width: 26.48,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.location_pin,
                  size: 15,
                ),
                Text(
                  location,
                  style: const TextStyle(fontSize: 18),
                )
              ],
            )
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: ListView(
          children: [
            const MySearchBar(),
            SizedBox(
              height: 114.99,
              width: 368.2,
              child: Image.asset("images/ads.png"),
            ),
            Consumer<Model>(builder: (context, model, child) {
              return Topic(
                products: model.offers,
                title: "Exclusive Offer",
              );
            }),
            Consumer<Model>(builder: (context, model, child) {
              return Topic(
                products: model.bestselling,
                title: "Best Selling",
              );
            }),
            Consumer<Model>(builder: (context, model, child) {
              return Topic2(
                products: model.products,
                title: "Groceries",
              );
            }),
          ],
        ),
      ),
    );
  }
}
