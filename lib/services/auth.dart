import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:labelize/services/constants.dart';
import 'package:labelize/services/database.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;


  Future registerWithEmailandPassword ({@required String email, @required String userName, @required String password}) async {
    try{
      var result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('loggedIn', true);
      await prefs.setString('email', email.trim());
      await prefs.setString('password', password.trim());


      await DatabaseService(uId:  user.uid).UserData(
        email: email,
        password: password,
        userName: userName
      );
      Constants.user = user;
      Constants.userId =user.uid;
      return user;
    } catch (e){
      print(e.toString());
      return null;
    }
  }
}
