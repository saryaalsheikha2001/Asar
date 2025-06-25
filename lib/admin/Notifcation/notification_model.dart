class NotificationModel {
  final String title;
  final String message;
  final DateTime createdAt;
  final bool isRead;

  NotificationModel({
    required this.title,
    required this.message,
    required this.createdAt,
    required this.isRead,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      title: json['data']['title'],
      message: json['data']['message'],
      createdAt: DateTime.parse(json['created_at']),
      isRead: json['read_at'] != null,
    );
  }
}
