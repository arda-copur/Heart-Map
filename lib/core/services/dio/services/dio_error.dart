import 'package:dio/dio.dart';

class DioErrorManager {
  static String handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return "Bağlantı zaman aşımına uğradı.";
      case DioExceptionType.sendTimeout:
        return "Veri gönderme zaman aşımına uğradı.";
      case DioExceptionType.receiveTimeout:
        return "Yanıt alma zaman aşımına uğradı.";
      case DioExceptionType.badResponse:
        return "Sunucu hatası: ${error.response?.statusCode}";
      case DioExceptionType.cancel:
        return "İstek iptal edildi.";
      case DioExceptionType.unknown:
      default:
        return "Bilinmeyen bir hata oluştu.";
    }
  }
}
