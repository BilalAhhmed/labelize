// To parse this JSON data, do
//
//     final apiCall = apiCallFromJson(jsonString);

import 'dart:convert';

ApiModel apiCallFromJson(String str) => ApiModel.fromJson(json.decode(str));

String apiCallToJson(ApiModel data) => json.encode(data.toJson());

class ApiModel {
  ApiModel({
    this.statusText,
    this.message,
    this.data,
  });

  String statusText;
  String message;
  Data data;

  factory ApiModel.fromJson(Map<String, dynamic> json) => ApiModel(
    statusText: json["statusText"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusText": statusText,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    this.randomPackage,
  });

  DataRandomPackage randomPackage;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    randomPackage: DataRandomPackage.fromJson(json["random_package"]),
  );

  Map<String, dynamic> toJson() => {
    "random_package": randomPackage.toJson(),
  };
}

class DataRandomPackage {
  DataRandomPackage({
    this.packageId,
    this.randomPackage,
  });

  String packageId;
  List<RandomPackageElement> randomPackage;

  factory DataRandomPackage.fromJson(Map<String, dynamic> json) => DataRandomPackage(
    packageId: json["package_id"],
    randomPackage: List<RandomPackageElement>.from(json["random_package"].map((x) => RandomPackageElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "package_id": packageId,
    "random_package": List<dynamic>.from(randomPackage.map((x) => x.toJson())),
  };
}

class RandomPackageElement {
  RandomPackageElement({
    this.userIdFrom2Answer,
    this.chosen2LabelByUser2,
    this.text,
    this.projectId,
    this.userIdFrom3Answer,
    this.possibleLabel3,
    this.possibleLabel1,
    this.header,
    this.textId,
    this.chosen1LabelByUser1,
    this.chosen3LabelByUser3,
    this.possibleLabel2,
    this.userIdFrom1Answer,
  });

  String userIdFrom2Answer;
  String chosen2LabelByUser2;
  String text;
  int projectId;
  String userIdFrom3Answer;
  String possibleLabel3;
  String possibleLabel1;
  String header;
  int textId;
  String chosen1LabelByUser1;
  String chosen3LabelByUser3;
  String possibleLabel2;
  String userIdFrom1Answer;

  factory RandomPackageElement.fromJson(Map<String, dynamic> json) => RandomPackageElement(
    userIdFrom2Answer: json["User_ID from #2 answer"],
    chosen2LabelByUser2: json["chosen #2 label by user #2"],
    text: json["text"],
    projectId: json["Project ID"],
    userIdFrom3Answer: json["User_ID from #3 answer"],
    possibleLabel3: json["possible label 3"],
    possibleLabel1:json["possible label 1"],
    header: json["Header"],
    textId: json["text ID"],
    chosen1LabelByUser1: json["chosen #1 label by user #1"],
    chosen3LabelByUser3: json["chosen #3 label by user #3"],
    possibleLabel2: json["possible label 2"],
    userIdFrom1Answer: json["User_ID from #1 answer"],
  );

  Map<String, dynamic> toJson() => {
    "User_ID from #2 answer": userIdFrom2Answer,
    "chosen #2 label by user #2": chosen2LabelByUser2,
    "text": text,
    "Project ID": projectId,
    "User_ID from #3 answer": userIdFrom3Answer,
    "possible label 3": possibleLabel3,
    "possible label 1": possibleLabel1,
    "Header": header,
    "text ID": textId,
    "chosen #1 label by user #1": chosen1LabelByUser1,
    "chosen #3 label by user #3": chosen3LabelByUser3,
    "possible label 2": possibleLabel2,
    "User_ID from #1 answer": userIdFrom1Answer,
  };
}

// enum UserIdFrom1Answer { EMPTY }
//
// final userIdFrom1AnswerValues = EnumValues({
//   "-": UserIdFrom1Answer.EMPTY
// });
//
// enum Header { WHAT_IS_THIS_TEXT_ABOUT }
//
// final headerValues = EnumValues({
//   "What is this text about?": Header.WHAT_IS_THIS_TEXT_ABOUT
// });
//
// enum PossibleLabel1 { POSITIVE }
//
// final possibleLabel1Values = EnumValues({
//   "positive": PossibleLabel1.POSITIVE
// });
//
// enum PossibleLabel2 { NEUTRAL }
//
// final possibleLabel2Values = EnumValues({
//   "neutral": PossibleLabel2.NEUTRAL
// });
//
// enum PossibleLabel3 { NEGATIVE }
//
// final possibleLabel3Values = EnumValues({
//   "negative": PossibleLabel3.NEGATIVE
// });
//
// class EnumValues<T> {
//   Map<String, T> map;
//   Map<T, String> reverseMap;
//
//   EnumValues(this.map);
//
//   Map<T, String> get reverse {
//     if (reverseMap == null) {
//       reverseMap = map.map((k, v) => new MapEntry(v, k));
//     }
//     return reverseMap;
//   }
// }



































// // To parse this JSON data, do
// //
// //     final apiCall = apiCallFromJson(jsonString);
//
// import 'dart:convert';
//
// ApiCall apiCallFromJson(String str) => ApiCall.fromJson(json.decode(str));
//
// // String apiCallToJson(ApiCall data) => json.encode(data.toJson());
//
// class ApiCall {
//   ApiCall({
//     this.statusText,
//     this.message,
//     this.data,
//   });
//
//   String statusText;
//   String message;
//   Data data;
//
//   factory ApiCall.fromJson(Map<String, dynamic> json) => ApiCall(
//     statusText: json["statusText"],
//     message: json["message"],
//     data: Data.fromJson(json["data"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "statusText": statusText,
//     "message": message,
//     "data": data.toJson(),
//   };
// }
//
// class Data {
//   Data({
//     this.randomPackage,
//   });
//
//   DataRandomPackage randomPackage;
//
//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//     randomPackage: DataRandomPackage.fromJson(json["random_package"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "random_package": randomPackage.toJson(),
//   };
// }
//
// class DataRandomPackage {
//   DataRandomPackage({
//     this.packageId,
//     this.randomPackageElement,
//   });
//
//   String packageId;
//   final List<RandomPackageElement> randomPackageElement;
//
//   factory DataRandomPackage.fromJson(Map<String, dynamic> json) => DataRandomPackage(
//     packageId: json["package_id"],
//     randomPackageElement: RandomPackageElement.fromJson(json["random_package"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "package_id": packageId,
//     "random_package": randomPackageElement.toJson()
//   };
// }
//
// class RandomPackageElement {
//   RandomPackageElement({
//     this.userIdFromAnswer2,
//     this.header,
//     this.possibleLabel2,
//     this.chosen2LabelByUser2,
//     this.textId,
//     this.possibleLabel3,
//     this.userIdFrom3Answer,
//     this.text,
//     this.possibleLabel1,
//     this.projectId,
//     this.chosen3LabelByUser3,
//     this.chosen1LabelByUser1,
//     this.userIdFrom1Answer,
//   });
//
//   String userIdFromAnswer2;
//   String header;
//   String possibleLabel2;
//   String chosen2LabelByUser2;
//   int textId;
//   String possibleLabel3;
//   String userIdFrom3Answer;
//   String text;
//   String possibleLabel1;
//   int projectId;
//   String chosen3LabelByUser3;
//   String chosen1LabelByUser1;
//   String userIdFrom1Answer;
//
//   factory RandomPackageElement.fromJson(Map<String, dynamic> json) => RandomPackageElement(
//     userIdFromAnswer2: json["User_ID from #2 answer"],
//     header: json["Header"],
//     possibleLabel2: json["possible label 2"],
//     chosen2LabelByUser2: json["chosen #2 label by user #2"],
//     textId: json["text ID"],
//     possibleLabel3: json["possible label 3"],
//     userIdFrom3Answer: json["User_ID from #3 answer"],
//     text: json["text"],
//     possibleLabel1: json["possible label 1"],
//     projectId: json["Project ID"],
//     chosen3LabelByUser3: json["chosen #3 label by user #3"],
//     chosen1LabelByUser1: json["chosen #1 label by user #1"],
//     userIdFrom1Answer: json["User_ID from #1 answer"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "User_ID from #2 answer": userIdFromAnswer2,
//     "Header": header,
//     "possible label 2": possibleLabel2,
//     "chosen #2 label by user #2": chosen2LabelByUser2,
//     "text ID": textId,
//     "possible label 3": userIdFrom3Answer,
//     "text": text,
//     "possible label 1": possibleLabel1,
//     "Project ID": projectId,
//     "chosen #3 label by user #3": chosen3LabelByUser3,
//     "chosen #1 label by user #1": chosen1LabelByUser1,
//     "User_ID from #1 answer": userIdFrom1Answer,
//   };
// }
//
// // enum UserIdFrom1Answer { EMPTY }
// //
// // final userIdFrom1AnswerValues = EnumValues({
// //   "-": UserIdFrom1Answer.EMPTY
// // });
// //
// // enum Header { HOW_ARE_YOU_TEST }
// //
// // final headerValues = EnumValues({
// //   "How are you? Test": Header.HOW_ARE_YOU_TEST
// // });
// //
// // enum PossibleLabel1 { POSITIVE }
// //
// // final possibleLabel1Values = EnumValues({
// //   "positive": PossibleLabel1.POSITIVE
// // });
// //
// // enum PossibleLabel2 { NEUTRAL }
// //
// // final possibleLabel2Values = EnumValues({
// //   "neutral": PossibleLabel2.NEUTRAL
// // });
// //
// // enum PossibleLabel3 { NEGATIVE }
// //
// // final possibleLabel3Values = EnumValues({
// //   "negative": PossibleLabel3.NEGATIVE
// // });
// //
// // class EnumValues<T> {
// //   Map<String, T> map;
// //   Map<T, String> reverseMap;
// //
// //   EnumValues(this.map);
// //
// //   Map<T, String> get reverse {
// //     if (reverseMap == null) {
// //       reverseMap = map.map((k, v) => new MapEntry(v, k));
// //     }
// //     return reverseMap;
// //   }
// // }
