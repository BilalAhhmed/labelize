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
        this.description,
        this.userTargetNumber,
        this.name,
        this.maxAnswersPerPackage,
        this.timestamp,
        this.expirationDate,
        this.packageTimer,
        this.jsonFile,
        this.partitionNumber,
        this.imgFile,
        this.creditsPerPackage,
        this.expirationDateTimestamp,
        this.packages,
        this.projectId,
    });

    String description;
    String userTargetNumber;
    String name;
    String maxAnswersPerPackage;
    int timestamp;
    DateTime expirationDate;
    String packageTimer;
    String jsonFile;
    String partitionNumber;
    String imgFile;
    String creditsPerPackage;
    int expirationDateTimestamp;
    List<String> packages;
    String projectId;

    factory Project.fromJson(Map<String, dynamic> json) => Project(
        description: json["description"],
        userTargetNumber: json["user_target_number"],
        name: json["name"],
        maxAnswersPerPackage: json["max_answers_per_package"],
        timestamp: json["timestamp"],
        expirationDate: json["expiration_date"] == null ? null : DateTime.parse(json["expiration_date"]),
        packageTimer: json["package_timer"],
        jsonFile: json["json_file"],
        partitionNumber: json["partition_number"],
        imgFile: json["img_file"],
        creditsPerPackage: json["credits_per_package"],
        expirationDateTimestamp: json["expiration_date_timestamp"] == null ? null : json["expiration_date_timestamp"],
        packages: json["packages"] == null ? null : List<String>.from(json["packages"].map((x) => x)),
        projectId: json["project_id"],
    );

    Map<String, dynamic> toJson() => {
        "description": description,
        "user_target_number": userTargetNumber,
        "name": name,
        "max_answers_per_package": maxAnswersPerPackage,
        "timestamp": timestamp,
        "expiration_date": expirationDate == null ? null : "${expirationDate.year.toString().padLeft(4, '0')}-${expirationDate.month.toString().padLeft(2, '0')}-${expirationDate.day.toString().padLeft(2, '0')}",
        "package_timer": packageTimer,
        "json_file": jsonFile,
        "partition_number": partitionNumber,
        "img_file": imgFile,
        "credits_per_package": creditsPerPackage,
        "expiration_date_timestamp": expirationDateTimestamp == null ? null : expirationDateTimestamp,
        "packages": packages == null ? null : List<dynamic>.from(packages.map((x) => x)),
        "project_id": projectId,
    };
}



































// // To parse this JSON data, do
// //
// //     final allProjectModel = allProjectModelFromJson(jsonString);
//
// import 'dart:convert';
//
// AllProjectModel allProjectModelFromJson(String str) => AllProjectModel.fromJson(json.decode(str));
//
// String allProjectModelToJson(AllProjectModel data) => json.encode(data.toJson());
//
// class AllProjectModel {
//     AllProjectModel({
//         this.statusText,
//         this.message,
//         this.data,
//     });
//
//     String statusText;
//     String message;
//     Data data;
//
//     factory AllProjectModel.fromJson(Map<String, dynamic> json) => AllProjectModel(
//         statusText: json["statusText"],
//         message: json["message"],
//         data: Data.fromJson(json["data"]),
//     );
//
//     Map<String, dynamic> toJson() => {
//         "statusText": statusText,
//         "message": message,
//         "data": data.toJson(),
//     };
// }
//
// class Data {
//     Data({
//         this.projects,
//     });
//
//     List<Project> projects;
//
//     factory Data.fromJson(Map<String, dynamic> json) => Data(
//         projects: List<Project>.from(json["projects"].map((x) => Project.fromJson(x))),
//     );
//
//     Map<String, dynamic> toJson() => {
//         "projects": List<dynamic>.from(projects.map((x) => x.toJson())),
//     };
// }
//
// class Project {
//     Project({
//         this.imgFile,
//         this.name,
//         this.maxAnswersPerPackage,
//         this.userTargetNumber,
//         this.expirationDate,
//         this.packageTimer,
//         this.expirationDateTimestamp,
//         this.jsonFile,
//         this.packages,
//         this.timestamp,
//         this.description,
//         this.creditsPerPackage,
//         this.partitionNumber,
//         this.projectId,
//     });
//
//     String imgFile;
//     String name;
//     String maxAnswersPerPackage;
//     String userTargetNumber;
//     DateTime expirationDate;
//     String packageTimer;
//     int expirationDateTimestamp;
//     String jsonFile;
//     List<String> packages;
//     int timestamp;
//     String description;
//     String creditsPerPackage;
//     String partitionNumber;
//     String projectId;
//
//     factory Project.fromJson(Map<String, dynamic> json) => Project(
//         imgFile: json["img_file"],
//         name: json["name"],
//         maxAnswersPerPackage: json["max_answers_per_package"],
//         userTargetNumber: json["user_target_number"],
//         expirationDate: DateTime.parse(json["expiration_date"]),
//         packageTimer: json["package_timer"],
//         expirationDateTimestamp: json["expiration_date_timestamp"],
//         jsonFile: json["json_file"],
//         packages: List<String>.from(json["packages"].map((x) => x)),
//         timestamp: json["timestamp"],
//         description: json["description"],
//         creditsPerPackage: json["credits_per_package"],
//         partitionNumber: json["partition_number"],
//         projectId: json["project_id"],
//     );
//
//     Map<String, dynamic> toJson() => {
//         "img_file": imgFile,
//         "name": name,
//         "max_answers_per_package": maxAnswersPerPackage,
//         "user_target_number": userTargetNumber,
//         "expiration_date": "${expirationDate.year.toString().padLeft(4, '0')}-${expirationDate.month.toString().padLeft(2, '0')}-${expirationDate.day.toString().padLeft(2, '0')}",
//         "package_timer": packageTimer,
//         "expiration_date_timestamp": expirationDateTimestamp,
//         "json_file": jsonFile,
//         "packages": List<dynamic>.from(packages.map((x) => x)),
//         "timestamp": timestamp,
//         "description": description,
//         "credits_per_package": creditsPerPackage,
//         "partition_number": partitionNumber,
//         "project_id": projectId,
//     };
// }
