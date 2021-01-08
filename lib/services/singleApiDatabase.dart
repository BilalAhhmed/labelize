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

  String postUrl = 'https://us-central1-labelize-9aab6.cloudfunctions.net/updatePackageLabels';

  Future<ApiModel> getPost({String projectID}) async {
    final response = await http.get('$url+${uId}&project_id=${projectID}', headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    });
    print(response.body.toString());

    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['statusText'] == 'error') {
        print('error');
        return null;
      } else {
        return apiModelFromJson(response.body);
      }
    } else {
      // throw Exception('Failed to load Data');
      return null;
    }
  }

  Future<bool> getPackages({String projectId}) async {
    Constants.apiModel = await getPost(projectID: projectId);
    if (Constants.apiModel != null) {
      return true;
    } else
      return false;
  }

  Stream<ApiModel> get stream {
    return getPost().asStream();
  }



  Future<http.Response> createPost({String package_id, String time_taken, List<List<String>> labels }) async {
    final response = await http.post('$postUrl',
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: {
           "user_id": Constants.userId,
          "package_id": package_id,
          "time_taken":time_taken,
          "labels":labels
        }
        );
    return response;
  }

}


