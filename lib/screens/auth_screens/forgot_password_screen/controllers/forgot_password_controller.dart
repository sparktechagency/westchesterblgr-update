import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/app_routes.dart';

class ForgotPasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  void validateAndNavigate() {
    if (formKey.currentState!.validate()) {
      String email = emailController.text;
      emailController.clear();
      Get.toNamed(
        AppRoutes.verifyAccountScreen,
        arguments: {'email': email},
      );
    } else if (emailController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Please fill all fields",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
