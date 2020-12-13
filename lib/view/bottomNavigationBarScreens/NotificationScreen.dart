import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:labelize/widgets/Helper.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return ColorfulSafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
      child: Container(
          padding: const EdgeInsets.all(30),
          color: Color(0xFFF3F6F8),
          height: _height,
          child: ListView(
            children: [
              Text(
                'Notifications',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.w300),
              ),
              ListTile(
                title: Text('Notification 1'),
                subtitle: Text('content 1'),
                trailing: Text(
                  Helper.getDateNtime(
                    DateTime.now(),
                  ),
                ),
              ),
              ListTile(
                title: Text('Notification 2'),
                subtitle: Text('content 2'),
                trailing: Text(
                  Helper.getDateNtime(
                    DateTime.now(),
                  ),
                ),
              ),
              ListTile(
                title: Text('Notification 3'),
                subtitle: Text('content 3'),
                trailing: Text(
                  Helper.getDateNtime(
                    DateTime.now(),
                  ),
                ),
              )
            ],
          )),
    )));
  }
}
