enum ErrorType { network, firebase, validation, unknown }

class AppError {
  final String message;
  final ErrorType type;
  final dynamic exception;
  final StackTrace? stackTrace;

  AppError({
    required this.message,
    required this.type,
    this.exception,
    this.stackTrace,
  });

  @override
  String toString() {
    return "ErrorType: $type, Message: $message, Exception: $exception";
  }
}
