// lib/screens/user/user_profile_screen/controllers/user_profile_controller.dart

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:itzel/services/repository/profile_repository/profile_repository.dart';
import 'package:itzel/widgets/app_snack_bar/app_snack_bar.dart';

import '../../../../models/profile_model.dart';
import '../../user_account_screen/controllers/user_account_controller.dart';

class UserProfileController extends GetxController {
  final ProfileRepository _profileRepository = ProfileRepository();
  final ImagePicker _picker = ImagePicker();

  var usernameController = TextEditingController();
  var addressController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var selectedImage = Rx<File?>(null);
  var isUpdated = false.obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    usernameController.text = args['username'];
    addressController.text = args['address'];
    phoneNumberController.text = args['contactNumber'];
  }

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
      checkForUpdates();
    }
  }

  void checkForUpdates() {
    isUpdated.value = usernameController.text != Get.arguments['username'] ||
        addressController.text != Get.arguments['address'] ||
        phoneNumberController.text != Get.arguments['contactNumber'] ||
        selectedImage.value != null;
  }

  Future<void> updateProfile() async {
    bool success = await _profileRepository.updateProfile(
      username: usernameController.text,
      address: addressController.text,
      contactNumber: phoneNumberController.text,
      imageFile: selectedImage.value,
    );

    if (success) {
      AppSnackBar.success('Profile updated successfully');
      Get.back();
      Get.find<UserAccountController>().fetchProfileData();

      isUpdated.value = false;
    } else {
      AppSnackBar.error('Failed to update profile');
    }
  }

  Future<void> fetchProfileData() async {
    Data? profileData = await _profileRepository.fetchProfile();
    if (profileData != null) {
      usernameController.text = profileData.name;
      addressController.text = profileData.location;
      phoneNumberController.text = profileData.contact;
    }
  }

  @override
  void onClose() {
    usernameController.dispose();
    addressController.dispose();
    phoneNumberController.dispose();
    super.onClose();
  }
}
