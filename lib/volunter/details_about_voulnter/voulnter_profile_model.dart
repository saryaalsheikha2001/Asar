// profile_voulnter_model.dart
import 'dart:convert';

ProfileVoulnterModel profileVoulnterModelFromJson(String str) => ProfileVoulnterModel.fromJson(json.decode(str));

String profileVoulnterModelToJson(ProfileVoulnterModel data) => json.encode(data.toJson());

class ProfileVoulnterModel {
    bool success;
    String message;
    Data data;

    ProfileVoulnterModel({
        required this.success,
        required this.message,
        required this.data,
    });

    factory ProfileVoulnterModel.fromJson(Map<String, dynamic> json) => ProfileVoulnterModel(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
    };
}

class Data {
    int id;
    String fullName;
    dynamic nationalNumber;
    dynamic nationality;
    dynamic phone;
    String email;
    dynamic birthDate;
    dynamic image;
    int totalPoints;
    int specializationId;
    DateTime createdAt;
    DateTime updatedAt;
    Specialization specialization;

    Data({
        required this.id,
        required this.fullName,
        this.nationalNumber,
        this.nationality,
        this.phone,
        required this.email,
        this.birthDate,
        this.image,
        required this.totalPoints,
        required this.specializationId,
        required this.createdAt,
        required this.updatedAt,
        required this.specialization,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
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
        specialization: Specialization.fromJson(json["specialization"]),
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
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "specialization": specialization.toJson(),
    };
}

class Specialization {
    int id;
    String name;
    DateTime createdAt;
    DateTime updatedAt;

    Specialization({
        required this.id,
        required this.name,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Specialization.fromJson(Map<String, dynamic> json) => Specialization(
        id: json["id"],
        name: json["name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
