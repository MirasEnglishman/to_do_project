import 'package:asyl_project/data/models/quote.dart';
import 'package:asyl_project/data/models/task.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_client.g.dart';

@injectable
@RestApi()
abstract class RestClient {
  @factoryMethod
  factory RestClient(Dio dio) = _RestClient;

  @GET('/tasks.json')
  Future<List<Task>?> getTasks();

  @GET('/quotes.json')
  Future<List<Quote>?> getQuotes();

  @GET('/app_notifications.json')
  Future<List<Quote>?> getAppNotifications();
}
