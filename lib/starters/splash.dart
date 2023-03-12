import 'package:flutter/material.dart';
import 'package:smarthealthcare/components/button.dart';
import 'package:smarthealthcare/shared/constants.dart';
import 'package:smarthealthcare/shared/screen_size.dart';
import 'package:smarthealthcare/starters/land.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = "/splash";

  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    ScreenSize().init(context);
    return SafeArea(
      child: Material(
        color: kpink,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Image.asset(
              'assets/splash.jpg',
              height: 400,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Text(
              "FITNESS MATE",
              style: TextStyle(
                fontSize: getProportionateScreenWidth(30),
                color: kwhite,
                fontWeight: FontWeight.w900,
              ),
            ),
            Text(
              "A good laugh and a long sleep are the\nbest cures in the doctor's book",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: getProportionateScreenWidth(17),
                color: kwhite,
                fontWeight: FontWeight.w600,
                height: 1.5,
              ),
            ),
            Button(
              text: "Ready, Set and Go!",
              press: () {
                Navigator.pushNamed(context, LandingScreen.routeName);
              },
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
          ],
        ),
      ),
    );
  }
}
