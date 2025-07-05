
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../domain/notification_module.dart';

class NotificationCard extends StatelessWidget {
  final AppNotification notification;

  const NotificationCard({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Stack(
          children: [
            Icon(
              Icons.notifications,
              color: notification.isRead ? Colors.grey : Colors.deepPurple,
            ),
            if (!notification.isRead)
              const Positioned(
                right: 0,
                top: 0,
                child: CircleAvatar(radius: 5, backgroundColor: Colors.red),
              ),
          ],
        ),
        title: Text(
          notification.title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(notification.message),
            const SizedBox(height: 6),
            Text(
              DateFormat(
                'yMMMd – h:mm a',
              ).format(notification.createdAt.toLocal()),
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
