import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:labelize/model/userModel.dart';

class DatabaseService {
  final String uId;
  final String email;
  DatabaseService({this.uId, this.email});
  final CollectionReference user =
      FirebaseFirestore.instance.collection('user');

  Future UserData({
    String email,
    String userName,
    String password,
    String age,
  }) async {
    return await user.doc(uId).set({
      'email': email,
      'userName': userName,
      'password': password,
      'age': ''
    });
  }

  List<UserModel> getuser(QuerySnapshot qs) {
    return qs.docs.map((ds) {
      return UserModel(
          email: ds.data()['email'],
          userName: ds.data()['userName'],
          password: ds.data()['password'],
          age: ds.data()['age']);
    }).toList();
  }

  Stream<List<UserModel>> get userStream {
    return user.snapshots().map(getuser);
  }
}
