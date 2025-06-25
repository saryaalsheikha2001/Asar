import 'package:athar_project/volunter/chat_voulnter/chat_roms_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatRoomsPage extends StatelessWidget {
  final controller = Get.put(ChatRoomsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('المحادثات', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Color(0xFF003366),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: controller.chatRooms.length,
          itemBuilder: (context, index) {
            final room = controller.chatRooms[index];
            final lastMessage =
                room.messages.isNotEmpty ? room.messages.last : null;

            return ListTile(
              leading: const CircleAvatar(child: Icon(Icons.chat)),
              title: Text(room.campaignName),
              subtitle: Text(lastMessage?.message ?? 'لا توجد رسائل'),
              trailing: Text(
                lastMessage?.createdAtFormatted ?? '',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              onTap: () => controller.goToChatRoom(room),
            );
          },
        );
      }),
    );
  }
}
