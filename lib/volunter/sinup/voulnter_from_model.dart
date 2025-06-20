class VolunteerModel {
  final int id;
  final String fullName;
  final String nationalNumber;
  final String nationality;
  final String phone;
  final String email;
  final String birthDate;
  final String image;
  final int specializationId;
  final String specializationName;

  VolunteerModel({
    required this.id,
    required this.fullName,
    required this.nationalNumber,
    required this.nationality,
    required this.phone,
    required this.email,
    required this.birthDate,
    required this.image,
    required this.specializationId,
    required this.specializationName,
  });

  factory VolunteerModel.fromJson(Map<String, dynamic> json) {
    return VolunteerModel(
      id: json['id'],
      fullName: json['full_name'],
      nationalNumber: json['national_number'],
      nationality: json['nationality'],
      phone: json['phone'],
      email: json['email'],
      birthDate: json['birth_date'],
      image: json['image'],
      specializationId: json['specialization_id'],
      specializationName: json['specialization']['name'],
    );
  }
}
