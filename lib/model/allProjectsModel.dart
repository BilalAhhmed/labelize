// To parse this JSON data, do
//
//     final allProjectModel = allProjectModelFromJson(jsonString);

import 'dart:convert';

AllProjectModel allProjectModelFromJson(String str) => AllProjectModel.fromJson(json.decode(str));

String allProjectModelToJson(AllProjectModel data) => json.encode(data.toJson());

class AllProjectModel {
  AllProjectModel({
    this.statusText,
    this.message,
    this.data,
  });

  String statusText;
  String message;
  Data data;

  factory AllProjectModel.fromJson(Map<String, dynamic> json) => AllProjectModel(
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
    this.projects,
  });

  List<Project> projects;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    projects: List<Project>.from(json["projects"].map((x) => Project.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "projects": List<dynamic>.from(projects.map((x) => x.toJson())),
  };
}

class Project {
  Project({
    this.imgFile,
    this.name,
    this.maxAnswersPerPackage,
    this.userTargetNumber,
    this.expirationDate,
    this.packageTimer,
    this.expirationDateTimestamp,
    this.jsonFile,
    this.packages,
    this.timestamp,
    this.description,
    this.creditsPerPackage,
    this.partitionNumber,
    this.projectId,
  });

  String imgFile;
  String name;
  String maxAnswersPerPackage;
  String userTargetNumber;
  DateTime expirationDate;
  String packageTimer;
  int expirationDateTimestamp;
  String jsonFile;
  List<String> packages;
  int timestamp;
  String description;
  String creditsPerPackage;
  String partitionNumber;
  String projectId;

  factory Project.fromJson(Map<String, dynamic> json) => Project(
    imgFile: json["img_file"],
    name: json["name"],
    maxAnswersPerPackage: json["max_answers_per_package"],
    userTargetNumber: json["user_target_number"],
    expirationDate: DateTime.parse(json["expiration_date"]),
    packageTimer: json["package_timer"],
    expirationDateTimestamp: json["expiration_date_timestamp"],
    jsonFile: json["json_file"],
    packages: List<String>.from(json["packages"].map((x) => x)),
    timestamp: json["timestamp"],
    description: json["description"],
    creditsPerPackage: json["credits_per_package"],
    partitionNumber: json["partition_number"],
    projectId: json["project_id"],
  );

  Map<String, dynamic> toJson() => {
    "img_file": imgFile,
    "name": name,
    "max_answers_per_package": maxAnswersPerPackage,
    "user_target_number": userTargetNumber,
    "expiration_date": "${expirationDate.year.toString().padLeft(4, '0')}-${expirationDate.month.toString().padLeft(2, '0')}-${expirationDate.day.toString().padLeft(2, '0')}",
    "package_timer": packageTimer,
    "expiration_date_timestamp": expirationDateTimestamp,
    "json_file": jsonFile,
    "packages": List<dynamic>.from(packages.map((x) => x)),
    "timestamp": timestamp,
    "description": description,
    "credits_per_package": creditsPerPackage,
    "partition_number": partitionNumber,
    "project_id": projectId,
  };
}
