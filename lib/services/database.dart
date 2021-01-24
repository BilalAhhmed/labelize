import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:labelize/model/userModel.dart';

import 'constants.dart';

class DatabaseService {
  final String uId;
  final String email;
  DatabaseService({this.uId, this.email});
  final CollectionReference user =
      FirebaseFirestore.instance.collection('user');
  final FirebaseMessaging _fcm = FirebaseMessaging();

  Future UserData({
    String email,
    String userName,
    String password,
    String age,
    // List<Map<String, dynamic>> notifications,
    int credits,
  }) async {
    String fcmToken = await _fcm.getToken();
    return await user.doc(uId).set({
      'email': email,
      'userName': userName,
      'password': password,
      'age': '',
      'token': {
        'token': fcmToken,
      },
      'notifications': [
        {
          'messageTitle': NotificationMsgs.messageTitle,
          'body': NotificationMsgs.body,
          'createdAt': NotificationMsgs.date,
        }
      ]
    });
  }

  List<UserModel> getuser(QuerySnapshot qs) {
    // print(qs.docs[0].data()['notifications']);
    List<UserModel> users = List();
    try {
      qs.docs.forEach((element) {
        // List<Notification> lister = List
        users.add(UserModel(
          email: element.data()['email'],
          userName: element.data()['userName'],
          password: element.data()['password'],
          age: element.data()['age'],
          credits: element.data()['credits'],
          notification: element.data()['notifications'],
          // token: ds.data()['token']
        ));
      });
      print(users.length);
      return users;
    } catch (e) {
      print('----------${e.toString()}');
    }
    List<Notification> a = List();
    // return qs.docs.map((ds) {
    //   return UserModel(
    //     email: ds.data()['email'],
    //     userName: ds.data()['userName'],
    //     password: ds.data()['password'],
    //     age: ds.data()['age'],
    //     credits: ds.data()['credits'],
    //     notification: ds.data()['notifications'],
    //     // token: ds.data()['token']
    //   );
    // }).toList();
  }

  Stream<List<UserModel>> get userStream {
    try {
      return user.snapshots().map(getuser);
    } catch (e) {
      print(e.toString());
    }
  }

  Future _savedeviceToken() async {
    String fcmToken = await _fcm.getToken();
    if (fcmToken != null) {
      var tokens = user.doc(uId).collection('tokens').doc(fcmToken);
      await tokens.set({
        'token': fcmToken,
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
  }
}
