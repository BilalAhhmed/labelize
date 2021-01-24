import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  UserModel({
    this.userName,
    this.password,
    this.age,
    this.token,
    this.email,
    this.credits,
    this.notification,
  });

  String userName;
  String password;
  String age;
  Token token;
  String email;
  int credits = 0;
  List<dynamic> notification;
}

class Notification {
  Notification({
    this.messageTitle,
    this.body,
    this.createdAt,
  });

  String messageTitle;
  String body;
  var createdAt;
}

class Token {
  Token({
    this.token,
  });

  String token;
}

// class UserModel {
//   UserModel({
//     this.userName,
//     this.email,
//     this.age,
//     this.password,
//     this.notifications,
//     this.credits
//   });
//
//   String email;
//   String userName;
//   String password;
//   String age;
//   List<Map<String, dynamic>> notifications;
//   int credits;
// }
