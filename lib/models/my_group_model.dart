import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  bool? success;
  String? message;
  List<MyGroup>? data;

  Welcome({
    this.success,
    this.message,
    this.data,
  });

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<MyGroup>.from(json["data"]!.map((x) => MyGroup.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class MyGroup {
  String? id;
  String? name;
  List<Member>? members;
  String? event;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  bool? is2Message;

  MyGroup({
    this.id,
    this.name,
    this.members,
    this.event,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.is2Message,
  });

  factory MyGroup.fromJson(Map<String, dynamic> json) => MyGroup(
        id: json["_id"],
        name: json["name"],
        members: json["members"] == null
            ? []
            : List<Member>.from(
                json["members"]!.map((x) => Member.fromJson(x))),
        event: json["event"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        is2Message: json["is2Message"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "members": members == null
            ? []
            : List<dynamic>.from(members!.map((x) => x.toJson())),
        "event": event,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "is2Message": is2Message,
      };
}

class Member {
  String? id;
  String? name;
  String? email;
  String? profile;

  Member({
    this.id,
    this.name,
    this.email,
    this.profile,
  });

  factory Member.fromJson(Map<String, dynamic> json) => Member(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        profile: json["profile"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "profile": profile,
      };
}
