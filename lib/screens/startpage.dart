import 'package:flutter/material.dart';
import 'package:nectar/screens/getingready.dart';
import 'package:nectar/widgets/Custombutton.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/startupimage.png"))),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            width: double.infinity,
            height: 442,
            child: Column(
              children: [
                Image.asset(
                  "images/logo_colored.png",
                  height: 56.36,
                  width: 48.47,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    "Welcome to our store",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 48,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                Text(
                  "Ger your groceries in as fast as one hour",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 41,
                ),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Custombutton(
                      title: "Get Strarted",
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GetingReady()));
                      }),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
