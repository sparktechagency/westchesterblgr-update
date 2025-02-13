import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:itzel/widgets/button_widget/button_widget.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_strings.dart';
import '../../../utils/app_size.dart';
import '../../../widgets/app_image/app_image.dart';
import '../../../widgets/appbar_widget/appbar_widget.dart';
import '../../../widgets/space_widget/space_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';
import 'controllers/creator_profile_controller.dart';

class CreatorProfileScreen extends StatefulWidget {
  const CreatorProfileScreen({super.key});

  @override
  State<CreatorProfileScreen> createState() => _CreatorProfileScreenState();
}

class _CreatorProfileScreenState extends State<CreatorProfileScreen> {
  final CreatorProfileController _controller =
      Get.put(CreatorProfileController());
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  final TextEditingController _usernameController =
      TextEditingController(text: "John Bryan");
  final TextEditingController _addressController =
      TextEditingController(text: "California, Rankin Street 121");
  final TextEditingController _phoneNumberController =
      TextEditingController(text: "012568554526345");

  bool _isUpdated = false;

  // Function to pick an image
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
        _checkForUpdates();
      });
    }
  }

  // Check if fields are updated
  void _checkForUpdates() {
    setState(() {
      _isUpdated = _usernameController.text != "John Bryan" ||
          _addressController.text != "California, Rankin Street 121" ||
          _phoneNumberController.text != "012568554526345" ||
          _selectedImage != null;
    });
  }

  // Handle the update button
  void _handleUpdate() {
    setState(() {
      _isUpdated = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Profile updated successfully!")),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _addressController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: AppColors.whiteBg,
      appBar: const AppbarWidget(text: AppStrings.myProfile),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Obx(() => CircleAvatar(
                          radius: 75,
                          backgroundColor: Colors.grey[300],
                          child: ClipOval(
                            child: _controller.selectedImage.value != null
                                ? Image.file(
                                    _controller.selectedImage.value!,
                                    width: 150,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  )
                                : AppImage(
                                    url: Get.arguments['profileImage'],
                                    width: 150,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        )),
                    Padding(
                      padding:
                          EdgeInsets.only(left: size.width / (size.width / 90)),
                      child: InkWell(
                        onTap: _controller.pickImage,
                        child: const CircleAvatar(
                          radius: 15,
                          backgroundColor: AppColors.blueDarker,
                          child: Icon(
                            Icons.mode_edit_outline_outlined,
                            color: AppColors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SpaceWidget(spaceHeight: 24),
              const Center(
                child: TextWidget(
                  text: AppStrings.accountDetails,
                  fontColor: AppColors.grey900,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SpaceWidget(spaceHeight: 16),
              _buildTextField("Username", _controller.usernameController),
              _buildTextField("Address", _controller.addressController),
              _buildTextField(
                  "Phone Number", _controller.phoneNumberController),
              const SpaceWidget(spaceHeight: 6),
              Obx(() => _controller.isUpdated.value
                  ? ButtonWidget(
                      onPressed: _controller.updateProfile,
                      label: AppStrings.update,
                      buttonWidth: double.infinity,
                      buttonHeight: AppSize.width(value: 52),
                    )
                  : Container()),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build input fields
  Widget _buildTextField(String label, TextEditingController textController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          text: label,
          fontColor: AppColors.blackLight,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
        const SpaceWidget(spaceHeight: 4),
        TextField(
          controller: textController,
          onChanged: (value) => _controller.checkForUpdates(),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SpaceWidget(spaceHeight: 14),
      ],
    );
  }
}
