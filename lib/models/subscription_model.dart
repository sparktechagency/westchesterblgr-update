import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  bool success;
  String message;
  Pagination pagination;
  List<Subscription> data;

  Welcome({
    required this.success,
    required this.message,
    required this.pagination,
    required this.data,
  });

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        success: json["success"],
        message: json["message"],
        pagination: Pagination.fromJson(json["pagination"]),
        data: List<Subscription>.from(
            json["data"].map((x) => Subscription.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "pagination": pagination.toJson(),
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Subscription {
  String id;
  String name;
  int allowedJobPost;
  int allowedEventPost;
  List<String> features;
  int price;
  String priceId;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  Subscription({
    required this.id,
    required this.name,
    required this.allowedJobPost,
    required this.allowedEventPost,
    required this.features,
    required this.price,
    required this.priceId,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
        id: json["_id"],
        name: json["name"],
        allowedJobPost: json["allowedJobPost"],
        allowedEventPost: json["allowedEventPost"],
        features: List<String>.from(json["features"].map((x) => x)),
        price: json["price"],
        priceId: json["priceId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "allowedJobPost": allowedJobPost,
        "allowedEventPost": allowedEventPost,
        "features": List<dynamic>.from(features.map((x) => x)),
        "price": price,
        "priceId": priceId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class Pagination {
  int limit;
  int page;
  int total;
  int totalPage;

  Pagination({
    required this.limit,
    required this.page,
    required this.total,
    required this.totalPage,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        limit: json["limit"],
        page: json["page"],
        total: json["total"],
        totalPage: json["totalPage"],
      );

  Map<String, dynamic> toJson() => {
        "limit": limit,
        "page": page,
        "total": total,
        "totalPage": totalPage,
      };
}
