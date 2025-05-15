import 'package:asyl_project/data/models/quote.dart';
import 'package:asyl_project/data/network/rest_client.dart';
import 'package:injectable/injectable.dart';

abstract class AppNotificationsRepository {
  Future<List<Quote>?> getAppNotifications();
}

@LazySingleton(as: AppNotificationsRepository)
class AppNotificationsRepositoryImpl implements AppNotificationsRepository {
  final RestClient _apiClient;

  AppNotificationsRepositoryImpl({
    required RestClient apiClient,
  }) : _apiClient = apiClient;

  @override
  Future<List<Quote>?> getAppNotifications() async {
    try {
      final response = await _apiClient.getAppNotifications();
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
