import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:labelize/services/constants.dart';
import 'package:labelize/services/database.dart';


class GoogleAuthServices {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  GoogleSignIn googleAuth = new GoogleSignIn();

  Future LoginWithGoogle(BuildContext context) async {
    {
      final GoogleSignInAccount googleUser =
      await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuthentication =
      await googleUser.authentication;
      googleAuth.signIn().then((result) {
        result.authentication.then((googleKey) {
          final AuthCredential credential = GoogleAuthProvider.credential(
              idToken: googleAuthentication.idToken,
              accessToken: googleAuthentication.accessToken);
          final result = firebaseAuth.signInWithCredential(credential) .then((signedInUser) async
          {

            String name = signedInUser.user.displayName.toLowerCase();


            print('signed in as ${name.contains(" ") ? name.split(" ")[0] : name}');
            print('signed in as ${signedInUser.user.email}');

            final email = signedInUser.user.email;
            final userName = name.contains(" ") ? name.split(" ")[0] : name;

            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool('loggedIn', true);
            await prefs.setString('email', email.trim());
            // await prefs.setString('password', password.trim());

            await DatabaseService(uId: signedInUser.user.uid).UserData(
                email: email,
                // password: password,
                userName: userName);
            Constants.user = signedInUser.user;
            Constants.userId = signedInUser.user.uid;
            return signedInUser.user;

          }).catchError((e) {
            print(e);
          });
        }).catchError((e) {
          print(e);
        });
      }).catchError((e) {
        print(e);
      });

    }
  }
}