import 'dart:convert';

EventResponse welcomeFromJson(String str) =>
    EventResponse.fromJson(json.decode(str));

String welcomeToJson(EventResponse data) => json.encode(data.toJson());

class EventResponse {
  bool success;
  String message;
  List<EventModel> data;

  EventResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory EventResponse.fromJson(Map<String, dynamic> json) => EventResponse(
        success: json["success"],
        message: json["message"],
        data: List<EventModel>.from(
            json["data"].map((x) => EventModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class EventModel {
  dynamic location;
  String id;
  String thumbnailImage;
  String introMedia;
  String name;
  DateTime time;
  String description;
  List<String> tags;
  int price;
  String category;
  String creator;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  EventModel({
    required this.location,
    required this.id,
    required this.thumbnailImage,
    required this.introMedia,
    required this.name,
    required this.time,
    required this.description,
    required this.tags,
    required this.price,
    required this.category,
    required this.creator,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
        location: json["location"] is String
            ? json["location"]
            : LocationClass.fromJson(json["location"]),
        id: json["_id"],
        thumbnailImage: json["thumbnailImage"],
        introMedia: json["introMedia"],
        name: json["name"],
        time: DateTime.parse(json["time"]),
        description: json["description"],
        tags: List<String>.from(json["tags"].map((x) => x)),
        price: json["price"],
        category: json["category"],
        creator: json["creator"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "location": location is String
            ? location
            : (location as LocationClass).toJson(),
        "_id": id,
        "thumbnailImage": thumbnailImage,
        "introMedia": introMedia,
        "name": name,
        "time": time.toIso8601String(),
        "description": description,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "price": price,
        "category": category,
        "creator": creator,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class LocationClass {
  String name;
  List<double> coordinate;

  LocationClass({
    required this.name,
    required this.coordinate,
  });

  factory LocationClass.fromJson(Map<String, dynamic> json) => LocationClass(
        name: json["name"],
        coordinate:
            List<double>.from(json["coordinate"].map((x) => x.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "coordinate": List<dynamic>.from(coordinate.map((x) => x)),
      };
}
