import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nectar/database/database.dart';
import 'package:nectar/screens/loginpage.dart';
import 'package:nectar/screens/mainscreen.dart';
import 'package:nectar/screens/signuppage.dart';
import 'package:nectar/widgets/Custombutton.dart';
import 'package:nectar/widgets/login&signup/socialmediabutton.dart';

class GetingReady extends StatefulWidget {
  const GetingReady({super.key});

  @override
  State<GetingReady> createState() => _GetingReadyState();
}

class _GetingReadyState extends State<GetingReady> {
  SqlDb Mydb = SqlDb();
  User? user;
  Future<void> _addUserToLocalDatabase({
    required String username,
    required String email,
    required String firebaseId,
  }) async {
    try {
      // Check if the user already exists
      var existingUsers = await Mydb.getdata(
        "SELECT * FROM Users WHERE firebase_id = ?",
        [firebaseId],
      );

      if (existingUsers.isNotEmpty) {
        print("User already exists in local database.");
        return;
      }

      // If the user does not exist, insert into the database
      int response = await Mydb.insert(
        "INSERT INTO Users (username, email, firebase_id, password) VALUES (?, ?, ?, ?)",
        [username, email, firebaseId, "12345678"],
      );
      if (response > 0) {
        print("User added to local database successfully.");
      } else {
        print("Failed to add user to local database.");
      }
    } catch (e) {
      print("Error adding user to local database: ${e.toString()}");
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // If the user cancels the sign-in process, return null
      if (googleUser == null) {
        return null; // User canceled the sign-in process
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credential
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      user = FirebaseAuth.instance.currentUser;
      print("$user");
      _addUserToLocalDatabase(
          username: user!.displayName ?? "",
          email: user!.email!,
          firebaseId: user!.uid);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
        (Route<dynamic> route) => false, // This will remove all previous routes
      );

      // Return the UserCredential
      return userCredential;
    } catch (e) {
      // Handle errors, e.g., show an error message
      print("Error during Google sign-in: ${e.toString()}");
      // Optionally, show an error dialog or Snackbar
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 413.37,
            height: 374.15,
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("images/image.png"))),
          ),
          Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 222,
                  height: 70,
                  child: Text(
                    "Get your groceries with nectar",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: 80,
                ),
                Custombutton(
                    title: "Log in",
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    }),
                Custombutton(
                  title: "Create an Account",
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUpPage()));
                  },
                  theme: "theme2",
                ),
              ],
            ),
          ),
          Text(
            "Or connect with social media",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xff828282)),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Google Sign-In Button
              SocialMediaButton(
                  imagename: "google_logo.png",
                  color: Colors.white,
                  onTap: () async {
                    signInWithGoogle();
                    // Add user to local database
                  }),
              SizedBox(width: 50),
              SocialMediaButton(
                imagename: "facebook_logo.webp",
                color: Color(0xFF1877F2),
                onTap: () {},
                imagecolor: Colors.white,
              ),
            ],
          )
        ],
      ),
    );
  }
}
