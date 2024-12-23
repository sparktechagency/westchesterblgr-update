import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CreatorJobPublishController extends GetxController {
  final companyNameController = TextEditingController();
  final addressController = TextEditingController();
  final roleController = TextEditingController();
  final jobDescriptionController = TextEditingController();
  final jobTypeController = TextEditingController();
  final priceController = TextEditingController();
  final List<Map<String, TextEditingController>> questions = [];

  final ImagePicker _picker = ImagePicker();
  XFile? image;

  Future<void> getImage() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    image = pickedImage;
    update(); // Notify the UI
  }

  void addQuestion(BuildContext context) {
    TextEditingController questionController = TextEditingController();
    TextEditingController answerController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Question',
              style: TextStyle(fontWeight: FontWeight.w500)),
          content: TextField(
            controller: questionController,
            decoration: const InputDecoration(
              hintText: 'Type your question',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel', style: TextStyle(color: Colors.red)),
            ),
            TextButton(
              onPressed: () {
                if (questionController.text.isNotEmpty) {
                  questions.add({
                    'question': questionController,
                    'answer': answerController,
                  });
                  update(); // Notify the UI
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }
}
