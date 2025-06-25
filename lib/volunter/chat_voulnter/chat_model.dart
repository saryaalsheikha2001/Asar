class ChatRoomModel {
  final int id;
  final String campaignName;
  final List<MessageModel> messages;

  ChatRoomModel({
    required this.id,
    required this.campaignName,
    required this.messages,
  });

  factory ChatRoomModel.fromJson(Map<String, dynamic> json) {
    return ChatRoomModel(
      id: json['id'],
      campaignName: json['campaign']['campaign_name'],
      messages: (json['messages'] as List)
          .map((msg) => MessageModel.fromJson(msg))
          .toList(),
    );
  }
}

class MessageModel {
  final int id;
  final String message;
  final String createdAt;
  final String senderType;
  final Sender sender;

  MessageModel({
    required this.id,
    required this.message,
    required this.createdAt,
    required this.senderType,
    required this.sender,
  });

  bool get isFromEmployee => senderType.contains('Employee');

  String get createdAtFormatted {
    return createdAt.split('T').first;
  }

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'],
      message: json['message'],
      createdAt: json['created_at'],
      senderType: json['sender_type'],
      sender: Sender.fromJson(json['sender']),
    );
  }
}

class Sender {
  final String fullName;
  final String? image;

  Sender({required this.fullName, this.image});

  factory Sender.fromJson(Map<String, dynamic> json) {
    return Sender(
      fullName: json['full_name'],
      image: json['image'],
    );
  }
}
