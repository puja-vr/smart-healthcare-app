import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smarthealthcare/components/loading.dart';
import 'package:smarthealthcare/starters/login.dart';
import 'package:smarthealthcare/tabs.dart';

class LandingScreen extends StatefulWidget {
  static String routeName = "/land";

  const LandingScreen({Key? key}) : super(key: key);

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, streamSnapshot) {
        if (streamSnapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text("Error: ${streamSnapshot.error}"),
            ),
          );
        }

        if (streamSnapshot.connectionState == ConnectionState.active) {
          Object? _user = streamSnapshot.data;

          if (_user == null) {
            return const Login();
          } else {
            return const Tabs();
          }
        }

        return const Loading();
      },
    );
  }
}
