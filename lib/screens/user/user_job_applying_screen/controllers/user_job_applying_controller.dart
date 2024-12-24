import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserJobApplyingController extends GetxController {
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final experienceController = TextEditingController();
  final citizenshipController = TextEditingController();
  final highSchoolController = TextEditingController();
  final graduatedHighSchoolYearController = TextEditingController();
  final collegeController = TextEditingController();
  final graduatedYearController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  void submitForm() {
    if (formKey.currentState!.validate()) {
      // Perform submit action
      print('Form Submitted Successfully');
    } else {
      print('Validation Failed');
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    addressController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    experienceController.dispose();
    citizenshipController.dispose();
    highSchoolController.dispose();
    graduatedHighSchoolYearController.dispose();
    collegeController.dispose();
    graduatedYearController.dispose();
    super.onClose();
  }
}
