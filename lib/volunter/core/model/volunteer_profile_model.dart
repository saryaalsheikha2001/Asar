// To parse this JSON data, do
//
//     final volunteerProfileModel = volunteerProfileModelFromJson(jsonString);

import 'dart:convert';

VolunteerProfileModel volunteerProfileModelFromJson(String str) =>
    VolunteerProfileModel.fromJson(json.decode(str));

String volunteerProfileModelToJson(VolunteerProfileModel data) =>
    json.encode(data.toJson());

class VolunteerProfileModel {
  bool? success;
  String? message;
  Data? data;

  VolunteerProfileModel({this.success, this.message, this.data});

  factory VolunteerProfileModel.fromJson(Map<String, dynamic> json) =>
      VolunteerProfileModel(
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
  int? id;
  String? fullName;
  String? nationalNumber;
  String? nationality;
  String? phone;
  String? email;
  DateTime? birthDate;
  String? image;
  int? totalPoints;
  int? specializationId;
  DateTime? createdAt;
  DateTime? updatedAt;
  Specialization? specialization;

  Data({
    this.id,
    this.fullName,
    this.nationalNumber,
    this.nationality,
    this.phone,
    this.email,
    this.birthDate,
    this.image,
    this.totalPoints,
    this.specializationId,
    this.createdAt,
    this.updatedAt,
    this.specialization,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    fullName: json["full_name"],
    nationalNumber: json["national_number"],
    nationality: json["nationality"],
    phone: json["phone"],
    email: json["email"],
    birthDate:
        json["birth_date"] == null ? null : DateTime.parse(json["birth_date"]),
    image: json["image"],
    totalPoints: json["total_points"],
    specializationId: json["specialization_id"],
    createdAt:
        json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt:
        json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    specialization:
        json["specialization"] == null
            ? null
            : Specialization.fromJson(json["specialization"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "full_name": fullName,
    "national_number": nationalNumber,
    "nationality": nationality,
    "phone": phone,
    "email": email,
    "birth_date": birthDate?.toIso8601String(),
    "image": image,
    "total_points": totalPoints,
    "specialization_id": specializationId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "specialization": specialization?.toJson(),
  };
}

class Specialization {
  int? id;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;

  Specialization({this.id, this.name, this.createdAt, this.updatedAt});

  factory Specialization.fromJson(Map<String, dynamic> json) => Specialization(
    id: json["id"],
    name: json["name"],
    createdAt:
        json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt:
        json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
