// To parse this JSON data, do
//
//     final apiModel = apiModelFromJson(jsonString);

import 'dart:convert';

ApiModel apiModelFromJson(String str) => ApiModel.fromJson(json.decode(str));

String apiModelToJson(ApiModel data) => json.encode(data.toJson());

class ApiModel {
    ApiModel({
        this.statusText,
        this.message,
        this.randomPackage,
    });

    String statusText;
    String message;
    ApiModelRandomPackage randomPackage;

    factory ApiModel.fromJson(Map<String, dynamic> json) => ApiModel(
        statusText: json["statusText"],
        message: json["message"],
        randomPackage: ApiModelRandomPackage.fromJson(json["random_package"]),
    );

    Map<String, dynamic> toJson() => {
        "statusText": statusText,
        "message": message,
        "random_package": randomPackage.toJson(),
    };
}

class ApiModelRandomPackage {
    ApiModelRandomPackage({
        this.packageId,
        this.randomPackage,
    });

    String packageId;
    RandomPackageRandomPackage randomPackage;

    factory ApiModelRandomPackage.fromJson(Map<String, dynamic> json) => ApiModelRandomPackage(
        packageId: json["package_id"],
        randomPackage: RandomPackageRandomPackage.fromJson(json["random_package"]),
    );

    Map<String, dynamic> toJson() => {
        "package_id": packageId,
        "random_package": randomPackage.toJson(),
    };
}

class RandomPackageRandomPackage {
    RandomPackageRandomPackage({
        this.packages,
    });

    List<Package> packages;

    factory RandomPackageRandomPackage.fromJson(Map<String, dynamic> json) => RandomPackageRandomPackage(
        packages: List<Package>.from(json["packages"].map((x) => Package.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "packages": List<dynamic>.from(packages.map((x) => x.toJson())),
    };
}

class Package {
    Package({
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
        this.labels
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
    List<String> labels;

    factory Package.fromJson(Map<String, dynamic> json) => Package(
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
        labels: List<String>.from(json["labels"].map((x) => x)),
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
        "labels": List<dynamic>.from(labels.map((x) => x)),
    };
}

enum UserIDfrom1Answer { EMPTY }

final userIDfrom1AnswerValues = EnumValues({
    "-": UserIDfrom1Answer.EMPTY
});

enum Header { HOWAREYOU_TEST }

final headerValues = EnumValues({
    "Howareyou?Test": Header.HOWAREYOU_TEST
});

enum Possiblelabel1 { POSITIVE }

final possiblelabel1Values = EnumValues({
    "positive": Possiblelabel1.POSITIVE
});

enum Possiblelabel2 { NEUTRAL }

final possiblelabel2Values = EnumValues({
    "neutral": Possiblelabel2.NEUTRAL
});

enum Possiblelabel3 { NEGATIVE }

final possiblelabel3Values = EnumValues({
    "negative": Possiblelabel3.NEGATIVE
});

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
















// // To parse this JSON data, do
// //
// //     final apiCall = apiCallFromJson(jsonString);
//
// import 'dart:convert';
//
// ApiModel apiCallFromJson(String str) => ApiModel.fromJson(json.decode(str));
//
// String apiCallToJson(ApiModel data) => json.encode(data.toJson());
//
// class ApiModel {
//   ApiModel({
//     this.statusText,
//     this.message,
//     this.random_package,
//   });
//
//   String statusText;
//   String message;
//   ApiModelRandomPackage random_package;
//
//   factory ApiModel.fromJson(Map<String, dynamic> json) => ApiModel(
//     statusText: json["statusText"],
//     message: json["message"],
//     random_package: ApiModelRandomPackage.fromJson(json["data"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "statusText": statusText,
//     "message": message,
//     "data": random_package.toJson(),
//   };
// }
//
//
//
// class ApiModelRandomPackage {
//   ApiModelRandomPackage({
//     this.packageId,
//     this.randomPackage,
//   });
//
//   String packageId;
//   List<Package> randomPackage;
//
//   factory ApiModelRandomPackage.fromJson(Map<String, dynamic> json) => ApiModelRandomPackage(
//     packageId: json["package_id"],
//     randomPackage: List<Package>.from(json["random_package"].map((x) => Package.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "package_id": packageId,
//     "random_package": List<dynamic>.from(randomPackage.map((x) => x.toJson())),
//   };
// }
//
// class RandomPackageRandomPackage {
//   RandomPackageRandomPackage({
//     this.packages,
//   });
//
//   List<Package> packages;
//
//   factory RandomPackageRandomPackage.fromJson(Map<String, dynamic> json) => RandomPackageRandomPackage(
//     packages: List<Package>.from(json["packages"].map((x) => Package.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "packages": List<dynamic>.from(packages.map((x) => x.toJson())),
//   };
// }
//
//
// class Package {
//   Package({
//     this.userIdFrom2Answer,
//     this.chosen2LabelByUser2,
//     this.text,
//     this.projectId,
//     this.userIdFrom3Answer,
//     this.possibleLabel3,
//     this.possibleLabel1,
//     this.header,
//     this.textId,
//     this.chosen1LabelByUser1,
//     this.chosen3LabelByUser3,
//     this.possibleLabel2,
//     this.userIdFrom1Answer,
//     this.labels
//   });
//
//   String userIdFrom2Answer;
//   String chosen2LabelByUser2;
//   String text;
//   int projectId;
//   String userIdFrom3Answer;
//   String possibleLabel3;
//   String possibleLabel1;
//   String header;
//   int textId;
//   String chosen1LabelByUser1;
//   String chosen3LabelByUser3;
//   String possibleLabel2;
//   String userIdFrom1Answer;
//   List<String> labels;
//
//   factory Package.fromJson(Map<String, dynamic> json) => Package(
//     userIdFrom2Answer: json["User_ID from #2 answer"],
//     chosen2LabelByUser2: json["chosen #2 label by user #2"],
//     text: json["text"],
//     projectId: json["Project ID"],
//     userIdFrom3Answer: json["User_ID from #3 answer"],
//     possibleLabel3: json["possible label 3"],
//     possibleLabel1:json["possible label 1"],
//     header: json["Header"],
//     textId: json["text ID"],
//     chosen1LabelByUser1: json["chosen #1 label by user #1"],
//     chosen3LabelByUser3: json["chosen #3 label by user #3"],
//     possibleLabel2: json["possible label 2"],
//     userIdFrom1Answer: json["User_ID from #1 answer"],
//     labels: List<String>.from(json["labels"].map((x) => x)),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "User_ID from #2 answer": userIdFrom2Answer,
//     "chosen #2 label by user #2": chosen2LabelByUser2,
//     "text": text,
//     "Project ID": projectId,
//     "User_ID from #3 answer": userIdFrom3Answer,
//     "possible label 3": possibleLabel3,
//     "possible label 1": possibleLabel1,
//     "Header": header,
//     "text ID": textId,
//     "chosen #1 label by user #1": chosen1LabelByUser1,
//     "chosen #3 label by user #3": chosen3LabelByUser3,
//     "possible label 2": possibleLabel2,
//     "User_ID from #1 answer": userIdFrom1Answer,
//     "labels": List<dynamic>.from(labels.map((x) => x)),
//   };
// }