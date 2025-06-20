import 'package:athar_project/admin/chat_Admin/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'chat_controller.dart';

class CampaignChatPage extends StatelessWidget {
  CampaignChatPage({super.key, required campaignName});

  final TextEditingController messageController = TextEditingController();
  final ChatController chatController = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 51, 102, 1),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Asar team",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          // الرسائل
          Expanded(
            child: GetBuilder<ChatController>(
              builder:
                  (controller) => ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: controller.messages.length,
                    itemBuilder: (context, index) {
                      final msg = controller.messages[index];
                      return MessageBubble(
                        text: msg['text'],
                        isMe: msg['isMe'],
                        imageUrl: msg['imageUrl'],
                      );
                    },
                  ),
            ),
          ),

          // حقل الكتابة
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey, width: 0.3)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      hintText: "اكتب رسالتك",
                      hintStyle: TextStyle(color: Colors.grey[500]),
                      filled: true,
                      fillColor: const Color(0xFFF0F0F0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFF0b3c5d),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: () {
                      chatController.sendMessage(messageController.text);
                      messageController.clear();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
