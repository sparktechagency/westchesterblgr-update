import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itzel/widgets/button_widget/button_widget.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_images_path.dart';
import '../../../constants/app_strings.dart';
import '../../../utils/app_size.dart';
import '../../../widgets/appbar_widget/appbar_widget.dart';
import '../../../widgets/space_widget/space_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';
import 'controllers/user_profile_controller.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserProfileController());
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
              // Profile Image with Edit Icon
              Center(
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Obx(
                      () => CircleAvatar(
                        radius: 100,
                        backgroundColor: Colors.grey[300],
                        backgroundImage: controller.selectedImage.value != null
                            ? FileImage(controller.selectedImage.value!)
                            : const AssetImage(
                                    "assets/images/chatProfileImage.png")
                                as ImageProvider,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: size.width / (size.width / 100)),
                      child: InkWell(
                        onTap: () => controller.pickImage(),
                        child: const CircleAvatar(
                          radius: 20,
                          backgroundColor: AppColors.blueNormal,
                          child: Icon(
                            Icons.mode_edit_outline_outlined,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SpaceWidget(spaceHeight: 16),
              const Center(
                child: TextWidget(
                  text: AppStrings.profileName,
                  fontColor: AppColors.black500,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SpaceWidget(spaceHeight: 8),
              const TextWidget(
                text: AppStrings.accountDetails,
                fontColor: AppColors.grey900,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              const SpaceWidget(spaceHeight: 8),
              _buildTextField(
                  "Username", controller.usernameController.value, controller),
              _buildTextField(
                  "Address", controller.addressController.value, controller),
              _buildTextField("Phone Number",
                  controller.phoneNumberController.value, controller),

              const SpaceWidget(spaceHeight: 6),

              // Update Button (Visible only if data is updated)
              Obx(() {
                if (controller.isUpdated.value) {
                  return ButtonWidget(
                    onPressed: () => controller.handleUpdate(context),
                    label: AppStrings.update,
                    buttonWidth: double.infinity,
                    buttonHeight: AppSize.width(value: 52),
                  );
                }
                return const SizedBox();
              }),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build input fields
  Widget _buildTextField(
      String label, TextEditingController textController, controller) {
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
          onChanged: (value) => controller.checkForUpdates(),
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
