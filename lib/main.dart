import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:labelize/view/bottomNavigationBarScreens/BottomNavigationBar.dart';
import 'package:labelize/view/bottomNavigationBarScreens/BottomNavigationBar.dart';
import 'package:labelize/view/bottomNavigationBarScreens/wallet.dart';
import 'file:///D:/Projects/labelize/lib/view/bottomNavigationBarScreens/home.dart';
import 'package:labelize/view/passwordReset/PasswordReset.dart';
import 'package:labelize/view/passwordReset/password_changeScreen.dart';
import 'package:labelize/view/signIn/signInScreen.dart';
import 'package:labelize/view/signUp/signUpScreen.dart';
import 'package:labelize/view/tasks/TasksScreen.dart';
import 'view/splash/splash_Screen.dart';
import 'view/tasks/TaskScreen2.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {
          '/': (ctx) => SplashScreen(),
          SignInScreen.routeName: (ctx) => SignInScreen(),
          SignUpScreen.routeName: (ctx) => SignUpScreen(),
          PasswordResetScreen.routeName: (ctx) => PasswordResetScreen(),
          BottomNavigation.routeName: (ctx) => BottomNavigation(),
          TasksScreen.routeName: (ctx)=> TasksScreen(),
          TaskScreen2.routeName: (ctx) => TaskScreen2(),
          PasswordChangeScreen.routeName: (ctx) => PasswordChangeScreen()
        });
  }
}
