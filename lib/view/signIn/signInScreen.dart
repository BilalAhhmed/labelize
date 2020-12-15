import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:labelize/services/constants.dart';
import 'package:labelize/view/bottomNavigationBarScreens/BottomNavigationBar.dart';
import 'file:///D:/Projects/labelize/lib/view/bottomNavigationBarScreens/home.dart';
import 'package:labelize/view/passwordReset/PasswordReset.dart';
import 'package:labelize/view/signUp/signUppScreen.dart';
import 'package:labelize/widgets/CustomToast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../project_theme.dart';

class SignInScreen extends StatefulWidget {
  static const routeName = '/sign-in';
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool visibility = true;
  bool isLoggingIn = false;

  getPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('loggedIn');
  }

  isLoggedIn(bool loggedIn) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('loggedIn', loggedIn);
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;

    return ColorfulSafeArea(
      color: Colors.white,
      child: Scaffold(
          body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sign In',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.w300),
              ),
              SizedBox(
                height: _height * 0.06,
              ),
              buildSocialLogin(_height, _width),
              buildForm(_height),
              buildButtons(context, _height, _width)
            ],
          ),
        ),
      )),
    );
  }

  Widget buildSocialLogin(double _height, double _width) {
    TextStyle style = TextStyle(color: Colors.white, fontSize: 16);
    return Column(
      children: [
        Container(
          height: _height * 0.07,
          width: _width * .82,
          child: FlatButton.icon(
            label: Text(
              'Sign in with Facebook',
              style: style,
            ),
            icon: ImageIcon(
              AssetImage(
                'assets/fb.png',
              ),
              color: Colors.white,
            ),
            color: Color(0xFF1877F2),
            onPressed: () {},
          ),
        ),
        SizedBox(
          height: _height * 0.02,
        ),
        Container(
          height: _height * 0.07,
          width: _width * .82,
          child: FlatButton.icon(
            label: Text(
              'Sign in with Google',
              style: style,
            ),
            icon: ImageIcon(
              AssetImage(
                'assets/g.png',
              ),
              color: Colors.white,
            ),
            color: Color(0xFFF14336),
            onPressed: () {},
          ),
        ),
        SizedBox(
          height: _height * .06,
        )
      ],
    );
  }

  Widget buildForm(double _height) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Username or Email',
            style: TextStyle(color: Color(0xFF8F92A1)),
          ),
          TextFormField(
            controller: _emailController,
            validator: (value) {
              if (value.isEmpty) return '';
              return null;
            },
            decoration: InputDecoration(
                hintText: 'Username',
                hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5)),
                prefixIcon: ImageIcon(
                  AssetImage(
                    'assets/user.png',
                  ),
                  color: Colors.black,
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFF4DD942),
                  ),
                ),
                fillColor: Colors.red[900],
                // hintText: 'Username',
                contentPadding: EdgeInsets.only(top: 20)),
          ),
          SizedBox(
            height: 18,
          ),
          Text(
            'Password',
            style: TextStyle(color: Color(0xFF8F92A1)),
          ),
          TextFormField(
            style: TextStyle(letterSpacing: 5),
            obscureText: visibility,
            controller: _passwordController,
            validator: (value) {
              if (value.isEmpty) return '';
              return null;
            },
            decoration: InputDecoration(
              hintText: '••••••••',
              hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5)),
              prefixIcon: ImageIcon(
                AssetImage(
                  'assets/pass.png',
                ),
                color: Colors.black,
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFF4DD942),
                ),
              ),
              fillColor: Colors.red[900],
              // hintText: 'Password',
              contentPadding: EdgeInsets.only(top: 20),
              suffixIcon: IconButton(
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
            ),
          ),
          SizedBox(
            height: _height * 0.06,
          )
        ],
      ),
    );
  }

  Widget buildButtons(BuildContext context, double _height, double _width) {
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
                    //
                  });
                  if (isLoggingIn) {
                    _signInWithEmailAndPassword(context);
                  }
                }
              },
              color: isLoggingIn? Colors.lightGreen : ProjectTheme.projectPrimaryColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    !isLoggingIn
                        ? const Text(
                      'Sign In',
                      style: TextStyle(color: Colors.white, fontSize: 15))
                        : const Text(
                        'Signing In..',
                        style: TextStyle(color: Colors.white, fontSize: 15)
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            )),
        SizedBox(
          height: _height * .1,
        ),
        InkWell(
          child: Text(
            'Forgot Password',
            style: TextStyle(color: Color(0xFF8297D1), fontSize: 15),
          ),
          onTap: () {
            Navigator.pushNamed(context, PasswordResetScreen.routeName);
          },
        )
      ],
    );
  }

  void _signInWithEmailAndPassword(BuildContext context) async {
    try {
      final User user = (await _auth.signInWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim()))
          .user;

      if (user != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('loggedIn', true);
        await prefs.setString('email', _emailController.text.trim());
        await prefs.setString('password', _passwordController.text.trim());
        setState(() {
          Constants.user = user;
          Constants.userId = user.uid;
        });
        Navigator.pushNamedAndRemoveUntil(
            context, BottomNavigation.routeName, (route) => false);
      } else {
        setState(() {
          isLoggingIn = false;
        });
      }
      if (!user.emailVerified) {}
    } catch (e) {
      customToast(text: e.toString());
      setState(() {
        isLoggingIn = false;
      });
    }
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
