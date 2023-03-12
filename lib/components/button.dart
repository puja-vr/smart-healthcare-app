import 'package:flutter/material.dart';
import 'package:smarthealthcare/shared/constants.dart';
import 'package:smarthealthcare/shared/screen_size.dart';

class Button extends StatelessWidget {
  const Button({
    Key? key,
    required this.text,
    required this.press,
  }) : super(key: key);
  final String text;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: ScreenSize.screenWidth * 0.8,
      height: getProportionateScreenHeight(56),
      child: ElevatedButton(
        onPressed: () {
          press();
        },
        child: Text(
          text,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(18),
            fontWeight: FontWeight.w600,
          ),
        ),
        style: ElevatedButton.styleFrom(
            primary: kwhite,
            onPrimary: kpink,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            )),
      ),
    );
  }
}
