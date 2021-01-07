import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:labelize/model/apiModel.dart';
import 'package:http/http.dart' as http;
import 'package:labelize/services/constants.dart';

class ApiProvider {
  String url =
      'https://us-central1-labelize-9aab6.cloudfunctions.net/getRandomPackageForUser?user_id=';
  String uId = Constants.userId;

  Future<ApiModel> getPost() async {
    final response = await http.get('$url+$uId', headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    });
    print(response.body.toString());

    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['statusText'] == 'error') {
        print('error');
        return null;
      } else {
        return apiCallFromJson(response.body);
      }
    } else {
      // throw Exception('Failed to load Data');
      return null;
    }
  }

  Future<bool> getPackages() async {
    Constants.apiModel = await getPost();
    if (Constants.apiModel != null) {
      return true;
    } else
      return false;
  }

  Stream<ApiModel> get stream {
    return getPost().asStream();
  }
}

// Future<http.Response> createPost(ApiCall post) async {
//   final response = await http.post('$url',
//       headers: {
//         HttpHeaders.contentTypeHeader: 'application/json',
//         HttpHeaders.authorizationHeader: ''
//       },
//       body: apiCallToJson(post));
//   return response;
// }
