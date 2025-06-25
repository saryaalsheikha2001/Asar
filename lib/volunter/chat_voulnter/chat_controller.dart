// chat_controller.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../storage/volunteer_storage_service.dart';

class ChatController extends GetxController {
  List<Map<String, dynamic>> messages = [];
  TextEditingController messageController = TextEditingController();

  get chats => null;

  Future<void> loadMessages(int chatRoomId) async {
    final token = Get.find<StorageService>().getVolunteerTokenInfo().token ?? '';

    try {
      final response = await http.get(
        Uri.parse("http://volunteer.test-holooltech.com/api/get-Messages/$chatRoomId"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        messages = data.map((e) {
          final isMe = e["sender_type"] == "App\\Models\\Volunteer";
          return {
            "sender": isMe ? "أنا" : e["sender"]["full_name"] ?? "موظف",
            "text": e["message"],
          };
        }).toList();
      } else {
        Get.snackbar("خطأ", "فشل تحميل الرسائل");
      }
    } catch (e) {
      Get.snackbar("خطأ", "حدث خطأ أثناء الاتصال");
    }

    update();
  }

  void sendMessage(String text) {
    if (text.trim().isEmpty) return;

    messages.add({"sender": "أنا", "text": text});
    messageController.clear();
    update();

    // ملاحظة: إضافة رسالة إلى الـ API يمكن تنفيذها لاحقًا إن وجدت نقطة نهاية مناسبة (endpoint)
  }
}
