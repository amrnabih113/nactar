import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nectar/screens/mainscreen.dart';
import 'package:nectar/screens/signuppage.dart';
import 'package:nectar/widgets/Custombutton.dart';
import 'package:nectar/widgets/login&signup/customtextfeild.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  bool rememberMe = true;

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

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return; // Validate form

    setState(() {});

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      if (FirebaseAuth.instance.currentUser != null &&
          FirebaseAuth.instance.currentUser!.emailVerified) {
        Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(builder: (context) => MainScreen()),
  (Route<dynamic> route) => false, // This will remove all previous routes
);

      } else {
        FirebaseAuth.instance.currentUser!.sendEmailVerification();
        _showDialog("Check your mail to verify");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        _showDialog('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        _showDialog('Wrong password provided for that user.');
      } else if (e.code == 'too-many-requests') {
        _showDialog(
            'Too many attempts. Please try again later or reset your password.');
      } else {
        _showDialog('An error occurred. Please try again.');
      }
    } finally {
      setState(() {});
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
          height: 860,
          padding: EdgeInsets.all(25),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/background.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Form(
            key: _formKey, // Form key added
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 100),
                Image.asset('images/logo_colored.png', height: 80),
                SizedBox(height: 100),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Loging",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Enter your emails and password",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
                SizedBox(height: 30),
                CustomTextFeild(
                  controller: _emailController,
                  label: 'Email',
                  hint: 'Enter your email',
                ),
                SizedBox(height: 20),
                CustomTextFeild(
                  controller: _passwordController,
                  label: 'Password',
                  hint: 'Enter your password',
                  isPassword: true,
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Checkbox(
                      checkColor: Colors.white,
                      activeColor: Color(0xFF53B175),
                      value: rememberMe,
                      onChanged: (bool? newValue) {
                        setState(() {
                          rememberMe = newValue!;
                        });
                      },
                    ),
                    Text(
                      "Remember Me",
                      style: TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () async {
                      if (_emailController.text.isNotEmpty) {
                        try {
                          await FirebaseAuth.instance.sendPasswordResetEmail(
                            email: _emailController.text,
                          );
                          _showDialog("Check your mail to reset password");
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            _showDialog('No user found for that email.');
                          } else if (e.code == 'invalid-email') {
                            _showDialog('The email address is not valid.');
                          } else {
                            _showDialog('An error occurred. Please try again.');
                          }
                        } catch (e) {
                          _showDialog(
                              'An unexpected error occurred. Please try again.');
                        }
                      } else {
                        _showDialog("The Email is Empty!");
                      }
                    },
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Custombutton(title: "Log in", onPressed: _login),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don’t have an account? ",
                      style: TextStyle(color: Colors.black54),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => SignUpPage()),
                        );
                      },
                      child: Text(
                        "Signup",
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
