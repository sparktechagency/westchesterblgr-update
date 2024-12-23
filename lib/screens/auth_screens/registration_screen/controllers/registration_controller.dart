import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../bottom_nav_screen/bottom_nav_screen.dart';

class RegistrationController extends GetxController {
  // State variables
  bool isCreator = false;
  bool isUserChecked = false;
  bool isCreatorChecked = false;

  // Form keys
  final userFormKey = GlobalKey<FormState>();
  final creatorFormKey = GlobalKey<FormState>();

  // User's auth controllers
  final userNameController = TextEditingController();
  final userEmailController = TextEditingController();
  final userPasswordController = TextEditingController();
  final userConfirmPasswordController = TextEditingController();

  // Creator's auth controllers
  final creatorNameController = TextEditingController();
  final creatorEmailController = TextEditingController();
  final creatorPasswordController = TextEditingController();
  final creatorConfirmPasswordController = TextEditingController();

  // Methods to toggle role
  void toggleRole(bool isCreatorSelected) {
    isCreator = isCreatorSelected;
    update();
  }

  // Methods to toggle checkboxes
  void toggleUserChecked(bool value) {
    isUserChecked = value;
    update();
  }

  void toggleCreatorChecked(bool value) {
    isCreatorChecked = value;
    update();
  }

  // Method for form submission
  void submitForm() {
    final formKey = isCreator ? creatorFormKey : userFormKey;
    final nameController =
        isCreator ? creatorNameController : userNameController;
    final emailController =
        isCreator ? creatorEmailController : userEmailController;
    final passwordController =
        isCreator ? creatorPasswordController : userPasswordController;
    final confirmPasswordController = isCreator
        ? creatorConfirmPasswordController
        : userConfirmPasswordController;
    final isChecked = isCreator ? isCreatorChecked : isUserChecked;

    if (formKey.currentState!.validate() && isChecked) {
      if (passwordController.text != confirmPasswordController.text) {
        Get.snackbar('Error', 'Passwords do not match');
        return;
      }

      String userRole = isCreator ? 'Creator' : 'User';

      Get.offAll(() => BottomNavScreen(userRole: userRole));
      // Perform registration logic
      nameController.clear();
      emailController.clear();
      passwordController.clear();
      confirmPasswordController.clear();

      // Uncomment for navigation
      // Get.offAll(() => ConfirmEmailScreen());
    } else if (!isChecked) {
      // Show toast or error
      Get.snackbar('Error', 'Please accept terms of service');
    } else {
      Get.snackbar('Error', 'Please fill all fields correctly');
    }
  }
}
