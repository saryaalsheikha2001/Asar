// volunteer_profile_model.dart

import 'dart:convert';

VoulnterProfileModel voulnterProfileModelFromJson(String str) =>
    VoulnterProfileModel.fromJson(json.decode(str));

String voulnterProfileModelToJson(VoulnterProfileModel data) =>
    json.encode(data.toJson());

class VoulnterProfileModel {
  final bool? success;
  final String? message;
  final Data? data;

  VoulnterProfileModel({
    this.success,
    this.message,
    this.data,
  });

  factory VoulnterProfileModel.fromJson(Map<String, dynamic> json) =>
      VoulnterProfileModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] != null ? Data.fromJson(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  final int? id;
  final String? fullName;
  final String? nationalNumber;
  final String? nationality;
  final String? phone;
  final String? email;
  final String? birthDate;
  final String? image;
  final int? totalPoints;
  final int? specializationId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Specialization? specialization;

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
        birthDate: json["birth_date"],
        image: json["image"],
        totalPoints: json["total_points"],
        specializationId: json["specialization_id"],
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"])
            : null,
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"])
            : null,
        specialization: json["specialization"] != null
            ? Specialization.fromJson(json["specialization"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
        "national_number": nationalNumber,
        "nationality": nationality,
        "phone": phone,
        "email": email,
        "birth_date": birthDate,
        "image": image,
        "total_points": totalPoints,
        "specialization_id": specializationId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "specialization": specialization?.toJson(),
      };
}

class Specialization {
  final int? id;
  final String? name;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Specialization({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  factory Specialization.fromJson(Map<String, dynamic> json) =>
      Specialization(
        id: json["id"],
        name: json["name"],
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"])
            : null,
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
