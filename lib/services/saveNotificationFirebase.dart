import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:labelize/services/constants.dart';


class SaveNotificationFirebase {
  final FirebaseMessaging _fcm = FirebaseMessaging();
  // Future messageTitle;
  // Future body;

  void SaveNotification () async{
     String fcmToken = await _fcm.getToken();
      await _fcm.configure(
          onLaunch: (Map<String, dynamic> message) async {
            print("onLaunch: $message");
            String messageTitle = message['data']['title'];
            String body = message['data']['body'];

            if (fcmToken != null){
              var notification = FirebaseFirestore.instance.collection('user')
                  .doc(Constants.userId)
                  .collection('notifications')
                  .doc(fcmToken);
              await notification.set({
                'messageTitle': messageTitle,
                'body': body,
                'createdAt': FieldValue.serverTimestamp(),
              });
            }

          },
          onResume: (Map<String, dynamic> message) async {
            print("onResume: $message");
            String messageTitle = message['data']['title'];
            String body = message['data']['body'];

            if (fcmToken != null){
              var notification = FirebaseFirestore.instance.collection('user')
                  .doc(Constants.userId)
                  .collection('notifications')
                  .doc(fcmToken);
              await notification.set({
                'messageTitle': messageTitle,
                'body': body,
                'createdAt': FieldValue.serverTimestamp(),
              });
            }

          },

      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
          String messageTitle = message['notification']['title'];
      String body = message['notification']['body'];

      if (fcmToken != null){
       var notification = FirebaseFirestore.instance.collection('user')
           .doc(Constants.userId)
           .collection('notifications')
           .doc(fcmToken);
       await notification.set({
         'messageTitle': messageTitle,
         'body': body,
         'createdAt': FieldValue.serverTimestamp(),
       });
     }
  }

     );

  }

}