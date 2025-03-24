import 'package:flutter/material.dart';

class AppDialog {
  static void show({
    required BuildContext context,
    required String title,
    required String message,
    String? confirmText,
    String? cancelText,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    IconData? icon,
    Color? iconColor,
    bool barrierDismissible = true,
  }) {
    showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: Theme.of(context).colorScheme.surface,
          title: Row(
            children: [
              if (icon != null) ...[
                Icon(icon,
                    color: iconColor ?? Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
              ],
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
              ),
            ],
          ),
          content: Text(
            message,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          actions: [
            if (cancelText != null)
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  if (onCancel != null) onCancel();
                },
                child: Text(
                  cancelText,
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.secondary),
                ),
              ),
            if (confirmText != null)
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  if (onConfirm != null) onConfirm();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
                child: Text(
                  confirmText,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
          ],
        );
      },
    );
  }
}
