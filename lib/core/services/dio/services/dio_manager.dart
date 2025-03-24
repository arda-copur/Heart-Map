import 'package:dio/dio.dart';
import 'package:heartmap/core/services/dio/interceptors/logger_interceptor.dart';
import 'package:heartmap/core/services/dio/interceptors/retry_interceptor.dart';
import 'package:heartmap/core/utils/enum/app_durations.dart';

class DioManager {
  late final Dio dio;

  DioManager() {
    dio = Dio(
      BaseOptions(
        baseUrl: "https://api.example.com",
        connectTimeout: AppDurations.connectionTimeout.duration,
        receiveTimeout: AppDurations.requestTimeout.duration,
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );

    dio.interceptors.addAll([
      LoggerInterceptor(),
      RetryInterceptor(dio),
    ]);
  }
}
