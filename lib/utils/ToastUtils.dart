import 'package:flutter/material.dart';

class ToastUtils {
  static void showToast(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        width: 240,
        behavior: SnackBarBehavior.floating,
        content: Text(message, textAlign: TextAlign.center),
      ),
    );
  }
}
