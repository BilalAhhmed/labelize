import 'dart:convert';
import 'dart:io';
import 'package:labelize/model/apiModel.dart';
import 'package:http/http.dart' as http;
import 'package:labelize/services/constants.dart';


class  PaymentApiProvider {
  String url = 'https://us-central1-labelize-9aab6.cloudfunctions.net/sendRedeemRequest';

  Future<bool> createPost(
      {int amount,
        String payment_type,
        String email}) async {

    try {
      final http.Response response = await http.post(
        url,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.acceptHeader: "application/json"
        },
        //encoding: Encoding.getByName("utf-8"),
        body: json.encode(<String, dynamic>{
          "user_id": Constants.userId,
          "amount": amount,
          "payment_type": payment_type,
          "email": email
  }),
      );
      print(response.body);
      print(response.headers['content-type']);
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['statusText'] == 'error') {
          print('error');
          return false;
        } else {
          return true;
        }
      } else {
        // throw Exception('Failed to load Data');
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
  }

}