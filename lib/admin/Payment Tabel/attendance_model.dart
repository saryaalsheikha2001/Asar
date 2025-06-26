class AttendanceModel {
  final int? id;
  final int volunteerId;
  final String fullName;

  AttendanceModel({
    this.id,
    required this.volunteerId,
    required this.fullName,
  });

  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(
      id: json['id'],
      volunteerId: json['volunteer']['id'],
      fullName: json['volunteer']['full_name'] ?? '',
    );
  }
}
