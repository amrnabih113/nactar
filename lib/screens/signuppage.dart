import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nectar/database/database.dart'; // Assuming you have a local SQLite database handler
import 'package:nectar/screens/loginpage.dart';
import 'package:nectar/widgets/Custombutton.dart';
import 'package:nectar/widgets/login&signup/customtextfeild.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  SqlDb Mydb = SqlDb(); // Initialize your local database handler

  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Error',
            style: TextStyle(
                color: Color(0xff53B175),
                fontSize: 30,
                fontWeight: FontWeight.bold),
          ),
          content: Text(message,
              style: TextStyle(
                fontSize: 18,
              )),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Container(
                height: 40,
                width: 60,
                decoration: BoxDecoration(
                    color: Color(0xff53B175),
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    'OK',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _signup() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Firebase authentication
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      User? firebaseUser = userCredential.user;
      if (firebaseUser != null) {
        // Insert user into local database
        await _addUserToLocalDatabase(
            username: _usernameController.text,
            email: _emailController.text,
            firebaseId: firebaseUser.uid,
            password: _passwordController.text);

        // Navigate to login page after successful signup
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        _showDialog('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        _showDialog('The account already exists for that email.');
      } else {
        _showDialog('An unexpected error occurred. Please try again.');
      }
    } catch (e) {
      _showDialog(e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Add user to local database
  Future<void> _addUserToLocalDatabase({
    required String username,
    required String email,
    required String firebaseId,
    required String password,
  }) async {
    try {
      int response = await Mydb.insert(
        "INSERT INTO Users (username, email, firebase_id, password) VALUES (?, ?, ?, ?)",
        [username, email, firebaseId, password],
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: 890,
          padding: const EdgeInsets.all(25),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/background.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 100),
                Image.asset(
                  'images/logo_colored.png',
                  height: 80,
                ),
                const SizedBox(height: 100),

                Align(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Signup",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Create your account",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 30),

                CustomTextFeild(
                  controller: _usernameController,
                  label: 'Username',
                  hint: 'Enter your username',
                ),
                const SizedBox(height: 20),

                CustomTextFeild(
                  controller: _emailController,
                  label: 'Email',
                  hint: 'Enter your email',
                ),
                const SizedBox(height: 20),

                CustomTextFeild(
                  controller: _passwordController,
                  label: 'Password',
                  hint: 'Enter your password',
                  isPassword: true,
                ),
                const SizedBox(height: 20),

                // Terms and Privacy Policy
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "By continuing, you agree to our Terms of Service and Privacy Policy.",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : Custombutton(
                          title: "Sign up",
                          onPressed: _signup,
                        ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account? ",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          color: Color(0xFF53B175),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
