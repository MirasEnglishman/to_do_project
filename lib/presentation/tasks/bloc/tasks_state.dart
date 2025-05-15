part of 'tasks_cubit.dart';

enum TaskFilter { all, completed, active }

abstract class TasksState extends Equatable {
  const TasksState();

  @override
  List<Object?> get props => [];
}

class TasksInitial extends TasksState {
  const TasksInitial();
}

class TasksLoading extends TasksState {
  const TasksLoading();
}

class TasksLoaded extends TasksState {
  final List<Task> tasks;
  final TaskFilter filter;

  const TasksLoaded(this.tasks, {this.filter = TaskFilter.all});

  List<Task> get filteredTasks {
    switch (filter) {
      case TaskFilter.completed:
        return tasks.where((task) => task.isCompleted).toList();
      case TaskFilter.active:
        return tasks.where((task) => !task.isCompleted).toList();
      case TaskFilter.all:
      return tasks;
    }
  }

  @override
  List<Object?> get props => [tasks, filter];
}

class TasksError extends TasksState {
  final String message;

  const TasksError(this.message);

  @override
  List<Object?> get props => [message];
}