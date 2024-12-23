import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class UserProfileController extends GetxController {
  File? selectedImage;
  final ImagePicker picker = ImagePicker();

  final TextEditingController usernameController =
      TextEditingController(text: "John Bryan");
  final TextEditingController addressController =
      TextEditingController(text: "California, Rankin Street 121");
  final TextEditingController phoneNumberController =
      TextEditingController(text: "012568554526345");

  // Track updates
  var isUpdated = false.obs;

  // Function to pick an image
  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage = File(pickedFile.path);
      checkForUpdates();
      update(); // Refresh the UI
    }
  }

  // Check if fields are updated
  void checkForUpdates() {
    isUpdated.value = usernameController.text != "John Bryan" ||
        addressController.text != "California, Rankin Street 121" ||
        phoneNumberController.text != "012568554526345" ||
        selectedImage != null;
  }

  // Handle the update button
  void handleUpdate(BuildContext context) {
    isUpdated.value = false;
    update(); // Refresh the UI
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Profile updated successfully!")),
    );
  }

  @override
  void onClose() {
    usernameController.dispose();
    addressController.dispose();
    phoneNumberController.dispose();
    super.onClose();
  }
}
