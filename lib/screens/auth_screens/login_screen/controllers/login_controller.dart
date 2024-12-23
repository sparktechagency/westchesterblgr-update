import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/app_routes.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isChecked = false;

  void toggleRememberMe(bool? value) {
    isChecked = value ?? false;
    update(); // Notify listeners
  }

  void onSignIn() {
    if (formKey.currentState!.validate()) {
      emailController.clear();
      passwordController.clear();
      Get.offAllNamed(AppRoutes.bottomNavScreen);
    } else {
      Get.snackbar(
        'Error',
        'Please fill in all fields correctly.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
