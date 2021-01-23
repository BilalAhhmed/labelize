import 'dart:convert';
import 'dart:io';
import 'package:labelize/model/apiModel.dart';
import 'package:http/http.dart' as http;
import 'package:labelize/services/constants.dart';

class ApiProvider {
  String url =
      'https://us-central1-labelize-9aab6.cloudfunctions.net/getRandomPackageForUser?user_id=';
  String uId = Constants.userId;

  String postUrl =
      'https://us-central1-labelize-9aab6.cloudfunctions.net/updatePackageLabels';

  Future<ApiModel> getPost({String projectID}) async {
    final response =
        await http.get('$url+${uId}&project_id=${projectID}', headers: {
      HttpHeaders.contentTypeHeader: "application/json",
    });
    // print(response.body.toString());
    print(response.headers['content-type']);

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

  // Stream<ApiModel> get stream {
  //   return getPost().asStream();
  // }

  Future<bool> createPost(
      {String package_id,
      String time_taken,
      List<Map<String, List<String>>> labels}) async {

    try {
      final http.Response response = await http.post(
        postUrl,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.acceptHeader: "application/json"
        },
        //encoding: Encoding.getByName("utf-8"),
        body: json.encode(<String, dynamic>{
          "user_id": Constants.userId,
          "package_id": package_id,
          "time_taken": time_taken,
          "labels": labels
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
