import 'package:flutter/material.dart';
import 'package:nectar/screens/mainscreen.dart';
import 'package:nectar/widgets/Custombutton.dart';

class OrderSuccess extends StatelessWidget {
  const OrderSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(25),
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage("images/background.png"))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "images/correctlogo.png",
              width: 269.08,
              height: 240.031,
            ),
            const SizedBox(
              height: 66.67,
            ),
            const SizedBox(
              width: 280,
              child: Column(
                children: [
                  Text(
                    "Your Order has been accepted",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Your items has been placcd and is on it’s way to being processed",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff7C7C7C)),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 134.83,
            ),
            Custombutton(
                title: "Track Order",
                onPressed: () {
                  Navigator.pop(context);
                },
                theme: "theme1"),
            Custombutton(
              title: "Back to home",
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => MainScreen()),
                  (Route<dynamic> route) => false,
                );
              },
              theme: "theme3",
            )
          ],
        ),
      ),
    );
  }
}
