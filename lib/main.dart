import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:labelize/view/bottomNavigationBarScreens/BottomNavigationBar.dart';
import 'package:labelize/view/bottomNavigationBarScreens/BottomNavigationBar.dart';
import 'package:labelize/view/bottomNavigationBarScreens/NotificationScreen.dart';
import 'package:labelize/view/bottomNavigationBarScreens/companyDetailScreen.dart';
import 'package:labelize/view/bottomNavigationBarScreens/wallet.dart';
import 'package:labelize/view/passwordReset/PasswordReset.dart';
import 'package:labelize/view/passwordReset/password_changeScreen.dart';
import 'package:labelize/view/signIn/signInScreen.dart';
import 'package:labelize/view/signUp/signUppScreen.dart';
import 'package:labelize/view/tasks/TasksScreen.dart';
import 'view/splash/splash_Screen.dart';
import 'view/bottomNavigationBarScreens/NotificationScreen.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey(debugLabel: "Main Navigator");

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
          PasswordChangeScreen.routeName: (ctx) => PasswordChangeScreen(),
          CompanyDetailScreen.routeName: (ctx) => CompanyDetailScreen(),
          NotificationScreen.routeName: (ctx) => NotificationScreen()
        });
  }
}
