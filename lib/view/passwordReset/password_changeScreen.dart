import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:labelize/widgets/roundedButton.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../project_theme.dart';

class PasswordChangeScreen extends StatefulWidget {
  static const routeName = '/Password-change';
  @override
  _PasswordChangeScreenState createState() => _PasswordChangeScreenState();
}

class _PasswordChangeScreenState extends State<PasswordChangeScreen> {
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Settings',
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.w300),
                    ),
                    IconButton(
                      icon: visibility
                          ? Icon(
                              Icons.visibility,
                              color: Colors.black,
                            )
                          : Icon(
                              Icons.visibility_off_rounded,
                              color: Colors.blue,
                            ),
                      onPressed: visibilePassword,
                    ),
                  ],
                ),
                SizedBox(
                  height: _height * 0.03,
                ),
                buildForm(_height, _width),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: CustomRoundedButton(
                      buttontitle: 'Update Password',
                      onPressed: () {
                        if (_formKey.currentState.validate()){
                          setState(() {
                            isLoggingIn = true;
                            Navigator.pop(context);
                          });
                        }
                      }),
                )
              ],
            ),
          ),
        ),
      ),
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
              title: 'Email',
              detail: 'abc@gmail.com',
              dater: _newPassController),
          buildFormDetails(
            height: _height,
            width: _width,
            title: 'Age',
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

  visibilePassword() {
    setState(() {
      if (visibility)
        visibility = false;
      else
        visibility = true;
    });
  }
}
