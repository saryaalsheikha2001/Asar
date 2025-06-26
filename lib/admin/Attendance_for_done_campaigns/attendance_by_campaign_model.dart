// To parse this JSON data, do
//
//     final attendanceByCampaignModel = attendanceByCampaignModelFromJson(jsonString);

import 'dart:convert';

AttendanceByCampaignModel attendanceByCampaignModelFromJson(String str) =>
    AttendanceByCampaignModel.fromJson(json.decode(str));

String attendanceByCampaignModelToJson(AttendanceByCampaignModel data) =>
    json.encode(data.toJson());

class AttendanceByCampaignModel {
  String? message;
  List<Attendance>? attendances;

  AttendanceByCampaignModel({this.message, this.attendances});

  factory AttendanceByCampaignModel.fromJson(Map<String, dynamic> json) =>
      AttendanceByCampaignModel(
        message: json["message"],
        attendances:
            json["attendances"] == null
                ? []
                : List<Attendance>.from(
                  json["attendances"].map((x) => Attendance.fromJson(x)),
                ),
      );

  Map<String, dynamic> toJson() => {
    "message": message,
    "attendances": List<dynamic>.from(attendances!.map((x) => x.toJson())),
  };
}

class Attendance {
  int? id;
  int? isAttendance;
  int? pointsEarned;
  String? image;
  int? volunteerId;
  int? campaignId;
  int? employeeId;
  DateTime? createdAt;
  DateTime? updatedAt;
  Volunteer? volunteer;
  Employee? employee;

  Attendance({
    this.id,
    this.isAttendance,
    this.pointsEarned,
    this.image,
    this.volunteerId,
    this.campaignId,
    this.employeeId,
    this.createdAt,
    this.updatedAt,
    this.volunteer,
    this.employee,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) => Attendance(
    id: json["id"],
    isAttendance: json["is_attendance"],
    pointsEarned: json["points_earned"],
    image: json["image"],
    volunteerId: json["volunteer_id"],
    campaignId: json["campaign_id"],
    employeeId: json["employee_id"],
    createdAt:
        json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt:
        json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    volunteer:
        json["volunteer"] == null
            ? null
            : Volunteer.fromJson(json["volunteer"]),
    employee:
        json["employee"] == null ? null : Employee.fromJson(json["employee"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "is_attendance": isAttendance,
    "points_earned": pointsEarned,
    "image": image,
    "volunteer_id": volunteerId,
    "campaign_id": campaignId,
    "employee_id": employeeId,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "volunteer": volunteer!.toJson(),
    "employee": employee!.toJson(),
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
  dynamic? specializationId;
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
    this.updatedAt,
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
    "date_accession": dateAccession!.toIso8601String(),
    "image": image,
    "team_id": teamId,
    "specialization_id": specializationId,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}

class Volunteer {
  int? id;
  String? fullName;
  String? nationalNumber;
  String? nationality;
  String? phone;
  String? email;
  DateTime? birthDate;
  String? image;
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
    birthDate:
        json["birth_date"] == null ? null : DateTime.parse(json["birth_date"]),
    image: json["image"],
    totalPoints: json["total_points"],
    specializationId: json["specialization_id"],
    createdAt:
        json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt:
        json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "full_name": fullName,
    "national_number": nationalNumber,
    "nationality": nationality,
    "phone": phone,
    "email": email,
    "birth_date": birthDate!.toIso8601String(),
    "image": image,
    "total_points": totalPoints,
    "specialization_id": specializationId,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}
