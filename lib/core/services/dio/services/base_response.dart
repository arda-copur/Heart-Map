class BaseResponse<T> {
  final T? data;
  final String? message;
  final int? statusCode;
  final bool isSuccess;

  BaseResponse({
    required this.isSuccess,
    this.data,
    this.message,
    this.statusCode,
  });

  factory BaseResponse.success(T data, int statusCode) {
    return BaseResponse(isSuccess: true, data: data, statusCode: statusCode);
  }

  factory BaseResponse.error(String message, int statusCode) {
    return BaseResponse(
        isSuccess: false, message: message, statusCode: statusCode);
  }
}
