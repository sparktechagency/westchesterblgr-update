import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itzel/screens/user/user_delete_account_screen/widgets/delete_account_button_widget.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_strings.dart';
import '../../../utils/app_size.dart';
import '../../../widgets/appbar_widget/appbar_widget.dart';
import '../../../widgets/space_widget/space_widget.dart';
import '../../../widgets/text_field_widget/text_field_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';
import 'controllers/user_delete_account_controller.dart';

class UserDeleteAccountScreen extends StatelessWidget {
  final passwordController = TextEditingController();
  UserDeleteAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: AppColors.whiteBg,
      appBar: const AppbarWidget(text: AppStrings.deleteAccount),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            const TextWidget(
              text: AppStrings.deleteAccountText,
              fontColor: AppColors.blackDarker,
              fontSize: 16,
              fontWeight: FontWeight.w400,
              textAlignment: TextAlign.left,
            ),
            const SpaceWidget(spaceHeight: 30),
            TextFieldWidget(
              hintText: 'Current Password',
              controller: passwordController,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter Password";
                } else if (passwordController.text.length < 6) {
                  return "Password length should be more than 6 characters";
                }
                return null;
              },
              maxLines: 1,
              suffixIcon: Icons.visibility_off_outlined,
            ),
            const SpaceWidget(spaceHeight: 48),
            const TextWidget(
              text: AppStrings.deleteAccountConfirmationText,
              fontColor: AppColors.blackLight2,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            const SpaceWidget(spaceHeight: 16),
            Container(
              height: (size.height / (size.height / 54)),
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.red,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 4),
                    blurRadius: 5.0,
                  ),
                ],
                borderRadius: BorderRadius.circular(8),
              ),
              child: MaterialButton(
                onPressed: () {},
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                child: Text(
                  "Delete Account",
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: (size.width / (size.width / 16)),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
