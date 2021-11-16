import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Helpers {
  static void showSnackbar({
    required String title,
    required String message,
    required Color color,
    required Icon icon,
  }) {
    Get.snackbar<void>(title, message,
        icon: Icon(icon.icon, size: 30, color: Colors.white),
        duration: Duration(seconds: 2),
        backgroundColor: color,
        snackPosition: SnackPosition.BOTTOM,
        borderRadius: 16,
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(20),
        barBlur: 4,
        overlayBlur: 5);
  }

  static Widget showLoading() {
    return Center(
      child: CircularProgressIndicator(
        color: Colors.black,
      ),
    );
  }

  // Show toast
  static void showToast(String message) {
    Get.snackbar(
      '',
      message,
      duration: Duration(seconds: 2),
      backgroundColor: Colors.green[200],
      snackPosition: SnackPosition.BOTTOM,
      borderRadius: 16,
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(20),
      barBlur: 4,
      overlayBlur: 5,
    );
  }
}
