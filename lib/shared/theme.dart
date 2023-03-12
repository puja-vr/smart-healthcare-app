import 'package:flutter/material.dart';
import 'constants.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: kwhite,
    appBarTheme: appBarTheme(),
    iconTheme: const IconThemeData(color: kpinkdark),
    // textTheme: GoogleFonts.cairoTextTheme(),
    inputDecorationTheme: inputDecorationTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

AppBarTheme appBarTheme() {
  return const AppBarTheme(
    color: kwhite,
    elevation: 0,
    // titleTextStyle: GoogleFonts.cairo(),
    // brightness: Brightness.light,
    iconTheme: IconThemeData(color: kpinkdark),

    // textTheme: TextTheme(
    //   headline6: TextStyle(color: Colors.deepPurple, fontSize: 20),
    // ),
  );
}

InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: const BorderSide(color: kpinkdark, width: 2),
    // gapPadding: 10,
  );
  return InputDecorationTheme(
    floatingLabelBehavior: FloatingLabelBehavior.always,
    contentPadding: const EdgeInsets.fromLTRB(15, 12, 15, 12),
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    border: outlineInputBorder,
    hintStyle: cContent,
  );
}
