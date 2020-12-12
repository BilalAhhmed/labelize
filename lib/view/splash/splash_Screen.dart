import 'package:flutter/material.dart';
import 'package:labelize/view/signIn/signInScreen.dart';
import 'package:labelize/view/signUp/signUpScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    Future.delayed(
      Duration(seconds: 4),
      () async {
          await Navigator.pushReplacementNamed(context, SignUpScreen.routeName);
      },
    );
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            buildBackgroundImage(context, _height),
          ],
        ),
      ),
    );
  }

  Widget buildBackgroundImage(BuildContext context, double _height) {

    return Container(
        height: _height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/background/background.png"),
                fit: BoxFit.cover)));
  }
}
