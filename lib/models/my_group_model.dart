import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  bool success;
  String message;
  List<MyGroup> data;

  Welcome({
    required this.success,
    required this.message,
    required this.data,
  });

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        success: json["success"],
        message: json["message"],
        data: List<MyGroup>.from(json["data"].map((x) => MyGroup.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class MyGroup {
  String id;
  String name;
  List<String> members;
  String event;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  MyGroup({
    required this.id,
    required this.name,
    required this.members,
    required this.event,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory MyGroup.fromJson(Map<String, dynamic> json) => MyGroup(
        id: json["_id"],
        name: json["name"],
        members: List<String>.from(json["members"].map((x) => x)),
        event: json["event"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "members": List<dynamic>.from(members.map((x) => x)),
        "event": event,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
