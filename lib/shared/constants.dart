import 'package:flutter/material.dart';
import 'package:smarthealthcare/shared/screen_size.dart';

late double? minPrice, maxPrice;
late int? minSqft = 1900, maxSqft = 2000;
late List fList;
double totalPrice = 0;
bool loading = false;
dynamic result;

const kpink = Color.fromARGB(255, 216, 56, 109);
const kpinkdark = Color.fromARGB(255, 141, 32, 68);
const kpinklight = Colors.pinkAccent;
const kback = Color.fromARGB(255, 252, 193, 213);
final kgrey = Colors.grey.shade800;
const kwhite = Colors.white;
const kpurple = Colors.purple;
const kblack = Colors.black;
const kdeepPurple = Colors.deepPurple;
const kgreybg = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

const defaultDuration = Duration(seconds: 2);
const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: kpurple[800],
  height: 1.5,
);

const TextStyle cHeading = TextStyle(
  fontSize: 22,
  color: kpinkdark,
  fontWeight: FontWeight.bold,
);
const TextStyle cContent = TextStyle(
  fontSize: 20,
  color: Color(0xFF424242),
  fontWeight: FontWeight.bold,
  height: 1.5,
);

Expanded textContainer(String text) {
  return Expanded(
    child: Container(
      margin: const EdgeInsets.only(top: 5),
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      // width: ScreenSize.screenWidth * 0.7,
      decoration: BoxDecoration(
          border: Border.all(color: kpinkdark, width: 2),
          borderRadius: BorderRadius.circular(20),
          color: kback),
      child: Text(text, style: cContent),
    ),
  );
}

// Form Errors
const String kSignInError = "Couldn't sign in with these credentials";
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";
