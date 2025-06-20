// To parse this JSON data, do
//
//     final campaignDetailsModel = campaignDetailsModelFromJson(jsonString);

import 'dart:convert';

CampaignDetailsModel campaignDetailsModelFromJson(String str) =>
    CampaignDetailsModel.fromJson(json.decode(str));

String campaignDetailsModelToJson(CampaignDetailsModel data) =>
    json.encode(data.toJson());

class CampaignDetailsModel {
  Data? data;

  CampaignDetailsModel({this.data});

  factory CampaignDetailsModel.fromJson(Map<String, dynamic> json) =>
      CampaignDetailsModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {"data": data!.toJson()};
}

class Data {
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
  List<dynamic>? volunteers;
  DateTime? createdAt;
  DateTime? updatedAt;

  Data({
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
    this.volunteers,
    this.createdAt,
    this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
    volunteers:
        json["volunteers"] == null
            ? []
            : List<dynamic>.from(json["volunteers"].map((x) => x)),
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
    "from": from!.toIso8601String(),
    "to": to!.toIso8601String(),
    "points": points,
    "status": status,
    "specialization": specialization!.toJson(),
    "campaign_type": campaignType!.toJson(),
    "team": team!.toJson(),
    "employee": employee!.toJson(),
    "volunteers": List<dynamic>.from(volunteers!.map((x) => x)),
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
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
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
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
    "date_accession": dateAccession.toString(),
    "image": image,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
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
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}
