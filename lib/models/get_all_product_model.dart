import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  bool? success;
  String? message;
  Data? data;

  Welcome({
    this.success,
    this.message,
    this.data,
  });

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  Meta? meta;
  List<AllProduct>? data;

  Data({
    this.meta,
    this.data,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        data: json["data"] == null
            ? []
            : List<AllProduct>.from(
                json["data"]!.map((x) => AllProduct.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "meta": meta?.toJson(),
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class AllProduct {
  String? id;
  CreatedBy? createdBy;
  String? image;
  String? name;
  String? description;
  int? price;
  String? country;
  String? state;
  String? city;
  String? phone;
  String? whatsapp;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  AllProduct({
    this.id,
    this.createdBy,
    this.image,
    this.name,
    this.description,
    this.price,
    this.country,
    this.state,
    this.city,
    this.phone,
    this.whatsapp,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory AllProduct.fromJson(Map<String, dynamic> json) => AllProduct(
        id: json["_id"],
        createdBy: json["createdBy"] == null
            ? null
            : CreatedBy.fromJson(json["createdBy"]),
        image: json["image"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        country: json["country"],
        state: json["state"],
        city: json["city"],
        phone: json["phone"],
        whatsapp: json["whatsapp"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "createdBy": createdBy?.toJson(),
        "image": image,
        "name": name,
        "description": description,
        "price": price,
        "country": country,
        "state": state,
        "city": city,
        "phone": phone,
        "whatsapp": whatsapp,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class CreatedBy {
  String? id;
  String? name;
  String? email;

  CreatedBy({
    this.id,
    this.name,
    this.email,
  });

  factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
      };
}

class Meta {
  int? page;
  int? limit;
  int? total;
  int? totalPage;

  Meta({
    this.page,
    this.limit,
    this.total,
    this.totalPage,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        page: json["page"],
        limit: json["limit"],
        total: json["total"],
        totalPage: json["totalPage"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "limit": limit,
        "total": total,
        "totalPage": totalPage,
      };
}
