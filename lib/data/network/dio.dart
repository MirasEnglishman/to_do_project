import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';

@module
abstract class DioModule {
  @lazySingleton
  Dio getDio() {
    final dio = Dio()..options.baseUrl = "https://to-do-list-6b74c-default-rtdb.firebaseio.com/";
    dio.interceptors.addAll([
      TalkerDioLogger(
        settings: TalkerDioLoggerSettings(
          printRequestData: true,
          printRequestHeaders: true,
          printResponseData: false,
          // printResponseData: true,
          // printResponseHeaders: true,
        ),
      ),
    ]);

    return dio;
  }
}

@lazySingleton
class DioService {
  final Dio dio;

  DioService(this.dio);

  Future<Response<Map<String, dynamic>>> fetch({
    required String url,
    required String method,
    ResponseType responseType = ResponseType.json,
    FormData? data,
    Map<String, dynamic>? queryParameters,
    String contentType = Headers.jsonContentType,
  }) =>
      dio.fetch<Map<String, dynamic>>(Options(
        method: method,
        responseType: responseType,
        contentType: contentType,
      )
          .compose(dio.options, url,
              data: data, queryParameters: queryParameters)
          .copyWith(
              baseUrl:
                   "https://to-do-list-6b74c-default-rtdb.firebaseio.com/"
                  ));
}
