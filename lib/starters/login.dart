import 'package:flutter/material.dart';
import 'package:smarthealthcare/components/button.dart';
import 'package:smarthealthcare/starters/form_error.dart';
import 'package:smarthealthcare/starters/signup.dart';
import 'package:smarthealthcare/services/auth.dart';
import 'package:smarthealthcare/shared/constants.dart';
import 'package:smarthealthcare/tabs.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  static String routeName = "/login";

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email = '', password = '';
  final _formKey = GlobalKey<FormState>();

  final AuthService _ds = AuthService();
  bool remember = false;
  final List<String> errors = [];

  void addError({required String error}) {
    if (!errors.contains(error)) errors.add(error);
  }

  void removeError({required String error}) {
    if (errors.contains(error)) errors.remove(error);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        color: kpink,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const SizedBox(height: 30),
              const Text(
                "Smart Health Care",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40,
                  color: kwhite,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                "LOGIN",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  color: kwhite,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 30),
                    buildEmailFormField(),
                    const SizedBox(height: 40),
                    buildPasswordFormField(),
                    const SizedBox(height: 40),
                    FormError(errors: errors),
                    const SizedBox(height: 30),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Button(
                            text: "OK",
                            press: () async {
                              FocusScope.of(context).requestFocus(FocusNode());
                              if (_formKey.currentState!.validate()) {
                                result = await _ds.signInWithEmailAndPassword(
                                    email, password);
                                if (result == null) {
                                  setState(() {
                                    addError(error: kSignInError);
                                  });
                                } else {
                                  Navigator.pushNamed(context, Tabs.routeName);
                                }
                              }
                            }),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              TextButton(
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, SignUp.routeName),
                child: RichText(
                  text: const TextSpan(
                    text: 'Don\'t have an account?',
                    style: TextStyle(
                      fontSize: 17,
                      color: kwhite,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: '  Sign Up',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue!,
      onChanged: (value) {
        setState(() {
          if (value.isNotEmpty) {
            removeError(error: kPassNullError);
          }
          if (value.length >= 6) {
            removeError(error: kShortPassError);
          }
          password = value;
        });
      },
      validator: (value) {
        setState(() {
          if (value!.isEmpty) {
            addError(error: kPassNullError);
            return;
          }
          if (value.length < 6) {
            addError(error: kShortPassError);
            return;
          }
        });
        return null;
      },
      decoration: const InputDecoration(
        hintText: "Enter your password",
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 10),
          child: Icon(
            Icons.lock,
            color: kpink,
          ),
        ),
        fillColor: kwhite,
        filled: true,
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue!,
      textInputAction: TextInputAction.next,
      onChanged: (value) {
        setState(() {
          if (value.isNotEmpty) {
            removeError(error: kEmailNullError);
          }
          if (emailValidatorRegExp.hasMatch(value)) {
            removeError(error: kInvalidEmailError);
          }
          email = value;
        });
      },
      validator: (value) {
        setState(() {
          if (value!.isEmpty) {
            addError(error: kEmailNullError);
            return;
          }
          if (!emailValidatorRegExp.hasMatch(value)) {
            addError(error: kInvalidEmailError);
            return;
          }
        });
        return null;
      },
      decoration: const InputDecoration(
        hintText: "Enter your email",
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 10),
          child: Icon(
            Icons.mail,
            color: kpink,
          ),
        ),
        fillColor: kwhite,
        filled: true,
      ),
    );
  }
}
