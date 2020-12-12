import 'package:flutter/material.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:labelize/project_theme.dart';
import 'package:labelize/view/signIn/signInScreen.dart';

class PasswordResetScreen extends StatefulWidget {
  static const routeName = '/password-change';
  @override
  _PasswordResetScreenState createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoggingIn = false;
  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return ColorfulSafeArea(
      color: ProjectTheme.projectBackgroundColor,
      child: Scaffold(
        appBar: buildAppbar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Password Reset',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.w300),
                ),
                SizedBox(
                  height: _height * 0.03,
                ),
                buildForm(_height),
                buildButton(context, _height, _width)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildAppbar() {
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

  Widget buildForm(double _height) {

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Enter your email id to reset your password',
            style: TextStyle(color: Color(0xFF8F92A1), fontSize: 14),
          ),
          SizedBox(
            height: _height * 0.05,
          ),
          Text(
            'Email',
            style: TextStyle(color: Color(0xFF8F92A1), fontSize: 14),
          ),
          TextFormField(
            controller: _emailController,
            validator: (value) {
              if (value.isEmpty) return 'Please enter some text';
              return null;
            },
            decoration: InputDecoration(
                hintText: 'john@mymail.com',
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFF4DD942),
                  ),
                ),
                fillColor: Colors.red[900],
                // hintText: 'Username',
                contentPadding: EdgeInsets.only(
                  top: 20,
                )),
          ),
          SizedBox(
            height: _height * 0.05,
          ),
        ],
      ),
    );
  }

  Widget buildButton(BuildContext context,double _height, double _width) {

    return Column(
      children: [
        Container(
          height: _height * 0.07,
          width: _width * .82,
          child: FlatButton(
            onPressed: () {
              if (_formKey.currentState.validate()) {
                setState(() {
                  isLoggingIn = true;
                  Navigator.pushNamed(context, SignInScreen.routeName);
                });
              }
            },
            color: ProjectTheme.projectPrimaryColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Continue',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  ImageIcon(
                    AssetImage(
                      'assets/arrow_right.png',
                    ),
                    color: Colors.white,
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
