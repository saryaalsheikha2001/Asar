import 'package:get/get.dart';

class ChatController extends GetxController {
  List<Map<String, dynamic>> messages = [];

  get messageController => null;

  void sendMessage(String message, {bool isMe = true}) {
    if (message.trim().isEmpty) return;

    messages.add({
      'text': message,
      'isMe': isMe,
      'imageUrl': 'https://i.imgur.com/QCNbOAo.png',
    });

    update(); // لإعادة بناء الواجهة
  }
}
