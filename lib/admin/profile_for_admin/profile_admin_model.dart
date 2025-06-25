import 'dart:convert';

ProfileAdminModel profileAdminModelFromJson(String str) =>
    ProfileAdminModel.fromJson(json.decode(str));

String profileAdminModelToJson(ProfileAdminModel data) =>
    json.encode(data.toJson());

class ProfileAdminModel {
  final bool? success;
  final String? message;
  final AdminData? data;

  ProfileAdminModel({this.success, this.message, this.data});

  factory ProfileAdminModel.fromJson(Map<String, dynamic> json) =>
      ProfileAdminModel(
        success: json["success"] ?? false,
        message: json["message"] ?? "",
        data: AdminData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class AdminData {
  final int? id;
  final String? fullName;
  final String? email;
  final String? nationalNumber;
  final String? position;
  final String? phone;
  final String? address;
  final DateTime? dateAccession;
  final String? image;
  final int? teamId;
  final int? specializationId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Specialization? specialization;

  AdminData({
    this.id,
    this.fullName,
    this.email,
    this.nationalNumber,
    this.position,
    this.phone,
    this.address,
    this.dateAccession,
    this.image,
    this.teamId,
    this.specializationId,
    this.createdAt,
    this.updatedAt,
    this.specialization,
  });

  factory AdminData.fromJson(Map<String, dynamic> json) => AdminData(
    id: json["id"],
    fullName: json["full_name"] ?? '',
    email: json["email"] ?? '',
    nationalNumber: json["national_number"] ?? '',
    position: json["position"] ?? '',
    phone: json["phone"] ?? '',
    address: json["address"] ?? '',
    dateAccession:
        json["date_accession"] == null
            ? null
            : DateTime.parse(json["date_accession"]),
    image: json["image"] ?? '',
    teamId: json["team_id"] ?? 0,
    specializationId: json["specialization_id"] ?? 0,
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
    "email": email,
    "national_number": nationalNumber,
    "position": position,
    "phone": phone,
    "address": address,
    "date_accession": dateAccession?.toIso8601String(),
    "image": image,
    "team_id": teamId,
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

  Specialization({this.id, this.name, this.createdAt, this.updatedAt});

  factory Specialization.fromJson(Map<String, dynamic> json) => Specialization(
    id: json["id"],
    name: json["name"] ?? '',
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
