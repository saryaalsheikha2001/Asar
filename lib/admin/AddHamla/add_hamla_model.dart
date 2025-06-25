
import 'dart:convert';

CreateCampaignModel createCampaignModelFromJson(String str) =>
    CreateCampaignModel.fromJson(json.decode(str));

String createCampaignModelToJson(CreateCampaignModel data) =>
    json.encode(data.toJson());

class CreateCampaignModel {
  Data? data;

  CreateCampaignModel({this.data});

  factory CreateCampaignModel.fromJson(Map<String, dynamic> json) =>
      CreateCampaignModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
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
  String? specializationId;
  String? campaignTypeId;
  int? teamId;
  int? employeeId;
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
    this.specializationId,
    this.campaignTypeId,
    this.teamId,
    this.employeeId,
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
        specializationId: json["specialization_id"],
        campaignTypeId: json["campaign_type_id"],
        teamId: json["team_id"],
        employeeId: json["employee_id"],
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
        "specialization_id": specializationId,
        "campaign_type_id": campaignTypeId,
        "team_id": teamId,
        "employee_id": employeeId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
