// To parse this JSON data, do
//
//     final registerVolunteerModel = registerVolunteerModelFromJson(jsonString);

import 'dart:convert';

RegisterVolunteerModel registerVolunteerModelFromJson(String str) =>
    RegisterVolunteerModel.fromJson(json.decode(str));

String registerVolunteerModelToJson(RegisterVolunteerModel data) =>
    json.encode(data.toJson());

class RegisterVolunteerModel {
  bool? success;
  String? message;
  Data? data;

  RegisterVolunteerModel({this.success, this.message, this.data});

  factory RegisterVolunteerModel.fromJson(Map<String, dynamic> json) =>
      RegisterVolunteerModel(
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
  Volunteer? volunteer;
  String? token;

  Data({this.volunteer, this.token});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    volunteer:
        json["volunteer"] == null
            ? null
            : Volunteer.fromJson(json["volunteer"]),
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "volunteer": volunteer?.toJson(),
    "token": token,
  };
}

class Volunteer {
  String? fullName;
  String? email;
  String? specializationId;
  int? totalPoints;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  Volunteer({
    this.fullName,
    this.email,
    this.specializationId,
    this.totalPoints,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory Volunteer.fromJson(Map<String, dynamic> json) => Volunteer(
    fullName: json["full_name"],
    email: json["email"],
    specializationId: json["specialization_id"],
    totalPoints: json["total_points"],
    updatedAt:
        json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt:
        json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "full_name": fullName,
    "email": email,
    "specialization_id": specializationId,
    "total_points": totalPoints,
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "id": id,
  };
}
