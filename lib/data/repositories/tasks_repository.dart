import 'package:to_do_project/data/models/task.dart';
import 'package:to_do_project/data/network/rest_client.dart';
import 'package:injectable/injectable.dart';

abstract class TasksRepository {
  Future<List<Task>?> getTasks();
}

@LazySingleton(as: TasksRepository)
class TasksRepositoryImpl implements TasksRepository {
  final RestClient _apiClient;

  TasksRepositoryImpl({
    required RestClient apiClient,
  }) : _apiClient = apiClient;

  @override
  Future<List<Task>?> getTasks() async {
    try {
      final response = await _apiClient.getTasks();
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
