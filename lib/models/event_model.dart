import 'dart:convert';

EventResponse welcomeFromJson(String str) =>
    EventResponse.fromJson(json.decode(str));

String welcomeToJson(EventResponse data) => json.encode(data.toJson());

class EventResponse {
  final bool success;
  final String message;
  final List<EventModel> data;

  EventResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory EventResponse.fromJson(Map<String, dynamic> json) => EventResponse(
        success: json["success"] ?? false,
        message: json["message"] ?? "",
        data: List<EventModel>.from(
            (json["data"] ?? []).map((x) => EventModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class EventModel {
  final dynamic location;
  final String id;
  final String thumbnailImage;
  final String introMedia;
  final String name;
  final DateTime time;
  final String description;
  final List<String> tags;
  final int price;
  final String category;
  final String creator;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

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

  factory EventModel.fromJson(Map<String, dynamic> json) {
    try {
      return EventModel(
        location: json["location"] == null
            ? null
            : json["location"] is String
                ? json["location"]
                : LocationClass.fromJson(json["location"]),
        id: json["_id"] ?? "",
        thumbnailImage: json["thumbnailImage"] ?? "",
        introMedia: json["introMedia"] ?? "",
        name: json["name"] ?? "",
        time: DateTime.tryParse(json["time"] ?? "") ?? DateTime.now(),
        description: json["description"] ?? "",
        tags: List<String>.from((json["tags"] ?? []).map((x) => x.toString())),
        price: json["price"]?.toInt() ?? 0,
        category: json["category"] ?? "",
        creator: json["creator"] ?? "",
        createdAt: DateTime.tryParse(json["createdAt"] ?? "") ?? DateTime.now(),
        updatedAt: DateTime.tryParse(json["updatedAt"] ?? "") ?? DateTime.now(),
        v: json["__v"]?.toInt() ?? 0,
      );
    } catch (e) {
      print('Error parsing EventModel: $e');
      // Return a default event model in case of parsing errors
      return EventModel(
        location: null,
        id: "",
        thumbnailImage: "",
        introMedia: "",
        name: "Error Loading Event",
        time: DateTime.now(),
        description: "",
        tags: [],
        price: 0,
        category: "",
        creator: "",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        v: 0,
      );
    }
  }

  Map<String, dynamic> toJson() => {
        "location": location == null
            ? null
            : location is String
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
  final String name;
  final List<double> coordinate;

  LocationClass({
    required this.name,
    required this.coordinate,
  });

  factory LocationClass.fromJson(Map<String, dynamic> json) {
    try {
      return LocationClass(
        name: json["name"] ?? "",
        coordinate: List<double>.from(
            (json["coordinate"] ?? []).map((x) => (x ?? 0).toDouble())),
      );
    } catch (e) {
      print('Error parsing LocationClass: $e');
      return LocationClass(name: "", coordinate: []);
    }
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "coordinate": List<dynamic>.from(coordinate.map((x) => x)),
      };
}
