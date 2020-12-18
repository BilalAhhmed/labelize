import 'package:flutter/material.dart';
import 'package:labelize/view/signIn/signInScreen.dart';
import 'package:labelize/view/signUp/signUppScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:labelize/services/constants.dart';
import 'package:labelize/widgets/CustomToast.dart';
import 'package:labelize/view/bottomNavigationBarScreens/BottomNavigationBar.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    Future.delayed(
      Duration(seconds: 2), () async {
      final prefs = await SharedPreferences.getInstance();
      final prefsIsLogin = prefs.getBool('loggedIn');
      if (prefsIsLogin != null) {
        if (prefsIsLogin) {
          _signInWithEmailAndPassword(context);
          // Navigator.pushReplacement(context,
          //     MaterialPageRoute(builder: (ctx) => BottomNavigationScreens()));
        } else {
          Navigator.pushReplacementNamed(context, SignUpScreen.routeName);
        }
      } else {
        await Navigator.pushReplacementNamed(context, SignUpScreen.routeName);
      }
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

  void _signInWithEmailAndPassword(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();

    final prefsEmail = prefs.getString('email');
    final prefsPass = prefs.getString('password');
    try {
      final User user = (await _auth.signInWithEmailAndPassword(
        email: prefsEmail.trim(),
        password: prefsPass.trim(),
      )).user;

      if (user != null) {

        Constants.user = user;
        Constants.userId = user.uid;

        Navigator.pushNamedAndRemoveUntil(
            context, BottomNavigation.routeName, (route) => false);
      }

    } catch (e) {
      customToast(text: e.toString());

    }
  }
  FirebaseAuth _auth = FirebaseAuth.instance;



  Widget buildBackgroundImage(BuildContext context, double _height) {

    return Container(
        height: _height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/background/background.png"),
                fit: BoxFit.cover)));
  }
}
