class AttendanceModel {
  final int id;
  final bool isAttendance;
  final int pointsEarned;
  final String? image;
  final String volunteerName;
  final String? volunteerImage;
  final int totalPoints;
  final String employeeName;
  final String? employeeImage;
  final DateTime createdAt;

  AttendanceModel({
    required this.id,
    required this.isAttendance,
    required this.pointsEarned,
    this.image,
    required this.volunteerName,
    this.volunteerImage,
    required this.totalPoints,
    required this.employeeName,
    this.employeeImage,
    required this.createdAt,
  });

  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(
      id: json['id'],
      isAttendance: json['is_attendance'] == 1,
      pointsEarned: json['points_earned'],
      image: json['image'],
      volunteerName: json['volunteer']['full_name'],
      volunteerImage: json['volunteer']['image'],
      totalPoints: json['volunteer']['total_points'],
      employeeName: json['employee']['full_name'],
      employeeImage: json['employee']['image'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}

