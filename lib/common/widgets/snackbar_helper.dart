import 'package:flutter/material.dart';

class SnackbarHelper {
  static showErrorSnackBar(BuildContext context, String errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red.withValues(alpha: .7),
        content: Row(
          spacing: 20,
          children: [
            Icon(Icons.error_outline, color: Colors.white),
            Text(
              errorMessage,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green.withValues(alpha: .7),
        content: Row(
          spacing: 20,
          children: [
            Icon(Icons.check_circle_outline, color: Colors.white),
            Text(
              message,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
