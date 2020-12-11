import 'package:flutter/material.dart';
import 'package:labelize/view/signIn/signInScreen.dart';
import 'package:labelize/view/signUp/signUpScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            buildBackgroundImage(context),
          ],
        ),
      ),
    );
  }

  Widget buildBackgroundImage(BuildContext context) {
    var _screenHeight = MediaQuery.of(context).size.height;
    return Container(
        height: _screenHeight,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/background/background.png"),
                fit: BoxFit.cover)));
  }
}
