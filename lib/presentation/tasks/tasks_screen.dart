// lib/presentation/tasks/tasks_screen.dart
import 'package:to_do_project/presentation/tasks/bloc/tasks_cubit.dart';
import 'package:to_do_project/service_locator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_project/presentation/tasks/widgets/task_item.dart';


class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

    @override
  State<TasksScreen> createState() => _TasksScreenState();
}
class _TasksScreenState extends State<TasksScreen> {
  @override
  void initState() {
    super.initState();
    serviceLocator<TasksCubit>().loadTasks();

  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('tasks.title'.tr()),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              tooltip: 'tasks.search'.tr(),
              onPressed: () {
              },
            ),
            PopupMenuButton<TaskFilter>(
              icon: const Icon(Icons.filter_list),
              onSelected: (filter) =>
                  context.read<TasksCubit>().filterTasks(filter),
              itemBuilder: (_) => [
                PopupMenuItem(
                  value: TaskFilter.all,
                  child: Text('tasks.filters.all'.tr()),
                ),
                PopupMenuItem(
                  value: TaskFilter.active,
                  child: Text('tasks.filters.active'.tr()),
                ),
                PopupMenuItem(
                  value: TaskFilter.completed,
                  child: Text('tasks.filters.completed'.tr()),
                ),
              ],
            ),
          ],
        ),
        body: BlocBuilder<TasksCubit, TasksState>(
          builder: (context, state) {
            if (state is TasksLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is TasksError) {
              return Center(child: Text(state.message));
            }
            if (state is TasksLoaded) {
              final tasks = state.filteredTasks;
              if (tasks.isEmpty) {
                return Center(
                  child: Text(
                    'tasks.empty'.tr(),
                    style: const TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                );
              }
              return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: tasks.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (_, index) {
                  final task = tasks[index];
                  return TaskItem(
                    task: task,
                    onToggle: (value){},
                    onTap: () {
                    },
                  );
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
    );
  }
}
