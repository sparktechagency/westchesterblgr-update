import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../services/repository/event_repository/event_repository.dart';

class CreatorEventCreateController extends GetxController {
  final EventRepository _eventRepository = EventRepository();
  final picker = ImagePicker();
  Rx<File?> image = Rx<File?>(null); // Make image observable
  Rx<File?> videoFile = Rx<File?>(null); // Make videoFile observable

  final TextEditingController eventNameController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController eventDescriptionController =
      TextEditingController();
  final TextEditingController eventTagController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController filePathController = TextEditingController();

  Future<void> pickImage() async {
    final XFile? selectedImage =
        await picker.pickImage(source: ImageSource.gallery);
    if (selectedImage != null) {
      image.value = File(selectedImage.path); // Update observable
    }
  }

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

        timeController.text =
            DateFormat('yyyy-MM-dd, HH:mm').format(fullDateTime);
        update(); // Notify listeners to update the UI
      }
    }
  }

  Future<void> pickVideo(BuildContext context, ImageSource source) async {
    final pickedFile = await picker.pickVideo(
      source: source,
      preferredCameraDevice: CameraDevice.front,
      maxDuration: const Duration(minutes: 10),
    );

    if (pickedFile != null) {
      videoFile.value = File(pickedFile.path); // Update observable
      filePathController.text = pickedFile.path;
      update(); // Notify listeners to update the UI
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No file selected')),
      );
    }
  }

  void createEvent() async {
    Map<String, dynamic> eventData = {
      'name': eventNameController.text,
      'time': timeController.text,
      'coordinate': '[${locationController.text}]',
      'description': eventDescriptionController.text,
      'tags': eventTagController.text.split(' '),
      // Convert tags to a JSON array
      'price': int.parse(priceController.text),
      'address': addressController.text,
    };

    bool result = await _eventRepository.createEvent(eventData,
        imageFile: image.value, videoFile: videoFile.value);

    if (result) {
      Get.snackbar('Success', 'Event created successfully!');
      Get.back();
    } else {
      Get.snackbar('Error', 'Failed to create the event.');
    }
  }

  @override
  void onClose() {
    eventNameController.dispose();
    timeController.dispose();
    locationController.dispose();
    eventDescriptionController.dispose();
    eventTagController.dispose();
    priceController.dispose();
    addressController.dispose();
    filePathController.dispose();
    super.onClose();
  }
}
