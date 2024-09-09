import 'package:flutter/material.dart';
import 'package:nectar/database/itemModel.dart';
import 'package:nectar/screens/checkout.dart';
import 'package:nectar/services/providermodel.dart';
import 'package:nectar/widgets/Custombutton.dart';
import 'package:nectar/widgets/countbutton.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<Model>().getCartItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Cart",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        shape: Border.symmetric(
          horizontal: BorderSide(width: 0.5, color: Color(0xff7C7C7C)),
        ),
      ),
      body: Consumer<Model>(builder: (context, model, child) {
        double totalprice = model.getTotalCartPrice();
        return model.cartproducts.isEmpty
            ? Center(child: Text("Your cart is empty"))
            : Column(
                children: [
                  SizedBox(
                    height: 590,
                    child: ListView.builder(
                      itemCount: model.cartproducts.length,
                      itemBuilder: (context, i) {
                        final product = model.cartproducts[i];
                        final cartItem = model.cartitems.firstWhere(
                          (item) => item.productId == product.id,
                          orElse: () =>
                              CartItem(productId: product.id, quantity: 1),
                        );
                        var quantity = cartItem.quantity;

                        // Calculate the total price for the individual product
                        double productTotalPrice = product.price * quantity;

                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Card(
                              child: Container(
                                width: double.infinity,
                                height: 150,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 25),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Image.asset(
                                      product.imageUrl,
                                      width: 86.74,
                                      height: 86.74,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
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
                                              "1Kg, Price",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xff7C7C7C)),
                                            ),
                                          ],
                                        ),
                                        CountButton(
                                          quantity: quantity,
                                          onQuantityChanged: (newQuantity) {
                                            setState(() {
                                              if (newQuantity > 0) {
                                                model.updateCartItemQuantity(
                                                    product.id, newQuantity);
                                              } else {
                                                model
                                                    .removeFromCart(product.id);
                                              }
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              model.removeFromCart(product.id);
                                            });
                                          },
                                          icon: Icon(Icons.close),
                                        ),
                                        Text(
                                          "\$${productTotalPrice.toStringAsFixed(2)}",
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Stack(
                    alignment: Alignment(0.7, 0),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25.0, vertical: 20),
                        child: Custombutton(
                            title: "Go to Checkout",
                            onPressed: () {
                              
                              showModalBottomSheet(
                                context: context,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20),
                                  ),
                                ),
                                builder: (context) =>
                                    const CheckoutBottomSheet(),
                              );
                            }),
                      ),
                      Container(
                        height: 22,
                        width: 55,
                        decoration: BoxDecoration(
                            color: Color(0xff489E67),
                            borderRadius: BorderRadius.circular(4)),
                        child: Text(
                          "\$${totalprice.toStringAsFixed(2)}", // Display the updated total price
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: Colors.white),
                        ),
                      )
                    ],
                  )
                ],
              );
      }),
    );
  }
}
