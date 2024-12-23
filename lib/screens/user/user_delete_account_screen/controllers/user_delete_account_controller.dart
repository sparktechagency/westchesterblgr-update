import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserDeleteAccountController extends GetxController {
  final TextEditingController passwordController = TextEditingController();

  // Check if the password field is empty
  bool isFieldEmpty() {
    return passwordController.text.trim().isEmpty;
  }

  // Validate the password field
  bool isPasswordValid() {
    return passwordController.text.length >= 6;
  }

  // Handle button press logic
  void handleDeleteAccount(BuildContext context) {
    if (isFieldEmpty()) {
      // Show message if password field is empty
      Get.snackbar(
        "Error",
        "Please enter your password.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else if (!isPasswordValid()) {
      // Show message if password is too short
      Get.snackbar(
        "Error",
        "Password length should be more than 6 characters.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else {
      // Success message
      Get.snackbar(
        "Success",
        "Account deleted successfully.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }
  }
}
