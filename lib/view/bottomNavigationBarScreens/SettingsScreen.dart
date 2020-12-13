import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:labelize/project_theme.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:labelize/view/passwordReset/password_changeScreen.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return ColorfulSafeArea(
      color: ProjectTheme.projectBackgroundColor,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Settings',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.w300),
              ),
              SizedBox(
                height: _height * 0.03,
              ),
              buildForm(_height, _width)
            ],
          ),
        ),
      ),
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
