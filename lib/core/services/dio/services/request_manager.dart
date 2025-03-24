import 'package:dio/dio.dart';
import 'package:heartmap/core/services/dio/services/base_response.dart';
import 'package:heartmap/core/services/dio/services/dio_error.dart';
import 'package:heartmap/core/services/dio/services/dio_manager.dart';

class RequestManager {
  final DioManager dioManager;

  RequestManager(this.dioManager);

  Future<BaseResponse<T>> request<T>({
    required String path,
    required String method,
    Map<String, dynamic>? queryParameters,
    dynamic data,
    T Function(dynamic json)? fromJson,
  }) async {
    try {
      final response = await dioManager.dio.request(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(method: method),
      );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return BaseResponse.success(
          fromJson != null ? fromJson(response.data) : response.data,
          response.statusCode!,
        );
      } else {
        return BaseResponse.error(
            "Error: ${response.statusMessage}", response.statusCode!);
      }
    } on DioException catch (e) {
      return BaseResponse.error(
          DioErrorManager.handleError(e), e.response?.statusCode ?? 500);
    }
  }
}
