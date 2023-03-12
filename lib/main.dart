import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:smarthealthcare/shop/cart.dart';
import 'package:smarthealthcare/starters/land.dart';
import 'package:smarthealthcare/starters/login.dart';
import 'package:smarthealthcare/starters/signup.dart';
import 'package:smarthealthcare/shared/theme.dart';
import 'package:smarthealthcare/starters/splash.dart';
import 'package:smarthealthcare/tabs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Health Care App',
      theme: theme(),
      home: const SplashScreen(),
      routes: {
        LandingScreen.routeName: (context) => const LandingScreen(),
        SplashScreen.routeName: (context) => const SplashScreen(),
        Login.routeName: (context) => const Login(),
        SignUp.routeName: (context) => const SignUp(),
        Tabs.routeName: (context) => const Tabs(),
        Cart.routeName: (context) => const Cart(),
      },
    );
  }
}
