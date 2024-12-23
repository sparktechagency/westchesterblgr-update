import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itzel/screens/user/user_account_screen/widgets/profile_info_widget.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_images_path.dart';
import '../../../constants/app_strings.dart';
import '../../../utils/app_size.dart';
import '../../../widgets/space_widget/space_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';
import 'controllers/user_account_controller.dart';

class UserAccountScreen extends StatelessWidget {
  const UserAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: AppColors.whiteBg,
      body: GetBuilder<UserAccountController>(
          init: UserAccountController(),
          builder: (controller) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(
                        AppImagesPath.chatProfileImage,
                        height: size.width / (size.width / 202),
                        width: size.width / (size.width / 202),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SpaceWidget(spaceHeight: 10),
                  const Center(
                    child: TextWidget(
                      text: AppStrings.receiverName,
                      fontColor: AppColors.black500,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SpaceWidget(spaceHeight: 12),
                  const TextWidget(
                    text: AppStrings.accountDetails,
                    fontColor: AppColors.black400,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  const SpaceWidget(spaceHeight: 8),
                  ProfileInfoWidget(
                    label: 'Username',
                    value: controller.username.value,
                  ),
                  ProfileInfoWidget(
                    label: 'Email',
                    value: controller.email.value,
                  ),
                  ProfileInfoWidget(
                    label: 'Contact Number',
                    value: controller.contactNumber.value,
                  ),
                ],
              ),
            );
          }),
    );
  }
}
