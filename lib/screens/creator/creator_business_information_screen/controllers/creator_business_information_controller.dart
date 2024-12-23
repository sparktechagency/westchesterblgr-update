import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreatorBusinessInformationController extends GetxController {
  final businessNameController = TextEditingController();
  final businessPhoneNumberController = TextEditingController();
  final yearsInBusinessController = TextEditingController();
  final businessWebsiteOrSocialMediaController = TextEditingController();

  String? fileName;

  Future<void> pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        fileName = result.files.single.name;
        update(); // This triggers UI update
      }
    } catch (e) {
      debugPrint('Error picking file: $e');
    }
  }

  void updateAndSave() {
    // Implement your save logic here
    print('Saving business information...');
    // You can access the values using controllers:
    // businessNameController.text
    // businessPhoneNumberController.text
    // etc.
  }

  @override
  void onClose() {
    businessNameController.dispose();
    businessPhoneNumberController.dispose();
    yearsInBusinessController.dispose();
    businessWebsiteOrSocialMediaController.dispose();
    super.onClose();
  }
}
