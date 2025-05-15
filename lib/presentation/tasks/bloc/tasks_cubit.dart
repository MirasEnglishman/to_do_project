import 'package:to_do_project/data/repositories/tasks_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/task.dart';

part 'tasks_state.dart';

@lazySingleton
class TasksCubit extends Cubit<TasksState> {
  final TasksRepository _taskRepository;

  TasksCubit(this._taskRepository) : super(const TasksInitial());

  Future<void> loadTasks() async {
    emit(const TasksLoading());
    try {
      final tasks = await _taskRepository.getTasks();
      emit(TasksLoaded(tasks ?? []));
    } catch (e) {
      emit(TasksError('Не удалось загрузить задачи: ${e.toString()}'));
    }
  }

  void filterTasks(TaskFilter filter) {
    final currentState = state;
    if (currentState is TasksLoaded) {
      emit(TasksLoaded(
        currentState.tasks,
        filter: filter,
      ));
    }
  }

}