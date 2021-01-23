import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:labelize/project_theme.dart';
import 'package:labelize/services/constants.dart';
import 'package:labelize/services/saveNotificationFirebase.dart';
import 'package:labelize/view/bottomNavigationBarScreens/InfoScreen.dart';
import 'package:labelize/view/bottomNavigationBarScreens/NotificationScreen.dart';
import 'package:labelize/view/bottomNavigationBarScreens/SettingsScreen.dart';
import 'package:labelize/view/bottomNavigationBarScreens/home.dart';
// import 'file:///D:/Projects/labelize/lib/view/bottomNavigationBarScreens/home.dart';
import 'package:labelize/view/bottomNavigationBarScreens/wallet.dart';
import 'package:labelize/model/userModel.dart';

class BottomNavigation extends StatefulWidget {
  static const routeName = '/Bbar';
  int index;
  BottomNavigation({this.index});
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation>
    with WidgetsBindingObserver {
  int _currentIndex = 2;

  @override
  List<Widget> _children = [
    NotificationScreen(),
    WalletScreen(),
    HomeScreen(),
    SettingsScreen(),
    InfoScreen()
  ];

  PageController _pageController = PageController(initialPage: 2);
  final FirebaseMessaging _fcm = FirebaseMessaging();
  final SaveNotificationFirebase saveNotificationFirebase =
      SaveNotificationFirebase();
  final CollectionReference user =
      FirebaseFirestore.instance.collection('user');
  final DocumentReference docUser =
      FirebaseFirestore.instance.collection('user').doc(Constants.userId);
  final UserModel userModel = UserModel();

  String messageTitle = '';
  String body = '';
  int date = 0;
  bool hasData = false;

  getMessage() {
    print('hello');
    _fcm.subscribeToTopic('everyone');
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");

        body = message['notification']['body'];

        if (body != null) {
          setState(() {
            _currentIndex = 0;
            NotificationMsgs.messageTitle = message['notification']['title'];
            NotificationMsgs.body = message['notification']['body'];
            NotificationMsgs.date =
                DateTime.now().millisecondsSinceEpoch.toInt();
            user.doc(Constants.userId).update({
              'notifications': FieldValue.arrayUnion([
                {
                  'messageTitle': NotificationMsgs.messageTitle,
                  'body': NotificationMsgs.body,
                  'createdAt': NotificationMsgs.date,
                }
              ])
            });
          });
          _pageController.jumpToPage(_currentIndex);
        }
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        body = message['data']['body'];

        if (body != null) {
          setState(() {
            _currentIndex = 0;
            NotificationMsgs.messageTitle = message['data']['title'];
            NotificationMsgs.body = message['data']['body'];
            NotificationMsgs.date = message['data']['google.sent_time'];
            user.doc(Constants.userId).update({
              'notifications': FieldValue.arrayUnion([
                {
                  'messageTitle': NotificationMsgs.messageTitle,
                  'body': NotificationMsgs.body,
                  'createdAt': NotificationMsgs.date,
                }
              ])
            });
          });
          _pageController.jumpToPage(_currentIndex);
        }
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        body = message['data']['body'];

        if (body != null) {
          setState(() {
            _currentIndex = 0;
            NotificationMsgs.messageTitle = message['data']['title'];
            NotificationMsgs.body = message['data']['body'];
            NotificationMsgs.date = message['data']['google.sent_time'];
            user.doc(Constants.userId).update({
              'notifications': FieldValue.arrayUnion([
                {
                  'messageTitle': NotificationMsgs.messageTitle,
                  'body': NotificationMsgs.body,
                  'createdAt': NotificationMsgs.date,
                }
              ])
            });
          });
          _pageController.jumpToPage(_currentIndex);
        }
      },
    );
  }

  // updateNotifications() async {
  //   List yourItemList = [];
  //   // for (int i = 0; i < docUser.collection(collectionPath).add(data) i++)
  //   //   yourItemList.add({
  //   //     'messageTitle': NotificationMsgs.messageTitle,
  //   //     'body': NotificationMsgs.body,
  //   //     'createdAt': NotificationMsgs.date,
  //   //   });
  //
  //   return await user.doc(Constants.userId).update({
  //     'notifications': FieldValue.arrayUnion([
  //       {
  //         'messageTitle': NotificationMsgs.messageTitle,
  //         'body': NotificationMsgs.body,
  //         'createdAt': NotificationMsgs.date,
  //       }
  //     ])
  //   });
  //
  // }

  @override
  void initState() {
    super.initState();
    //  _pageController = PageController();
    //  _currentIndex = 2;
    getMessage();
    // updateNotifications();
    // saveNotificationFirebase.SaveNotification();

    //_currentIndex = widget.index??2;

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    _pageController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    // These are the callbacks
    switch (state) {
      case AppLifecycleState.resumed:
        // widget is resumed
        getMessage();
        _pageController.jumpToPage(_currentIndex);
        print('resumed');
        break;
      case AppLifecycleState.inactive:
        // widget is inactive
        break;
      case AppLifecycleState.paused:
        // widget is paused
        break;
      case AppLifecycleState.detached:
        // widget is detached
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return ColorfulSafeArea(
      color: ProjectTheme.projectBackgroundColor,
      child: Scaffold(
        bottomNavigationBar: Container(
            height: _height * 0.1,
            decoration: BoxDecoration(
              color: ProjectTheme.projectBackgroundColor,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black38, spreadRadius: 0, blurRadius: 0),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              child: BottomNavigationBar(
                currentIndex: _currentIndex,
                type: BottomNavigationBarType.fixed,
                backgroundColor: ProjectTheme.projectBackgroundColor,
                selectedLabelStyle: TextStyle(
                  fontSize: 14,
                ),
                selectedItemColor: Colors.black,
                items: [
                  BottomNavigationBarItem(
                    icon: ImageIcon(
                      AssetImage(
                        'assets/1.png',
                      ),
                      size: 35,
                    ),
                    label: 'Notifications',
                  ),
                  BottomNavigationBarItem(
                    icon: ImageIcon(
                      AssetImage(
                        'assets/2.png',
                      ),
                      size: 35,
                    ),
                    label: 'Wallet',
                  ),
                  BottomNavigationBarItem(
                    icon: ImageIcon(
                        AssetImage(
                          'assets/3.png',
                        ),
                        size: 35),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: ImageIcon(
                        AssetImage(
                          'assets/4.png',
                        ),
                        size: 35),
                    label: 'Settings',
                  ),
                  BottomNavigationBarItem(
                    icon: ImageIcon(
                        AssetImage(
                          'assets/5.png',
                        ),
                        size: 35),
                    label: 'info',
                  ),
                ],
                onTap: (int index) {
                  setState(() {
                    _currentIndex = index;
                    _pageController.animateToPage(index,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeOut);
                  });
                },
              ),
            )),
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: _children,
        ),
      ),
    );
  }
}
