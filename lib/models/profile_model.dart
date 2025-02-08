import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  bool success;
  String message;
  Data data;

  Welcome({
    required this.success,
    required this.message,
    required this.data,
  });

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  String id;
  String name;
  String role;
  List<dynamic> eventWishList;
  List<JobWishList> jobWishList;
  String email;
  String profile;
  String status;
  String contact;
  String location;
  bool verified;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  Data({
    required this.id,
    required this.name,
    required this.role,
    required this.eventWishList,
    required this.jobWishList,
    required this.email,
    required this.profile,
    required this.status,
    required this.contact,
    required this.location,
    required this.verified,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        name: json["name"],
        role: json["role"],
        eventWishList: List<dynamic>.from(json["eventWishList"].map((x) => x)),
        jobWishList: List<JobWishList>.from(
            json["jobWishList"].map((x) => JobWishList.fromJson(x))),
        email: json["email"],
        profile: json["profile"],
        status: json["status"],
        contact: json["contact"],
        location: json["location"],
        verified: json["verified"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "role": role,
        "eventWishList": List<dynamic>.from(eventWishList.map((x) => x)),
        "jobWishList": List<dynamic>.from(jobWishList.map((x) => x.toJson())),
        "email": email,
        "profile": profile,
        "status": status,
        "contact": contact,
        "location": location,
        "verified": verified,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class JobWishList {
  String id;
  String image;
  String companyName;
  String role;
  String description;
  String address;
  String level;
  String jobType;
  String salary;
  List<String> questions;
  String postedBy;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  JobWishList({
    required this.id,
    required this.image,
    required this.companyName,
    required this.role,
    required this.description,
    required this.address,
    required this.level,
    required this.jobType,
    required this.salary,
    required this.questions,
    required this.postedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory JobWishList.fromJson(Map<String, dynamic> json) => JobWishList(
        id: json["_id"],
        image: json["image"],
        companyName: json["companyName"],
        role: json["role"],
        description: json["description"],
        address: json["address"],
        level: json["level"],
        jobType: json["jobType"],
        salary: json["salary"],
        questions: List<String>.from(json["questions"].map((x) => x)),
        postedBy: json["postedBy"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "image": image,
        "companyName": companyName,
        "role": role,
        "description": description,
        "address": address,
        "level": level,
        "jobType": jobType,
        "salary": salary,
        "questions": List<dynamic>.from(questions.map((x) => x)),
        "postedBy": postedBy,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
