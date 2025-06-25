import 'dart:convert';
import 'dart:developer';

import 'package:athar_project/network.dart';
import 'package:athar_project/volunter/chat_voulnter/chat_model.dart';
import 'package:athar_project/volunter/chat_voulnter/chat_rom_controller.dart';
import 'package:athar_project/volunter/chat_voulnter/chat_room_page.dart';
import 'package:athar_project/volunter/storage/volunteer_storage_service.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ChatRoomsController extends GetxController {
  var chatRooms = <ChatRoomModel>[].obs;
  var isLoading = true.obs;

  @override
  Future onInit() async {
    super.onInit();
    await fetchChatRooms();
  }

  Future fetchChatRooms() async {
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
        url: "my-chat-rooms",
        headers: authHeaders,
      );
      log(response.body.toString(), name: "fetchChatRooms response body");
      if (response.statusCode == 200) {
        var data = <dynamic>[];
        data = json.decode(response.body);
        chatRooms.value = data.map((e) => ChatRoomModel.fromJson(e)).toList();
        // return CompagineAdminModel.fromJson(data);
      }
    } catch (e) {
      log(e.toString(), name: "fetchChatRooms catch error");
    } finally {}
    // chatRooms.assignAll([]); // عيّن الداتا القادمة من الـ API

    isLoading.value = false;
  }

  void goToChatRoom(ChatRoomModel room) {
    Get.put(ChatRoomController(room)).onInit();
    Get.to(() => ChatRoomPage());
  }
}
