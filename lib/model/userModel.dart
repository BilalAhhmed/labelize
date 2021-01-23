class UserModel {
  UserModel({
    this.userName,
    this.email,
    this.age,
    this.password,
    this.notifications
  });

  String email;
  String userName;
  String password;
  String age;
  List<Map<String, dynamic>> notifications;

}
