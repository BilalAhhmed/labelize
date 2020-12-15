import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:labelize/project_theme.dart';
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
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildTopContent(),
                  SizedBox(
                    height: _height * 0.03,
                  ),
                  buildForm(_height, _width)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTopContent (){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Settings',
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.w300),
        ),
        InkWell(
          child: Text('Logout',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.lightBlueAccent,decoration:TextDecoration.underline),),
          onTap: () async{
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool('loggedIn', false);
            Navigator.pushNamedAndRemoveUntil(
                context, SignUpScreen.routeName, (route) => false);
            _auth.signOut();
          },
        )
      ],
    );
  }


  Widget buildForm(double _height, double _width) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildFormDetails(
            height: _height,
            width: _width,
            title: 'Email',
            detail: 'abc@gmail.com',
        dater: _emailController),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Password'),
          SizedBox(
            height: _height * 0.02,
          ),
          InkWell(
            onTap: (){
              Navigator.pushNamed(context, PasswordChangeScreen.routeName);
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
        buildFormDetails(
            height: _height, width: _width, title: 'Age', detail: '18'),
      ],
    );
  }

  Widget buildFormDetails(
      {String title,
      String detail,
      double height,
      double width,
      TextEditingController dater}) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title),
      SizedBox(
        height: height * 0.02,
      ),
      InkWell(
        onTap: () {
          return Alert(
              context: context,
              title: title,
              content: Column(
                children: [
                  TextField(
                    controller: dater,
                  )
                ],
              ),
              buttons: [
                DialogButton(
                  color: ProjectTheme.projectPrimaryColor,
                  onPressed: () {

                    detail = dater.text;
                    Navigator.pop(context);
                    print(detail);

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
