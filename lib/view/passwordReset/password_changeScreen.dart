import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:labelize/model/userModel.dart';
import 'package:labelize/services/constants.dart';
import 'package:labelize/services/database.dart';
import 'package:labelize/view/signUp/signUppScreen.dart';
import 'package:labelize/widgets/CustomToast.dart';
import 'package:labelize/widgets/roundedButton.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../project_theme.dart';

class PasswordChangeScreen extends StatefulWidget {
  static const routeName = '/Password-change';
  @override
  _PasswordChangeScreenState createState() => _PasswordChangeScreenState();
}

class _PasswordChangeScreenState extends State<PasswordChangeScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  DatabaseService database = DatabaseService(uId: Constants.userId);
  final CollectionReference userdata =
      FirebaseFirestore.instance.collection('user');
  UserModel user;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _oldPassController = TextEditingController();
  final TextEditingController _newPassController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  bool visibility = true;
  bool isLoggingIn = false;
  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return ColorfulSafeArea(
      color: ProjectTheme.projectBackgroundColor,
      child: Scaffold(
          appBar: buildTopContent(),
          body: StreamBuilder(
            stream: database.userStream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }

              List<UserModel> use = snapshot.data;
              int index = 0;
              for (int i = 0; i < use.length; i++) {
                if (Constants.user.email == use[i].email) {
                  index = i;
                  break;
                }
              }
              UserModel data = snapshot.data[index];

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Change Password',
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.w300)),
                          IconButton(
                              icon: visibility
                                  ? Icon(Icons.visibility, color: Colors.black)
                                  : Icon(Icons.visibility_off_rounded,
                                      color: Colors.blue),
                              onPressed: visibilePassword)],
                      ),
                      SizedBox(height: _height * 0.03),
                      buildForm(_height, _width),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: buildButton(data),
                      )
                    ],
                  ),
                ),
              );
            },
          )),
    );
  }

  Widget buildTopContent() {
    return AppBar(
      leading: IconButton(
        icon: ImageIcon(
          AssetImage(
            'assets/arrow.png',
          ),
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }

  Widget buildForm(double _height, double _width) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildFormDetails(
              height: _height,
              width: _width,
              title: 'Old Password',
              detail: 'abc@gmail.com',
              dater: _oldPassController),
          buildFormDetails(
              height: _height,
              width: _width,
              title: 'New Password',
              detail: 'abc@gmail.com',
              dater: _newPassController),
          buildFormDetails(
            height: _height,
            width: _width,
            title: 'Confirm Password',
            detail: '18',
            dater: _confirmPassController,
          ),
          SizedBox(
            height: _height * 0.1,
          )
        ],
      ),
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
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            style: TextStyle(letterSpacing: 5),
            obscureText: visibility,
            controller: dater,
            validator: (value) {
              if (value.isEmpty) return 'Field is Empty';
              return null;
            },
            decoration: InputDecoration(
              hintText: '••••••••',
              hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5)),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFF4DD942),
                ),
              ),
              fillColor: Colors.red[900],
              // hintText: 'Password',
              contentPadding: EdgeInsets.only(top: 20),
            ),
          ),
        ],
      ),
      SizedBox(
        height: height * 0.02,
      ),
    ]);
  }

  Widget buildButton(var data) {
    return CustomRoundedButton(
      buttontitle: 'Update Password',
      onPressed: () async {
        print(data.password);
        if (_formKey.currentState.validate()) {
          if (_oldPassController.text == data.password) {
            if (_oldPassController.text != _newPassController.text) {
              if (_newPassController.text == _confirmPassController.text) {
                Constants.user
                    .updatePassword(_newPassController.text.trim())
                    .then((_) async {
                  await userdata
                      .doc(Constants.user.uid)
                      .update({'password': _newPassController.text.trim()});
                  customToast(text: "Successfully changed");

                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setBool('loggedIn', false);
                  Navigator.pushNamedAndRemoveUntil(
                      context, SignUpScreen.routeName, (route) => false);
                  _auth.signOut();
                });
              } else {
                customToast(text: "Password not matched");
              }
            } else {
              customToast(text: "Old and New Password can't be same");
            }
          } else {
            customToast(text: "Old Password not same");
          }
        }
      },
    );
  }

  visibilePassword() {
    setState(() {
      if (visibility)
        visibility = false;
      else
        visibility = true;
    });
  }
}
