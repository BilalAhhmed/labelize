import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:labelize/model/apiModel.dart';
import 'package:http/http.dart' as http;
import 'package:labelize/services/constants.dart';
import 'package:labelize/model/allProjectsModel.dart';

class AllProjectsApiProvider {
  String url =
      'https://us-central1-labelize-9aab6.cloudfunctions.net/getAllProjects';

  Future<AllProjectModel> getPost() async {
    final response = await http.get('$url', headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    });
    //print(response.body.toString());

    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['statusText'] == 'error') {
        print('error');
        return null;
      } else {
        return allProjectModelFromJson(response.body);
      }
    } else {
      // throw Exception('Failed to load Data');
      return null;
    }
  }

  Future<bool> getPackages() async {
    Constants.allProjectModel = await getPost();
    if (Constants.allProjectModel != null) {
      return true;
    } else
      return false;
  }

  // Future<http.Response> createPost({String package_id, String time_taken, List<List<String>> labels }) async {
  //   final response = await http.post('$postUrl',
  //       headers: {
  //         HttpHeaders.contentTypeHeader: 'application/json',
  //       },
  //       body: {
  //         "user_id": Constants.userId,
  //         "package_id": package_id,
  //         "time_taken":time_taken,
  //         "labels":labels
  //       }
  //   );
  //   return response;
  // }

}
