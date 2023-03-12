import 'package:flutter/material.dart';

class ScreenSize {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double defaultSize;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
  }
}

double getProportionateScreenHeight(double inputHeight) {
  return (inputHeight / 812.0) * ScreenSize.screenHeight;
}

double getProportionateScreenWidth(double inputWidth) {
  return (inputWidth / 375.0) * ScreenSize.screenWidth;
}
