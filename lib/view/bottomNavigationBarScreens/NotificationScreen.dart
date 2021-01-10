import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:labelize/widgets/CustomToast.dart';
import 'package:labelize/widgets/Helper.dart';
import 'package:labelize/services/pushNotificationService.dart';

import '../../project_theme.dart';

class NotificationScreen extends StatefulWidget {

  static const routeName = '/notification';
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final FirebaseMessaging _fcm = FirebaseMessaging();
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey(debugLabel: "Main Navigator");

  String messageTitle = "No notification";
  String notificationAlert = "Notification";
  bool hasData = false;
  getRegister() {
    _fcm.getToken().then((token) => print(token));
  }

  getMessage() {
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: ${message}");

        setState(() {
          messageTitle = message['notification']['title'];
          notificationAlert = message['notification']['body'];
        });
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        setState(() {
          messageTitle = message['notification']['title'];
          notificationAlert = message['notification']['body'];
        });
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        setState(() {
          messageTitle = message['notification']['title'];
          notificationAlert = message['notification']['body'];
        });
      },
    );
  }

  void initState() {
    super.initState();
    getMessage();
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return ColorfulSafeArea(
      child: Scaffold(
        body: ListView(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          children: [
            Container(
                padding: const EdgeInsets.all(30),
                color: ProjectTheme.navigationBackgroundColor,
                height: _height,
                child: Column(
                  children: [
                    Text(
                      'Notifications',
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.w300),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: 1,
                      itemBuilder: (BuildContext context, index) {
                        return ListTile(
                          title: Text('$notificationAlert'),
                          subtitle: Text('$messageTitle'),
                          trailing: Text(
                            Helper.getDateNtime(
                              DateTime.now(),
                            ),
                          ),
                        );
                      }

                    ),
                  ],
                )

                //     ListTile(
                //       title: Text('Notification 2'),
                //       subtitle: Text('content 2'),
                //       trailing: Text(
                //         Helper.getDateNtime(
                //           DateTime.now(),
                //         ),
                //       ),
                //     ),
                //     ListTile(
                //       title: Text('Notification 3'),
                //       subtitle: Text('content 3'),
                //       trailing: Text(
                //         Helper.getDateNtime(
                //           DateTime.now(),
                //         ),
                //       ),
                //     )
                //   ],
                // )
                ),
          ],
        ),
      ),
    );
  }
}
