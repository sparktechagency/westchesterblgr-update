import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class CreatorEventCreateController extends GetxController {
  File? galleryFile;
  final picker = ImagePicker();
  XFile? image; // Declare this to hold the selected image

  File? selectedVideoFile;
  final TextEditingController filePathController = TextEditingController();
  final TextEditingController eventNameController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController eventDescriptionController = TextEditingController();
  final TextEditingController eventTagController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  // Function to pick an image from the gallery
  Future<void> pickImage() async {
    final XFile? selectedImage = await picker.pickImage(source: ImageSource.gallery);

    if (selectedImage != null) {
      image = selectedImage;
      update(); // Update the UI after the image is selected
    }
  }

  // Function to pick the date and time
  Future<void> pickDateTime(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      final TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (selectedTime != null) {
        final DateTime fullDateTime = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour,
          selectedTime.minute,
        );

        timeController.text = DateFormat('yyyy-MM-dd, HH:mm').format(fullDateTime);
        update(); // Update the UI after the date and time are selected
      }
    }
  }

  // Function to pick a video
  Future<void> pickVideo(BuildContext context, ImageSource source) async {
    final pickedFile = await picker.pickVideo(
      source: source,
      preferredCameraDevice: CameraDevice.front,
      maxDuration: const Duration(minutes: 10),
    );

    if (pickedFile != null) {
      selectedVideoFile = File(pickedFile.path);
      filePathController.text = pickedFile.path;
      update(); // Update the UI after the video is selected
    } else {
      Get.snackbar('Error', 'No file selected', snackPosition: SnackPosition.BOTTOM);
    }
  }
}


