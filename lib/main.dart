import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nectar/screens/mainscreen.dart';
import 'package:nectar/screens/startpage.dart';
import 'package:nectar/services/providermodel.dart';
import 'package:provider/provider.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyA45VZVwr7H1SjdAs7IjgXb4KrOeMfst5w',
      appId: '1:369401484888:android:70831eb7e56300f5c8dc2d',
      messagingSenderId: '369401484888',
      projectId: 'nectar-5935c',
      storageBucket: 'nectar-5935c.appspot.com',
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Model>(
      create: (context) => Model(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: FlutterSplashScreen.fadeIn(
          backgroundColor: const Color(0xff53B175),
          onInit: () {
            debugPrint("On Init");
          },
          onEnd: () {
            debugPrint("On End");
          },
          duration: const Duration(milliseconds: 2000),
          childWidget: SizedBox(
            height: 200,
            width: 200,
            child: Image.asset("images/splash.png"),
          ),
          onAnimationEnd: () => debugPrint("On Fade In End"),
          nextScreen: FirebaseAuth.instance.currentUser == null
              ? StartPage()
              : MainScreen(),
        ),
      ),
    );
  }
}
