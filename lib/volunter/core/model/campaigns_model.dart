// To parse this JSON data, do
//
//     final campaignsModel = campaignsModelFromJson(jsonString);

import 'dart:convert';

CampaignsModel campaignsModelFromJson(String str) =>
    CampaignsModel.fromJson(json.decode(str));

String campaignsModelToJson(CampaignsModel data) => json.encode(data.toJson());

class CampaignsModel {
  List<Datum>? data;

  CampaignsModel({this.data});

  factory CampaignsModel.fromJson(Map<String, dynamic> json) => CampaignsModel(
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
  String? campaignName;
  int? numberOfVolunteer;
  String? cost;
  String? address;
  DateTime? from;
  DateTime? to;
  int? points;
  String? status;
  CampaignType? specialization;
  CampaignType? campaignType;
  Team? team;
  Employee? employee;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
    this.id,
    this.campaignName,
    this.numberOfVolunteer,
    this.cost,
    this.address,
    this.from,
    this.to,
    this.points,
    this.status,
    this.specialization,
    this.campaignType,
    this.team,
    this.employee,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    campaignName: json["campaign_name"],
    numberOfVolunteer: json["number_of_volunteer"],
    cost: json["cost"],
    address: json["address"],
    from: json["from"] == null ? null : DateTime.parse(json["from"]),
    to: json["to"] == null ? null : DateTime.parse(json["to"]),
    points: json["points"],
    status: json["status"],
    specialization:
        json["specialization"] == null
            ? null
            : CampaignType.fromJson(json["specialization"]),
    campaignType:
        json["campaign_type"] == null
            ? null
            : CampaignType.fromJson(json["campaign_type"]),
    team: json["team"] == null ? null : Team.fromJson(json["team"]),
    employee:
        json["employee"] == null ? null : Employee.fromJson(json["employee"]),
    createdAt:
        json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt:
        json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "campaign_name": campaignName,
    "number_of_volunteer": numberOfVolunteer,
    "cost": cost,
    "address": address,
    "from": from?.toIso8601String(),
    "to": to?.toIso8601String(),
    "points": points,
    "status": status,
    "specialization": specialization?.toJson(),
    "campaign_type": campaignType?.toJson(),
    "team": team?.toJson(),
    "employee": employee?.toJson(),
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class CampaignType {
  int? id;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;

  CampaignType({this.id, this.name, this.createdAt, this.updatedAt});

  factory CampaignType.fromJson(Map<String, dynamic> json) => CampaignType(
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

class Employee {
  int? id;
  String? fullName;
  String? phone;
  String? nationalNumber;
  String? position;
  DateTime? dateAccession;
  String? image;
  DateTime? createdAt;
  DateTime? updatedAt;

  Employee({
    this.id,
    this.fullName,
    this.phone,
    this.nationalNumber,
    this.position,
    this.dateAccession,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
    id: json["id"],
    fullName: json["full_name"],
    phone: json["phone"],
    nationalNumber: json["national_number"],
    position: json["position"],
    dateAccession:
        json["date_accession"] == null
            ? null
            : DateTime.parse(json["date_accession"]),
    image: json["image"],
    createdAt:
        json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt:
        json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "full_name": fullName,
    "phone": phone,
    "national_number": nationalNumber,
    "position": position,
    "date_accession": dateAccession?.toIso8601String(),
    "image": image,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class Team {
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

  Team({
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

  factory Team.fromJson(Map<String, dynamic> json) => Team(
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
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
