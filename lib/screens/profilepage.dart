import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nectar/screens/startpage.dart';
import 'package:nectar/widgets/Custombutton.dart';
import 'package:nectar/widgets/ProductDetails/Mydivider.dart';
import 'package:nectar/widgets/profilePage/listitem.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  const Row(
                    children: [
                      CircleAvatar(
                          radius: 35,
                          backgroundImage: AssetImage(
                            "images/profileimage.jpg",
                          )),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Amr Nabih",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Text(
                            "amrnabih112@gmail.com",
                            style: TextStyle(
                                fontSize: 16, color: Color(0xff7C7C7C)),
                          )
                        ],
                      )
                    ],
                  ),
                  const MyDivider(),
                  ListItem(
                      icon: Icons.shopping_bag_outlined,
                      title: "Orders",
                      onPressed: () {}),
                  ListItem(
                      icon: Icons.badge_outlined,
                      title: "My Details",
                      onPressed: () {}),
                  ListItem(
                      icon: Icons.location_on_outlined,
                      title: "Location",
                      onPressed: () {}),
                  ListItem(
                      icon: Icons.credit_card_sharp,
                      title: "Payment Method",
                      onPressed: () {}),
                  ListItem(
                      icon: Icons.notifications_none,
                      title: "Notifications",
                      onPressed: () {}),
                  ListItem(
                      icon: Icons.help_outline,
                      title: "Help",
                      onPressed: () {}),
                  ListItem(
                      icon: Icons.info_outline,
                      title: "About",
                      onPressed: () {}),
                ],
              ),
            ),
            Custombutton(
              title: "Log Out",
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                GoogleSignIn googlesign = GoogleSignIn();
                googlesign.disconnect();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => StartPage()));
              },
              theme: "theme2",
            )
          ],
        ),
      ),
    );
  }
}
