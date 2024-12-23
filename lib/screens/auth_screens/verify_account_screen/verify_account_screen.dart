import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:itzel/screens/auth_screens/verify_account_screen/widgets/otp_field_widget.dart';

import '../../../constants/app_colors.dart';
import '../../../widgets/button_widget/button_widget.dart';
import '../../../widgets/space_widget/space_widget.dart';
import '../../../widgets/text_button_widget/text_button_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';
import 'controllers/verify_account_controller.dart';

class VerifyAccountScreen extends StatelessWidget {
  const VerifyAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    final email = Get.arguments['email'];

    return Scaffold(
      backgroundColor: AppColors.grey100,
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.sizeOf(context).width /
                (MediaQuery.sizeOf(context).width / 14)),
        child: GetBuilder<VerifyAccountController>(
            init: VerifyAccountController(),
            builder: (controller) {
              return Form(
                key: controller.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: TextWidget(
                        text: 'Verify your account',
                        fontColor: AppColors.black500,
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SpaceWidget(spaceHeight: 12),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.sizeOf(context).width /
                              (MediaQuery.sizeOf(context).width / 32)),
                      child: Center(
                        child: TextWidget(
                          text:
                              "You're almost there! We’ve sent a 6-digit code to your email. Please enter the code to verify your email address",
                          fontColor: AppColors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          maxLines: 3,
                        ),
                      ),
                    ),
                    Center(
                      child: TextWidget(
                        text: "''$email''",
                        fontColor: AppColors.black700,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        maxLines: 2,
                      ),
                    ),
                    SpaceWidget(spaceHeight: 40),
                    Center(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            OtpInputFieldWidget(
                                controller:
                                    controller.otpTextEditingController1),
                            OtpInputFieldWidget(
                                controller:
                                    controller.otpTextEditingController2),
                            OtpInputFieldWidget(
                                controller:
                                    controller.otpTextEditingController3),
                            OtpInputFieldWidget(
                                controller:
                                    controller.otpTextEditingController4),
                            OtpInputFieldWidget(
                                controller:
                                    controller.otpTextEditingController5),
                            OtpInputFieldWidget(
                              controller: controller.otpTextEditingController6,
                              textInputAction: TextInputAction.done,
                              onFieldSubmitted: (p0) {
                                FocusManager.instance.primaryFocus?.unfocus(
                                    disposition: UnfocusDisposition
                                        .previouslyFocusedChild);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    // SpaceWidget(spaceHeight: 24),
                    Obx(() {
                      print(
                          "Remaining Time: ${controller.remainingSeconds.value}"); // Debugging
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.sizeOf(context).width /
                              (MediaQuery.sizeOf(context).width / 8),
                        ),
                        child: TextWidget(
                          text: controller.canResend.value
                              ? "Remaining time: 00.00"
                              : "Resend code in ${controller.formatTime()}",
                          fontColor: controller.canResend.value
                              ? AppColors.greyLight
                              : AppColors.greyLight,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      );
                    }),

                    SpaceWidget(spaceHeight: 24),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.sizeOf(context).width /
                            (MediaQuery.sizeOf(context).width / 8),
                      ),
                      child: ButtonWidget(
                        onPressed: () {
                          if (controller.formKey.currentState!.validate()) {
                            controller.otpTextEditingController1.clear();
                            controller.otpTextEditingController2.clear();
                            controller.otpTextEditingController3.clear();
                            controller.otpTextEditingController4.clear();
                            controller.otpTextEditingController5.clear();
                            controller.otpTextEditingController6.clear();
                            controller
                                .verifyOTP(); // Call the verifyOTP method from the controller
                          } else if (controller
                                  .otpTextEditingController1.text.isEmpty ||
                              controller
                                  .otpTextEditingController2.text.isEmpty ||
                              controller
                                  .otpTextEditingController3.text.isEmpty ||
                              controller
                                  .otpTextEditingController4.text.isEmpty ||
                              controller
                                  .otpTextEditingController5.text.isEmpty ||
                              controller
                                  .otpTextEditingController6.text.isEmpty) {
                            // CustomToast.showToast("Please fill all fields");
                          }
                        },
                        label: 'Verify',
                        buttonWidth: double.infinity,
                        buttonHeight: 56,
                      ),
                    ),
                    SpaceWidget(spaceHeight: 24),
                    Obx(() {
                      // Debugging check
                      if (controller.canResend.value) {
                        print("Resend Code Button is now visible!");
                      }
                      return controller.canResend.value
                          ? Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: MediaQuery.sizeOf(context).width /
                                    (MediaQuery.sizeOf(context).width / 8),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextWidget(
                                    text: "Don't receive code?",
                                    fontColor: AppColors.greyLight,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    maxLines: 1,
                                  ),
                                  SpaceWidget(spaceWidth: 4),
                                  TextButtonWidget(
                                    onPressed: () {
                                      controller.resendCode();
                                    },
                                    text: 'Resend Code',
                                    textColor: AppColors.blueLight,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
                              ),
                            )
                          : SizedBox.shrink();
                    }),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
