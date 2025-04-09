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

  final String type;
  final List<String> tags;
  final int price;
  final String category;
  final Creator creator;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;
  final bool isFavourite;
  String? address;

  EventModel({
    required this.location,
    required this.id,
    required this.thumbnailImage,
    required this.introMedia,
    required this.name,
    required this.time,
    required this.description,
    required this.type,
    required this.tags,
    required this.price,
    required this.category,
    required this.creator,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    this.isFavourite = false,
    this.address,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    try {
      var locationData = json["location"];
      dynamic parsedLocation;

      if (locationData != null) {
        if (locationData is String) {
          parsedLocation = locationData;
        } else if (locationData is Map<String, dynamic>) {
          parsedLocation = LocationClass.fromJson(locationData);
        }
      }

      return EventModel(
        location: parsedLocation,
        id: json["_id"] ?? "",
        thumbnailImage: json["thumbnailImage"] ?? "",
        introMedia: json["introMedia"] ?? "",
        name: json["name"] ?? "",
        time:
            DateTime.tryParse(json["time"]?.toString() ?? "") ?? DateTime.now(),
        description: json["description"] ?? "",
        type: json["type"] ?? "",
        tags: List<String>.from((json["tags"] ?? []).map((x) => x.toString())),
        price: json["price"]?.toInt() ?? 0,
        category: json["category"] ?? "",
        creator: json["creator"] is Map
            ? Creator.fromJson(json["creator"])
            : Creator.empty(),
        createdAt: DateTime.tryParse(json["createdAt"]?.toString() ?? "") ??
            DateTime.now(),
        updatedAt: DateTime.tryParse(json["updatedAt"]?.toString() ?? "") ??
            DateTime.now(),
        v: json["__v"]?.toInt() ?? 0,
        isFavourite: json["isFavourite"] ?? false,
        address: json['address'] as String?,
      );
    } catch (e) {
      print('Error parsing EventModel: $e');
      return EventModel(
        location: null,
        id: "",
        thumbnailImage: "",
        introMedia: "",
        name: "Error Loading Event",
        time: DateTime.now(),
        description: "",
        type: "",
        tags: [],
        price: 0,
        category: "",
        creator: Creator.empty(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        v: 0,
        address: "",
      );
    }
  }

  Map<String, dynamic> toJson() => {
        "location": location is LocationClass ? location.toJson() : location,
        "_id": id,
        "thumbnailImage": thumbnailImage,
        "introMedia": introMedia,
        "name": name,
        "time": time.toIso8601String(),
        "description": description,
        "type": type,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "price": price,
        "category": category,
        "creator": creator.toJson(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "isFavourite": isFavourite,
        "address": address,
      };
}

class Creator {
  final String id;
  final String name;
  final String email;
  final String profile;

  Creator({
    required this.id,
    required this.name,
    required this.email,
    required this.profile,
  });

  factory Creator.fromJson(Map<String, dynamic> json) {
    return Creator(
      id: json["_id"] ?? "",
      name: json["name"] ?? "",
      email: json["email"] ?? "",
      profile: json["profile"] ?? "",
    );
  }

  factory Creator.empty() {
    return Creator(
      id: "",
      name: "",
      email: "",
      profile: "",
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "profile": profile,
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
