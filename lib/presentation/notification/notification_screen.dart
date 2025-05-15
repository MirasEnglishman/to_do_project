import 'package:to_do_project/data/models/app_notification.dart';
import 'package:to_do_project/presentation/notification/widget/notification_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // Пример списка уведомлений
   final List<AppNotification> _notifications = [
    AppNotification(
      id: '1',
      title: 'notifications.types.reminder'.tr(),
      message: 'notifications.messages.deadline_tomorrow'.tr(args: ['Подготовить презентацию']),
      time: DateTime.now().subtract(const Duration(minutes: 30)),
      isRead: false,
      type: NotificationType.reminder,
    ),
    AppNotification(
      id: '2',
      title: 'notifications.types.completion'.tr(),
      message: 'notifications.messages.task_completed'.tr(args: ['Купить продукты']),
      time: DateTime.now().subtract(const Duration(hours: 2)),
      isRead: true,
      type: NotificationType.completion,
    ),
    AppNotification(
      id: '3',
      title: 'notifications.types.system'.tr(),
      message: 'notifications.messages.new_feature'.tr(),
      time: DateTime.now().subtract(const Duration(days: 1)),
      isRead: false,
      type: NotificationType.system,
    ),
    AppNotification(
      id: '4',
      title: 'notifications.types.reminder'.tr(),
      message: 'notifications.messages.reminder'.tr(args: ['Позвонить маме']),
      time: DateTime.now().subtract(const Duration(hours: 5)),
      isRead: true,
      type: NotificationType.reminder,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          'notifications.title'.tr(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.done_all),
                        tooltip: 'notifications.mark_all_read'.tr(),

            onPressed: () {
              // Отметить все как прочитанные
              setState(() {
                _notifications.forEach((notification) {
                  notification.isRead = true;
                });
              });
            },
          ),
        ],
      ),
      body: _notifications.isEmpty
          ?  Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.notifications_off,
                    size: 80,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'notifications.empty.title'.tr(),
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: _notifications.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final notification = _notifications[index];
                return NotificationItem(
                  notification: notification,
                  onTap: () {
                    // Пометить как прочитанное и открыть детали
                    setState(() {
                      notification.isRead = true;
                    });
                  },
                  onDismiss: () {
                    // Удалить уведомление
                    setState(() {
                      _notifications.removeAt(index);
                    });
                  },
                );
              },
            ),
    );
  }
}