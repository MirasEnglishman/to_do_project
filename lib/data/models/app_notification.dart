import 'package:json_annotation/json_annotation.dart';

part 'app_notification.g.dart';



enum NotificationType { reminder, completion, system }

@JsonSerializable()
class AppNotification {
  final String id;
  final String title;
  final String message;
  final DateTime time;
  bool isRead;
  final NotificationType type;

  AppNotification({
    required this.id,
    required this.title,
    required this.message,
    required this.time,
    required this.isRead,
    required this.type,
  });

    factory AppNotification.fromJson(Map<String, dynamic> json) => _$AppNotificationFromJson(json);
  Map<String, dynamic> toJson() => _$AppNotificationToJson(this);

}