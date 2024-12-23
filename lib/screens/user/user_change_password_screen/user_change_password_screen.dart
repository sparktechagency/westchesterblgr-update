import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itzel/widgets/button_widget/button_widget.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_strings.dart';
import '../../../utils/app_size.dart';
import '../../../widgets/appbar_widget/appbar_widget.dart';
import '../../../widgets/space_widget/space_widget.dart';
import '../../../widgets/text_field_widget/text_field_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';
import 'controllers/user_change_password_controller.dart';

class UserChangePasswordScreen extends StatelessWidget {
  const UserChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UserChangePasswordController controller =
        Get.put(UserChangePasswordController());
    return Scaffold(
      backgroundColor: AppColors.whiteBg,
      appBar: const AppbarWidget(text: AppStrings.changePassword),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            const TextWidget(
              text: AppStrings.changePasswordText,
              fontColor: AppColors.blackDark,
              fontSize: 16,
              fontWeight: FontWeight.w400,
              textAlignment: TextAlign.left,
            ),
            const SpaceWidget(spaceHeight: 30),
            Obx(
              () => TextFieldWidget(
                hintText: 'Current Password',
                controller: controller.currentPasswordController,
                validator: (value) => controller.validatePassword(value!),
                maxLines: 1,
                suffixIcon: controller.currentPasswordObscure.value
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                onTapSuffix: () => controller.toggleObscurePassword("current"),
              ),
            ),
            const SpaceWidget(spaceHeight: 12),
            Obx(
              () => TextFieldWidget(
                hintText: 'New Password',
                controller: controller.newPasswordController,
                validator: (value) => controller.validatePassword(value!),
                maxLines: 1,
                suffixIcon: controller.newPasswordObscure.value
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                onTapSuffix: () => controller.toggleObscurePassword("new"),
              ),
            ),
            const SpaceWidget(spaceHeight: 12),
            Obx(
              () => TextFieldWidget(
                hintText: 'Re-type new Password',
                controller: controller.retypeNewPasswordController,
                validator: (value) => controller.validatePassword(value!),
                maxLines: 1,
                suffixIcon: controller.retypePasswordObscure.value
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                onTapSuffix: () => controller.toggleObscurePassword("retype"),
              ),
            ),
            const SpaceWidget(spaceHeight: 48),
            ButtonWidget(
              onPressed: () => controller.handleChangePassword(context),
              label: AppStrings.changePassword,
              buttonHeight: AppSize.width(value: 52),
              buttonWidth: double.infinity,
            ),
          ],
        ),
      ),
    );
  }
}
