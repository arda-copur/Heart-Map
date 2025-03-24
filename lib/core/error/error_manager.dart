import 'package:flutter/material.dart';
import 'package:heartmap/core/error/app_error.dart';
import 'package:logger/logger.dart';

class ErrorManager {
  static final Logger _logger = Logger();

  static void handleError(AppError error, {BuildContext? context}) {
    _logger.e(error.toString(),
        error: error.exception, stackTrace: error.stackTrace);

    if (context != null) {
      showErrorDialog(context, error.message);
    }
  }

  static void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Hata"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Tamam"),
          ),
        ],
      ),
    );
  }
}
