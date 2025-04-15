import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../models/my_product_model.dart'; // Import the MyProduct model

class CreatorUpdateSellProductController extends GetxController {
  final companyNameController = TextEditingController();
  final countryController = TextEditingController();
  final stateController = TextEditingController();
  final cityController = TextEditingController();
  final jobDescriptionController = TextEditingController();
  final priceController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final whatsAppController = TextEditingController();

  final selectedImage = Rx<XFile?>(null);

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      selectedImage.value = pickedImage; // Update the reactive variable
    }
  }

  @override
  void onInit() {
    super.onInit();

    // Retrieve the passed product data
    final MyProduct? product = Get.arguments as MyProduct?;

    if (product != null) {
      companyNameController.text = product.name ?? '';
      jobDescriptionController.text = product.description ?? '';
      priceController.text = product.price?.toString() ?? '';
      countryController.text = product.country ?? '';
      stateController.text = product.state ?? '';
      cityController.text = product.city ?? '';
      phoneNumberController.text = product.phone ?? '';
      whatsAppController.text = product.whatsapp ?? '';

      // Set the image if available
      if (product.image != null) {
        selectedImage.value = XFile(product.image!);
      }
    }
  }

  @override
  void onClose() {
    companyNameController.dispose();
    countryController.dispose();
    stateController.dispose();
    cityController.dispose();
    jobDescriptionController.dispose();
    priceController.dispose();
    phoneNumberController.dispose();
    whatsAppController.dispose();
    super.onClose();
  }
}
