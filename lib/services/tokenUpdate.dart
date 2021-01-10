import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:labelize/services/constants.dart';


class SaveDeviceToken {
  final FirebaseMessaging _fcm = FirebaseMessaging();

  void SavedeviceToken() async {
    String fcmToken = await _fcm.getToken();
    if (fcmToken != null) {
      var tokens = FirebaseFirestore.instance.collection('user')
          .doc(Constants.userId)
          .collection('tokens')
          .doc(fcmToken);
      await tokens.set({
        'token': fcmToken,
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
  }
}

