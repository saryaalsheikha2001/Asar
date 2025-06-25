import 'dart:convert';

ComplaintHmlaModel complaintHmlaModelFromJson(String str) =>
    ComplaintHmlaModel.fromJson(json.decode(str));

String complaintHmlaModelToJson(ComplaintHmlaModel data) =>
    json.encode(data.toJson());

class ComplaintHmlaModel {
  List<Datum>? data;

  ComplaintHmlaModel({this.data});

  factory ComplaintHmlaModel.fromJson(Map<String, dynamic> json) =>
      ComplaintHmlaModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  int? id;
  String? type;
  String? content;
  String? status;
  int? volunteerId;
  int? teamId;
  DateTime? createdAt;
  DateTime? updatedAt;
  Volunteer? volunteer;

  Datum({
    this.id,
    this.type,
    this.content,
    this.status,
    this.volunteerId,
    this.teamId,
    this.createdAt,
    this.updatedAt,
    this.volunteer,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        type: json["type"],
        content: json["content"],
        status: json["status"],
        volunteerId: json["volunteer_id"],
        teamId: json["team_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        volunteer: Volunteer.fromJson(json["volunteer"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "content": content,
        "status": status,
        "volunteer_id": volunteerId,
        "team_id": teamId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "volunteer": volunteer?.toJson(),
      };
}

class Volunteer {
  int? id;
  String? fullName;
  dynamic? nationalNumber;
  dynamic? nationality;
  dynamic? phone;
  String? email;
  dynamic? birthDate;
  dynamic? image;
  int? totalPoints;
  int? specializationId;
  DateTime? createdAt;
  DateTime? updatedAt;

  Volunteer({
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
  });

  factory Volunteer.fromJson(Map<String, dynamic> json) => Volunteer(
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
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
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
      };
}
