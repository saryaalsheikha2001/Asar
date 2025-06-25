import 'package:flutter/material.dart';

class ChatTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  ChatTile({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: Icon(Icons.group),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }
}
