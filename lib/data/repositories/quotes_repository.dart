import 'package:asyl_project/data/models/quote.dart';
import 'package:asyl_project/data/network/rest_client.dart';
import 'package:injectable/injectable.dart';

abstract class QuotesRepository {
  Future<List<Quote>?> getQuotes();
}

@LazySingleton(as: QuotesRepository)
class QuotesRepositoryImpl implements QuotesRepository {
  final RestClient _apiClient;

  QuotesRepositoryImpl({
    required RestClient apiClient,
  }) : _apiClient = apiClient;

  @override
  Future<List<Quote>?> getQuotes() async {
    try {
      final response = await _apiClient.getQuotes();
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
