import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserChangePasswordController extends GetxController {
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final retypeNewPasswordController = TextEditingController();

  bool currentPasswordObscure = true;
  bool newPasswordObscure = true;
  bool retypePasswordObscure = true;

  // Toggle password visibility
  void toggleObscurePassword(String type) {
    if (type == "current") {
      currentPasswordObscure = !currentPasswordObscure;
    } else if (type == "new") {
      newPasswordObscure = !newPasswordObscure;
    } else if (type == "retype") {
      retypePasswordObscure = !retypePasswordObscure;
    }
    update();
  }

  // Validate passwords
  String? validatePassword(String value) {
    if (value.isEmpty) {
      return "Enter Password";
    } else if (value.length < 6) {
      return "Password length should be more than 6 characters";
    }
    return null;
  }

  // Check if all fields are empty
  bool areFieldsEmpty() {
    return currentPasswordController.text.isEmpty &&
        newPasswordController.text.isEmpty &&
        retypeNewPasswordController.text.isEmpty;
  }

  // Check if new password matches retype password
  bool doPasswordsMatch() {
    return newPasswordController.text == retypeNewPasswordController.text;
  }

  // Handle button press logic
  void handleChangePassword(BuildContext context) {
    if (areFieldsEmpty()) {
      // Show SnackBar if fields are empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill in all the fields."),
          backgroundColor: Colors.red,
        ),
      );
    } else if (!doPasswordsMatch()) {
      // Show SnackBar if passwords do not match
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("New Password and Re-type Password do not match."),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      // Password changed successfully
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Password changed successfully!"),
          backgroundColor: Colors.green,
        ),
      );
    }
  }
}
