// import 'package:athar_project/volunter/chat_voulnter/chat_controller.dart';
// import 'package:athar_project/volunter/chat_voulnter/chat_room_page.dart';
// import 'package:athar_project/volunter/chat_voulnter/chat_tile.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class ChatsPage extends StatelessWidget {
//   final controller = Get.put(ChatController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("المحادثات")),
//       body: GetBuilder<ChatController>(
//         builder: (_) {
//           return ListView.builder(
//             itemCount: controller.chats.length,
//             itemBuilder: (context, index) {
//               final chatName = controller.chats[index];
//               return ChatTile(
//                 title: chatName,
//                 onTap: () {
//                   controller.loadMessages(chatName);
//                   Get.to(() => ChatRoomPage());
//                 },
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
