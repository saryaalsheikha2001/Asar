// To parse this JSON data, do
//
//     final loginVolunteerModel = loginVolunteerModelFromJson(jsonString);

import 'dart:convert';

LoginVolunteerModel loginVolunteerModelFromJson(String str) =>
    LoginVolunteerModel.fromJson(json.decode(str));

String loginVolunteerModelToJson(LoginVolunteerModel data) =>
    json.encode(data.toJson());

class LoginVolunteerModel {
  String? message;
  Volunteer? volunteer;
  String? token;

  LoginVolunteerModel({this.message, this.volunteer, this.token});

  factory LoginVolunteerModel.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('data')) {
      // يستخدم في حالة التسجيل
      return LoginVolunteerModel(
        message: json['message'] ?? '',
        volunteer: Volunteer.fromJson(json['data']['volunteer']),
        token: json['data']['token'] ?? '',
      );
    } else {
      // يستخدم في حالة تسجيل الدخول
      return LoginVolunteerModel(
        message: json['message'] ?? '',
        volunteer: Volunteer.fromJson(json['volunteer']),
        token: json['token'] ?? '',
      );
    }

    //  LoginVolunteerModel(
    //     message: json["message"],
    //     volunteer:
    //         json["volunteer"] == null
    //             ? null
    //             : Volunteer.fromJson(json["volunteer"]),
    //     token: json["token"],
    //   );
  }

  Map<String, dynamic> toJson() => {
    "message": message,
    "volunteer": volunteer?.toJson(),
    "token": token,
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
    specializationId: int.parse(json["specialization_id"].toString()),
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
    "birth_date": birthDate,
    "image": image,
    "total_points": totalPoints,
    "specialization_id": specializationId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
