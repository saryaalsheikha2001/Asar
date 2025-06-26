// To parse this JSON data, do
//
//     final teamsModel = teamsModelFromJson(jsonString);

import 'dart:convert';

TeamsModel teamsModelFromJson(String str) =>
    TeamsModel.fromJson(json.decode(str));

String teamsModelToJson(TeamsModel data) => json.encode(data.toJson());

class TeamsModel {
  List<TeamsData>? data;

  TeamsModel({this.data});

  factory TeamsModel.fromJson(Map<String, dynamic> json) => TeamsModel(
    data:
        json["data"] == null
            ? []
            : List<TeamsData>.from(
              json["data"].map((x) => TeamsData.fromJson(x)),
            ),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class TeamsData {
  int? id;
  String? fullName;
  String? teamName;
  String? licenseNumber;
  String? logo;
  String? phone;
  String? bankAccountNumber;
  String? email;
  DateTime? createdAt;
  DateTime? updatedAt;

  TeamsData({
    this.id,
    this.fullName,
    this.teamName,
    this.licenseNumber,
    this.logo,
    this.phone,
    this.bankAccountNumber,
    this.email,
    this.createdAt,
    this.updatedAt,
  });

  factory TeamsData.fromJson(Map<String, dynamic> json) => TeamsData(
    id: json["id"],
    fullName: json["full_name"],
    teamName: json["team_name"],
    licenseNumber: json["license_number"],
    logo: json["logo"],
    phone: json["phone"],
    bankAccountNumber: json["bank_account_number"],
    email: json["email"],
    createdAt:
        json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt:
        json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "full_name": fullName,
    "team_name": teamName,
    "license_number": licenseNumber,
    "logo": logo,
    "phone": phone,
    "bank_account_number": bankAccountNumber,
    "email": email,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}
