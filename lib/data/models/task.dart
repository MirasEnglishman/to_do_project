import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';

enum Priority { low, medium, high }


@JsonSerializable()
class Task {
  final String id;
  final String title;
  final String description;
  bool isCompleted;
  final DateTime dueDate;
  final Priority priority;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.dueDate,
    required this.priority,
  });

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
  Map<String, dynamic> toJson() => _$TaskToJson(this);

  Task copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
    DateTime? dueDate,
    Priority? priority,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      dueDate: dueDate ?? this.dueDate,
      priority: priority ?? this.priority,
    );
  }
}