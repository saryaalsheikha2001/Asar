// To parse this JSON data, do
//
//     final complaintModel = complaintModelFromJson(jsonString);

import 'dart:convert';

ComplaintModel complaintModelFromJson(String str) =>
    ComplaintModel.fromJson(json.decode(str));

String complaintModelToJson(ComplaintModel data) => json.encode(data.toJson());

class ComplaintModel {
  List<Datum>? data;

  ComplaintModel({this.data});

  factory ComplaintModel.fromJson(Map<String, dynamic> json) => ComplaintModel(
    data:
        json["data"] == null
            ? []
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  int? id;
  String? type;
  String? content;
  String? status;
  dynamic? team;
  Volunteer? volunteer;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
    this.id,
    this.type,
    this.content,
    this.status,
    this.team,
    this.volunteer,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    type: json["type"],
    content: json["content"],
    status: json["status"],
    team: json["team"],
    volunteer:
        json["volunteer"] == null
            ? null
            : Volunteer.fromJson(json["volunteer"]),
    createdAt:
        json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt:
        json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "content": content,
    "status": status,
    "team": team,
    "volunteer": volunteer!.toJson(),
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}

class Volunteer {
  int? id;
  String? fullName;
  String? nationalNumber;
  String? nationality;
  String? phone;
  String? email;
  String? image;
  DateTime? birthDate;
  DateTime? createdAt;
  DateTime? updatedAt;

  Volunteer({
    this.id,
    this.fullName,
    this.nationalNumber,
    this.nationality,
    this.phone,
    this.email,
    this.image,
    this.birthDate,
    this.createdAt,
    this.updatedAt,
  });

  factory Volunteer.fromJson(Map<String, dynamic> json) => Volunteer(
    id: json["id"],
    fullName: json["full_name"],
    nationalNumber: json["national_number"],
    nationality: json["nationality"],
    phone: json["phone"],
    email: json["email"],
    image: json["image"],
    birthDate:
        json["birth_date"] == null ? null : DateTime.parse(json["birth_date"]),
    createdAt:
        json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt:
        json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "full_name": fullName,
    "national_number": nationalNumber,
    "nationality": nationality,
    "phone": phone,
    "email": email,
    "image": image,
    "birth_date": birthDate!.toIso8601String(),
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}
