import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String text;
  final bool isMe;
  final String imageUrl;

  const MessageBubble({
    super.key,
    required this.text,
    required this.isMe,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final bubbleColor = isMe ? const Color(0xFF0b3c5d) : const Color(0xFFF0F0F0);
    final textColor = isMe ? Colors.white : Colors.black87;

    return Row(
      mainAxisAlignment:
          isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (!isMe)
          CircleAvatar(radius: 16, backgroundImage: NetworkImage(imageUrl)),
        const SizedBox(width: 6),
        Flexible(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: bubbleColor,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(20),
                topRight: const Radius.circular(20),
                bottomLeft: Radius.circular(isMe ? 20 : 0),
                bottomRight: Radius.circular(isMe ? 0 : 20),
              ),
            ),
            child: Text(
              text,
              style: TextStyle(fontSize: 15, color: textColor),
            ),
          ),
        ),
        const SizedBox(width: 6),
        if (isMe)
          CircleAvatar(radius: 16, backgroundImage: NetworkImage(imageUrl)),
      ],
    );
  }
}
