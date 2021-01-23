import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:labelize/view/signUp/signUppScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:labelize/services/constants.dart';
import 'package:labelize/widgets/CustomToast.dart';
import 'package:labelize/view/bottomNavigationBarScreens/BottomNavigationBar.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> animation;

  final FirebaseMessaging _fcm = FirebaseMessaging();
  // final SaveNotificationFirebase saveNotificationFirebase = SaveNotificationFirebase();

  String messageTitle = '';
  String body = '';
  int date = 0;
  bool hasData = false;

  getMessage() {
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");

        body = message['notification']['body'];

        if (body != null)
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BottomNavigation(
                        index: 0,
                      )));

        //
        // setState(() {
        //   messageTitle = message['notification']['title'];
        //   body = message['notification']['body'];
        //
        // });
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        body = message['data']['body'];

        if (body != null)
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BottomNavigation(
                        index: 0,
                      )));

        // setState(() {
        //     hasData = true;
        //     messageTitle = message['data']['title'];
        //     body = message['data']['body'];
        //     date = message['data']['google.sent_time'];
        //   });
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        body = message['data']['body'];

        if (body != null)
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BottomNavigation(
                        index: 0,
                      )));

        // setState(() {
        //     hasData = true;
        //     messageTitle = message['data']['title'];
        //     body = message['data']['body'];
        //     date = message['data']['google.sent_time'];
        //   });
      },
    );
  }

  void initState() {
    super.initState();
    // getMessage();
    // print(Constants.socialLogin);

    _animationController =
        AnimationController(duration: Duration(seconds: 2), vsync: this);

    final curvedAnimation = CurvedAnimation(
        parent: _animationController,
        curve: Curves.bounceIn,
        reverseCurve: Curves.easeOut);

    animation =
        Tween<double>(begin: 0, end: 2 * math.pi).animate(curvedAnimation)
          ..addListener(() {
            if (mounted) setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed)
              _animationController.reverse();
            else if (status == AnimationStatus.dismissed)
              _animationController.forward();
          });
    _animationController.forward();

    timer();
  }

  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void timer() {
    Timer(
      Duration(seconds: 3),
      () async {

        // if (Constants.socialLogin == false) {
          final prefs = await SharedPreferences.getInstance();
        final prefsIsLogin = prefs.getBool('loggedIn');


        if (prefsIsLogin != null) {
          if (prefsIsLogin) {
            _signInWithEmailAndPassword(context);
          } else {
            Navigator.pushNamed(context, SignUpScreen.routeName);
          }
        }
        else {
          await Navigator.pushNamed(context, SignUpScreen.routeName);
        }

      },
    );
  }

  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            buildBackgroundImage(context, _height),
            Align(alignment: Alignment.center,
                child: Transform.rotate(
                  angle: animation.value,
                  child: Image.asset('assets/logo.png'),
                ))
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
      ))
          .user;

      if (user != null) {
        Constants.user = user;
        Constants.userId = user.uid;

        Navigator.pushNamed(context, BottomNavigation.routeName);

        // Navigator.pushNamedAndRemoveUntil(
        //     context, BottomNavigation.routeName, (route) => false);
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
                image: AssetImage("assets/Splash.png"),
                fit: BoxFit.cover)));
  }
}
