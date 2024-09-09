import 'package:flutter/material.dart';
import 'package:nectar/database/itemModel.dart';
import 'package:nectar/services/providermodel.dart';
import 'package:nectar/widgets/Custombutton.dart';
import 'package:nectar/widgets/ProductDetails/Mydivider.dart';
import 'package:nectar/widgets/ProductDetails/productinfo.dart';
import 'package:nectar/widgets/ProductDetails/productname.dart';
import 'package:nectar/widgets/ProductDetails/productphoto.dart';
import 'package:nectar/widgets/ProductDetails/productprice.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  ProductDetails({
    super.key,
    required this.product,
  });
  Item product;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int quantity = 1;
  bool viewdetails = false;
  bool viewnutritions = false;
  bool viewreview = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductPhoto(imageurl: widget.product.imageUrl),
            ProductName(
              name: widget.product.title,
              productId: widget.product.id,
            ),
            ProductPrice(
              quantity: quantity,
              price: widget.product.price,
              onQuantityChanged: (newQuantity) {
                setState(() {
                  quantity = newQuantity;
                });
              },
            ),
            MyDivider(),
            Productinfo(
              widget: Text(""),
              view: viewdetails,
              title: "Product Details",
              details: widget.product.description,
            ),
            MyDivider(),
            Productinfo(
              view: viewnutritions,
              title: "Nutritions",
              details: "",
              widget: Container(
                width: 33.61,
                height: 18,
                decoration: BoxDecoration(
                    color: Color(0xffEBEBEB),
                    borderRadius: BorderRadius.circular(5)),
                child: Center(
                  child: Text(
                    "100gr",
                    style: TextStyle(
                        color: Color(0xff7C7C7C),
                        fontSize: 9,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            MyDivider(),
            Productinfo(
              view: viewreview,
              title: "Review",
              details: "",
              widget: SizedBox(
                width: 93,
                height: 14,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (contex, i) {
                    return const Icon(Icons.star,
                        color: Color(0xffF3603F), size: 18);
                  },
                  itemCount: 5,
                ),
              ),
            ),
            Consumer<Model>(builder: (context, model, child) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20),
                child: Custombutton(
                  title: "Add To Basket",
                  onPressed: () {
                    print(quantity);
                    model.addToCart(context, widget.product.id, quantity, widget.product.title);
                  },
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
