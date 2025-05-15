import 'package:asyl_project/data/models/task.dart';
import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {
  final Task task;
  final Function(bool) onToggle;
  final VoidCallback onTap;

  const TaskItem({
    Key? key,
    required this.task,
    required this.onToggle,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // Определение цвета приоритета
    Color priorityColor;
    switch (task.priority) {
      case Priority.high:
        priorityColor = Colors.red;
        break;
      case Priority.medium:
        priorityColor = Colors.orange;
        break;
      case Priority.low:
        priorityColor = Colors.green;
        break;
    }

    // Расчет оставшихся дней
    final daysLeft = task.dueDate.difference(DateTime.now()).inDays;
    
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: theme.colorScheme.outlineVariant,
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: priorityColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      task.title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        decoration: task.isCompleted 
                            ? TextDecoration.lineThrough 
                            : null,
                        color: task.isCompleted 
                            ? theme.colorScheme.outline 
                            : theme.colorScheme.onSurface,
                      ),
                    ),
                  ),
                  Checkbox(
                    value: task.isCompleted,
                    onChanged: (value) => onToggle(value!),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
              if (task.description.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  task.description,
                  style: TextStyle(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Chip(
                    padding: EdgeInsets.zero,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    backgroundColor: theme.colorScheme.surfaceVariant,
                    label: Text(
                      '${task.dueDate.day}.${task.dueDate.month}.${task.dueDate.year}',
                      style: TextStyle(
                        fontSize: 12,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    avatar: const Icon(
                      Icons.calendar_today,
                      size: 16,
                    ),
                  ),
                  if (daysLeft >= 0 && !task.isCompleted)
                    Text(
                      daysLeft == 0
                          ? 'Сегодня'
                          : 'Осталось: $daysLeft дн.',
                      style: TextStyle(
                        fontSize: 12,
                        color: daysLeft == 0
                            ? Colors.red
                            : theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}