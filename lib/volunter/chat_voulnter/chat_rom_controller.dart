import 'dart:convert';
import 'dart:developer';

import 'package:athar_project/network.dart';
import 'package:athar_project/volunter/chat_voulnter/chat_model.dart';
import 'package:athar_project/volunter/storage/volunteer_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ChatRoomController extends GetxController {
  var isLoading = false.obs;

  final ChatRoomModel room;
  final messageController = TextEditingController();
  var messages = <MessageModel>[].obs;

  ChatRoomController(this.room) {
    messages.assignAll(room.messages.reversed);
  }

  Future fetchChatMessages() async {
    isLoading.value = true;

    // هنا استبدلها بقراءة API
    try {
      Map<String, String> authHeaders = {
        'Accept': 'application/json',
        'Content-type': 'application/json',
        'Authorization':
            'Bearer ${Get.find<StorageService>().getVolunteerTokenInfo().token!}',

        //هي الكلمة بتنحط قبل ال token ليش ؟ لانو santaks
      };

      final http.Response response = await NetworkUtils.get(
        url: "get-Messages/${room.id}",
        headers: authHeaders,
      );
      log(response.body.toString(), name: "fetchChatMessages response body");
      if (response.statusCode == 200) {
        var data = <dynamic>[];
        data = json.decode(response.body);
        messages.value = data.map((e) => MessageModel.fromJson(e)).toList();
        // return CompagineAdminModel.fromJson(data);
      }
    } catch (e) {
      log(e.toString(), name: "fetchChatMessages catch error");
    } finally {}
    // chatRooms.assignAll([]); // عيّن الداتا القادمة من الـ API

    isLoading.value = false;
  }

  Future sendMessage() async {
    try {
      final text = messageController.text.trim();
      if (text.isEmpty) return;

      final newMessage = MessageModel(
        id: messages.length + 1,
        message: text,
        createdAt: DateTime.now().toIso8601String(),
        senderType: 'App\\Models\\Employee',
        sender: Sender(fullName: 'أنت'),
      );

      messages.insert(0, newMessage);
      messageController.clear();

      // send to API...

      Map<String, String> authHeaders = {
        'Accept': 'application/json',
        'Content-type': 'application/json',
        'Authorization':
            'Bearer ${Get.find<StorageService>().getVolunteerTokenInfo().token!}',

        //هي الكلمة بتنحط قبل ال token ليش ؟ لانو santaks
      };

      final http.Response response = await NetworkUtils.post(
        url: "send-message/${room.id}",
        headers: authHeaders,
        body: json.encode({"message": text}),
      );
      log(response.body.toString(), name: "sendMessage response body");
      if (response.statusCode == 200) {
        // var data = <dynamic>[];
        // data = json.decode(response.body);
        // messages.value = data.map((e) => MessageModel.fromJson(e)).toList();
        // return CompagineAdminModel.fromJson(data);
      }
    } catch (e) {
      log(e.toString(), name: "sendMessage catch error");
    } finally {}
  }

  @override
  Future onInit() async {
    // TODO: implement onInit
    super.onInit();
    await fetchChatMessages();
  }
}
