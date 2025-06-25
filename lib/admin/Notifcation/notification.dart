import 'package:flutter/material.dart';
import 'notification_model.dart';
import 'package:intl/intl.dart';

class NotificationsPage extends StatelessWidget {
  final List<NotificationModel> notifications;

  const NotificationsPage({super.key, required this.notifications});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("الإشعارات")),
      body: ListView.separated(
        itemCount: notifications.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.pink.shade100,
              child: const Text("V.", style: TextStyle(color: Colors.black)),
            ),
            title: Text(notification.title, overflow: TextOverflow.ellipsis),
            subtitle: Text(notification.message),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(DateFormat('MMM d, yyyy').format(notification.createdAt),
                    style: const TextStyle(fontSize: 12)),
                if (!notification.isRead)
                  const Icon(Icons.circle, color: Colors.blue, size: 10),
              ],
            ),
          );
        },
      ),
    );
  }
}
