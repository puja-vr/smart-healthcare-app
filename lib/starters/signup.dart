import 'package:flutter/material.dart';
import 'package:smarthealthcare/components/button.dart';
import 'package:smarthealthcare/starters/form_error.dart';
import 'package:smarthealthcare/services/auth.dart';
import 'package:smarthealthcare/shared/constants.dart';
import 'package:smarthealthcare/tabs.dart';

class SignUp extends StatefulWidget {
  static String routeName = "/sign_up";

  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
                "SIGN UP",
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
                              result = await _ds.signUpEmailAndPassword(
                                  email, password);
                              if (result == null) {
                                setState(() {
                                  addError(error: kSignInError);
                                });
                              } else {
                                Navigator.pushNamed(context, Tabs.routeName);
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                'By continuing your confirm that you agree\nwith our Term and Condition',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: kwhite,
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
