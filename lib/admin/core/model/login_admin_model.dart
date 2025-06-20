// To parse this JSON data, do
//
//     final loginAdminModel = loginAdminModelFromJson(jsonString);

import 'dart:convert';

LoginAdminModel loginAdminModelFromJson(String str) =>
    LoginAdminModel.fromJson(json.decode(str));

String loginAdminModelToJson(LoginAdminModel data) =>
    json.encode(data.toJson());

class LoginAdminModel {
  String? message;
  Employee? employee;
  String? token;

  LoginAdminModel({this.message, this.employee, this.token});

  factory LoginAdminModel.fromJson(Map<String, dynamic> json) =>
      LoginAdminModel(
        message: json["message"],
        employee:
            json["Employee"] == null
                ? null
                : Employee.fromJson(json["Employee"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
    "message": message,
    "Employee": employee!.toJson(),
    "token": token,
  };
}

class Employee {
  int? id;
  String? fullName;
  String? email;
  String? nationalNumber;
  String? position;
  String? phone;
  String? address;
  DateTime? dateAccession;
  String? image;
  int? teamId;
  int? specializationId;
  DateTime? createdAt;
  DateTime? updatedAt;

  Employee({
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
    this.updatedAt, int? team, int? specialization,
  });

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
    id: json["id"],
    fullName: json["full_name"],
    email: json["email"],
    nationalNumber: json["national_number"],
    position: json["position"],
    phone: json["phone"],
    address: json["address"],
    dateAccession:
        json["date_accession"] == null
            ? null
            : DateTime.parse(json["date_accession"]),
    image: json["image"],
    teamId: json["team_id"],
    specializationId: json["specialization_id"],
    createdAt:
        json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt:
        json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
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
  };
}
