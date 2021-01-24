import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:labelize/model/userModel.dart';
import 'package:labelize/project_theme.dart';
import 'package:labelize/services/constants.dart';
import 'package:labelize/services/database.dart';
import 'package:labelize/view/signIn/signInScreen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:labelize/view/passwordReset/password_changeScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:labelize/view/signUp/signUppScreen.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final CollectionReference userdata =
      FirebaseFirestore.instance.collection('user');

  DatabaseService database = DatabaseService(uId: Constants.userId);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return ColorfulSafeArea(
      color: ProjectTheme.projectBackgroundColor,
      child: Container(
        child: Scaffold(
          body: Container(
            color: ProjectTheme.navigationBackgroundColor,
            child: Padding(
                padding: const EdgeInsets.all(30),
                child: StreamBuilder(
                  stream: database.userStream,
                  builder: (context, snapshot) {
                    //print(snapshot.data);
                    print(snapshot.hasData);
                    //print(snapshot.hasError);
                    if (!snapshot.hasData) {
                      return Center(
                          child: CircularProgressIndicator(
                        backgroundColor: ProjectTheme.projectPrimaryColor,
                      ));
                    }
                    List<UserModel> use = snapshot.data;
                    int index = 0;
                    for (int i = 0; i < use.length; i++) {
                      if (Constants.user.email == use[i].email) {
                        index = i;
                        break;
                      }
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildTopContent(),
                        SizedBox(
                          height: _height * 0.03,
                        ),
                        buildForm(_height, _width, snapshot.data[index])
                      ],
                    );
                  },
                )),
          ),
        ),
      ),
    );
  }

  Widget buildTopContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Settings',
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.w300),
        ),
        InkWell(
          child: Text(
            'Logout',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.lightBlueAccent,
                decoration: TextDecoration.underline),
          ),
          onTap: () async {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool('loggedIn', false);
            setState(() {
              Constants.socialLogin = false;
            });
            Navigator.pushNamedAndRemoveUntil(
                context, SignUpScreen.routeName, (route) => false);
            _auth.signOut();
          },
        )
      ],
    );
  }

  Widget buildForm(double _height, double _width, UserModel user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildEmaildetails(
          height: _height,
          width: _width,
          detail: user.email,
        ),
        Constants.socialLogin
            ? Container()
            : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Password'),
                SizedBox(
                  height: _height * 0.02,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                        context, PasswordChangeScreen.routeName);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '••••••••',
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(
                        width: _width,
                        height: 12,
                        child: Divider(
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: _height * 0.02,
                ),
              ]),
        buildAgeDetails(
          height: _height,
          width: _width,
          detail: user.age,
        )
      ],
    );
  }

  Widget buildEmaildetails({
    UserModel user,
    String detail,
    double height,
    double width,
  }) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Email'),
      SizedBox(
        height: height * 0.02,
      ),
      InkWell(
        onTap: () {
          return Alert(
              context: context,
              title: 'Email',
              content: Column(
                children: [
                  TextField(
                    controller: _emailController,
                  )
                ],
              ),
              buttons: [
                DialogButton(
                  color: ProjectTheme.projectPrimaryColor,
                  onPressed: () {
                    Constants.user
                        .updateEmail(_emailController.text.trim())
                        .then((_) async {
                      await userdata
                          .doc(Constants.userId)
                          .update({'email': _emailController.text.trim()});

                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setBool('loggedIn', false);
                      Navigator.pushNamedAndRemoveUntil(
                          context, SignInScreen.routeName, (route) => false);
                      _auth.signOut();
                    });

                    Navigator.pop(context);
                  },
                  child: Text(
                    "Update",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                )
              ]).show();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              detail,
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(
              width: width,
              height: 12,
              child: Divider(
                thickness: 1,
              ),
            ),
          ],
        ),
      ),
      SizedBox(
        height: height * 0.02,
      ),
    ]);
  }

  Widget buildAgeDetails({
    UserModel user,
    String detail,
    double height,
    double width,
  }) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Age'),
      SizedBox(
        height: height * 0.02,
      ),
      InkWell(
        onTap: () {
          return Alert(
              context: context,
              title: 'Age',
              content: Column(
                children: [
                  TextField(
                    controller: _ageController,
                  )
                ],
              ),
              buttons: [
                DialogButton(
                  color: ProjectTheme.projectPrimaryColor,
                  onPressed: () async {
                    userdata
                        .doc(Constants.userId)
                        .update({'age': _ageController.text.trim()});
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Update",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                )
              ]).show();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              detail,
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(
              width: width,
              height: 12,
              child: Divider(
                thickness: 1,
              ),
            ),
          ],
        ),
      ),
      SizedBox(
        height: height * 0.02,
      ),
    ]);
  }
}
