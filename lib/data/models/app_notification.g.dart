// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppNotification _$AppNotificationFromJson(Map<String, dynamic> json) =>
    AppNotification(
      id: json['id'] as String,
      title: json['title'] as String,
      message: json['message'] as String,
      time: DateTime.parse(json['time'] as String),
      isRead: json['isRead'] as bool,
      type: $enumDecode(_$NotificationTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$AppNotificationToJson(AppNotification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'message': instance.message,
      'time': instance.time.toIso8601String(),
      'isRead': instance.isRead,
      'type': _$NotificationTypeEnumMap[instance.type]!,
    };

const _$NotificationTypeEnumMap = {
  NotificationType.reminder: 'reminder',
  NotificationType.completion: 'completion',
  NotificationType.system: 'system',
};
