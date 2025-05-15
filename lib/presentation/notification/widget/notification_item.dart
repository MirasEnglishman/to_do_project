import 'package:to_do_project/data/models/app_notification.dart';
import 'package:flutter/material.dart';

class NotificationItem extends StatelessWidget {
  final AppNotification notification;
  final VoidCallback onTap;
  final VoidCallback onDismiss;

  const NotificationItem({
    Key? key,
    required this.notification,
    required this.onTap,
    required this.onDismiss,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // Определение иконки и цвета для типа уведомления
    IconData icon;
    Color iconColor;
    
    switch (notification.type) {
      case NotificationType.reminder:
        icon = Icons.alarm;
        iconColor = Colors.blue;
        break;
      case NotificationType.completion:
        icon = Icons.task_alt;
        iconColor = Colors.green;
        break;
      case NotificationType.system:
        icon = Icons.system_update;
        iconColor = Colors.purple;
        break;
    }

    // Форматирование времени
    String formattedTime;
    final now = DateTime.now();
    final difference = now.difference(notification.time);
    
    if (difference.inMinutes < 60) {
      formattedTime = '${difference.inMinutes} мин. назад';
    } else if (difference.inHours < 24) {
      formattedTime = '${difference.inHours} ч. назад';
    } else {
      formattedTime = '${difference.inDays} дн. назад';
    }

    return Dismissible(
      key: Key(notification.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: Colors.red,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      onDismissed: (direction) => onDismiss(),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 16,
        ),
        leading: CircleAvatar(
          backgroundColor: iconColor.withOpacity(0.1),
          foregroundColor: iconColor,
          child: Icon(icon),
        ),
        title: Text(
          notification.title,
          style: TextStyle(
            fontWeight: notification.isRead ? FontWeight.normal : FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(notification.message),
            const SizedBox(height: 4),
            Text(
              formattedTime,
              style: TextStyle(
                fontSize: 12,
                color: theme.colorScheme.outline,
              ),
            ),
          ],
        ),
        trailing: notification.isRead
            ? null
            : Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  shape: BoxShape.circle,
                ),
              ),
      ),
    );
  }
}