import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:labelize/services/constants.dart';
import 'package:labelize/services/database.dart';
import 'package:labelize/view/bottomNavigationBarScreens/BottomNavigationBar.dart';

class FbAuthServices {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final fbLogin = new FacebookLogin();

  Future LoginWithFacebook(BuildContext context) async {
    {

      print('----------------------');
      final res = await fbLogin.logIn(permissions: [
        FacebookPermission.publicProfile,
        FacebookPermission.email
      ]);
      print('-----------------------${res.status}');

      switch (res.status) {
        case FacebookLoginStatus.Success:
          print('It worked');

          //Get Token
          final FacebookAccessToken fbToken = res.accessToken;

          //Convert to Auth Credential
          final AuthCredential credential =
              FacebookAuthProvider.credential(fbToken.token);

          //User Credential to Sign in with Firebase
          final result = await firebaseAuth.signInWithCredential(credential);
          String name = result.user.displayName.toLowerCase();

          print('${name.contains(" ") ? name.split(" ")[0] : name} is now logged in');
          print('${result.user.email} is now logged in');



          final email = result.user.email;
          final userName = name.contains(" ") ? name.split(" ")[0] : name;

          final prefs = await SharedPreferences.getInstance();
          await prefs.setBool('loggedIn', true);
          await prefs.setString('email', email.trim());
          // await prefs.setString('password', password.trim());

          await DatabaseService(uId: result.user.uid).UserData(
              email: email,
              // password: password,
              userName: userName);
          Constants.user = result.user;
          Constants.userId = result.user.uid;
          return result.user;

          Navigator.pushNamedAndRemoveUntil(
              context, BottomNavigation.routeName, (route) => false);

          break;
        case FacebookLoginStatus.Cancel:
          print('The user canceled the login');
          break;
        case FacebookLoginStatus.Error:
          print('There was an error');
          break;
      }
    }
  }
}