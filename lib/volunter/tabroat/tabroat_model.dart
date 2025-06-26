// To parse this JSON data, do
//
//     final tabroatModel = tabroatModelFromJson(jsonString);

import 'dart:convert';

TabroatModel tabroatModelFromJson(String str) =>
    TabroatModel.fromJson(json.decode(str));

String tabroatModelToJson(TabroatModel data) => json.encode(data.toJson());

class TabroatModel {
  List<Datum>? data;

  TabroatModel({this.data});

  factory TabroatModel.fromJson(Map<String, dynamic> json) => TabroatModel(
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
  String? amount;
  DateTime? paymentDate;
  String? type;
  String? transferNumber;
  String? status;
  String? image;
  Team? team;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
    this.id,
    this.amount,
    this.paymentDate,
    this.type,
    this.transferNumber,
    this.status,
    this.image,
    this.team,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    amount: json["amount"],
    paymentDate:
        json["payment_date"] == null
            ? null
            : DateTime.parse(json["payment_date"]),
    type: json["type"],
    transferNumber: json["transfer_number"],
    status: json["status"],
    image: json["image"],
    team: json["team"] == null ? null : Team.fromJson(json["team"]),
    createdAt:
        json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt:
        json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "amount": amount,
    "payment_date": paymentDate!.toIso8601String(),
    "type": type,
    "transfer_number": transferNumber,
    "status": status,
    "image": image,
    "team": team!.toJson(),
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
