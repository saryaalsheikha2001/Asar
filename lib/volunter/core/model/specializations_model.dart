// To parse this JSON data, do
//
//     final specializationsModel = specializationsModelFromJson(jsonString);

import 'dart:convert';

List<SpecializationsModel> specializationsModelFromJson(String str) =>
    List<SpecializationsModel>.from(
      json.decode(str).map((x) => SpecializationsModel.fromJson(x)),
    );

String specializationsModelToJson(List<SpecializationsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SpecializationsModel {
  int? id;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;

  SpecializationsModel({this.id, this.name, this.createdAt, this.updatedAt});

  factory SpecializationsModel.fromJson(
    Map<String, dynamic> json,
  ) => SpecializationsModel(
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
