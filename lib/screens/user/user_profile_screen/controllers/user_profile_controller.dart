import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class UserProfileController extends GetxController {
  // State variables
  var selectedImage = Rx<File?>(null);
  final ImagePicker picker = ImagePicker();

  final Rx<TextEditingController> usernameController =
      TextEditingController(text: "John Bryan").obs;
  final Rx<TextEditingController> addressController =
      TextEditingController(text: "California, Rankin Street 121").obs;
  final Rx<TextEditingController> phoneNumberController =
      TextEditingController(text: "012568554526345").obs;

  // Track updates
  var isUpdated = false.obs;

  // Function to pick an image
  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
      checkForUpdates();
    }
  }

  // Check if fields are updated
  void checkForUpdates() {
    isUpdated.value = usernameController.value.text != "John Bryan" ||
        addressController.value.text != "California, Rankin Street 121" ||
        phoneNumberController.value.text != "012568554526345" ||
        selectedImage.value != null;
  }

  // Handle the update button
  void handleUpdate(BuildContext context) {
    isUpdated.value = false;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Profile updated successfully!")),
    );
  }
}
