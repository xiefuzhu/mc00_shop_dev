import 'package:flutter/material.dart';

class ToastUtils {
  static bool showLoading = false;

  static void showToast(BuildContext context, String message) {
    if (showLoading) return;
    showLoading = true;
    Future.delayed(Duration(seconds: 2), () {
      showLoading = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        width: 240,
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        content: Text(message, textAlign: TextAlign.center),
      ),
    );
  }
}
