import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:itzel/screens/user/user_job_applying_screen/widgets/SubmitButtonWidget.dart';
import 'package:itzel/screens/user/user_job_applying_screen/widgets/job_applying_text_field_widget.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_images_path.dart';
import '../../../constants/app_strings.dart';
import '../../../utils/app_size.dart';
import '../../../widgets/appbar_widget/appbar_widget.dart';
import '../../../widgets/space_widget/space_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';
import 'controllers/user_job_applying_controller.dart';

class UserJobApplyingScreen extends StatelessWidget {
  const UserJobApplyingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: AppColors.whiteBg,
        appBar: const AppbarWidget(text: AppStrings.applying),
        body: GetBuilder<UserJobApplyingController>(
            init: UserJobApplyingController(),
            builder: (controller) {
              return SingleChildScrollView(
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(AppSize.width(value: 16)),
                        margin: EdgeInsets.only(
                          left: size.width / (size.width / 20),
                          right: size.width / (size.width / 20),
                          bottom: size.width / (size.width / 20),
                          top: size.width / (size.width / 12),
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: AppColors.grey500,
                              spreadRadius: 1,
                              blurRadius: 3,
                            )
                          ],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.asset(
                                    AppImagesPath.profileImage,
                                    height: size.width / (size.width / 40),
                                    width: size.width / (size.width / 40),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SpaceWidget(spaceWidth: 6),
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextWidget(
                                      text: AppStrings.designation,
                                      fontColor: AppColors.black500,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    SpaceWidget(spaceHeight: 4),
                                    Row(
                                      children: [
                                        TextWidget(
                                          text: AppStrings.instituteName,
                                          fontColor: AppColors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        SpaceWidget(spaceWidth: 4),
                                        TextWidget(
                                          text: AppStrings.jobPostingDate,
                                          fontColor: AppColors.grey700,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                            const SpaceWidget(spaceHeight: 20),
                            const TextWidget(
                              text: AppStrings.jobRequirementHeader,
                              fontColor: AppColors.grey700,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              textAlignment: TextAlign.justify,
                            ),
                            const SpaceWidget(spaceHeight: 12),
                            const TextWidget(
                              text: AppStrings.requirements,
                              fontColor: AppColors.grey900,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                            const SpaceWidget(spaceHeight: 12),
                            const TextWidget(
                              text: AppStrings.requirementDetails,
                              fontColor: AppColors.grey700,
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              textAlignment: TextAlign.justify,
                            ),
                            const SpaceWidget(spaceHeight: 12),
                            const TextWidget(
                              text: AppStrings.experience,
                              fontColor: AppColors.grey900,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                            const SpaceWidget(spaceHeight: 12),
                            const TextWidget(
                              text: AppStrings.experienceDetails,
                              fontColor: AppColors.grey700,
                               fontSize: 13,
                              fontWeight: FontWeight.w400,
                              textAlignment: TextAlign.justify,
                            ),
                            const SpaceWidget(spaceHeight: 12),
                            const TextWidget(
                              text: AppStrings.additionalRequirements,
                              fontColor: AppColors.grey900,
                               fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                            const SpaceWidget(spaceHeight: 12),
                            const TextWidget(
                              text: AppStrings.additionalRequirementsDetails,
                              fontColor: AppColors.grey700,
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              textAlignment: TextAlign.justify,
                            ),
                            const SpaceWidget(spaceHeight: 16),
                            const TextWidget(
                              text: AppStrings.name,
                              fontColor: AppColors.black400,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                            const SpaceWidget(spaceHeight: 4),
                            JobApplyingTextFieldWidget(
                              controller: controller.nameController,
                              maxLines: 1,
                              validator: (value) =>
                                  value!.isEmpty ? "Enter Name" : null,
                            ),
                            const SpaceWidget(spaceHeight: 8),
                            const TextWidget(
                              text: AppStrings.address,
                              fontColor: AppColors.black400,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                            const SpaceWidget(spaceHeight: 4),
                            JobApplyingTextFieldWidget(
                              controller: controller.addressController,
                              maxLines: 1,
                              validator: (value) =>
                                  value!.isEmpty ? "Enter Address" : null,
                            ),
                            const SpaceWidget(spaceHeight: 8),
                            const TextWidget(
                              text: AppStrings.email,
                              fontColor: AppColors.black400,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                            const SpaceWidget(spaceHeight: 4),
                            JobApplyingTextFieldWidget(
                              controller: controller.emailController,
                              maxLines: 1,
                              validator: (value) {
                                bool emailValid =
                                    RegExp(r"^[^\s@]+@[^\s@]+\.[^\s@]+$")
                                        .hasMatch(value!);
                                if (value.isEmpty) return "Enter Email";
                                if (!emailValid) return "Enter valid Email";
                                return null;
                              },
                            ),
                            const SpaceWidget(spaceHeight: 8),
                            const TextWidget(
                              text: AppStrings.phoneNumber,
                              fontColor: AppColors.black400,
                             fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                            const SpaceWidget(spaceHeight: 4),
                            JobApplyingTextFieldWidget(
                              controller: controller.phoneNumberController,
                              maxLines: 1,
                              validator: (value) =>
                                  value!.isEmpty ? "Enter Number" : null,
                              keyboardType: TextInputType.number,
                            ),
                            const SpaceWidget(spaceHeight: 8),
                            const TextWidget(
                              text: AppStrings.experience,
                              fontColor: AppColors.black400,
                             fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                            const SpaceWidget(spaceHeight: 4),
                            JobApplyingTextFieldWidget(
                              controller: controller.experienceController,
                              maxLines: 1,
                              validator: (value) =>
                                  value!.isEmpty ? "Enter Experience" : null,
                            ),
                            const SpaceWidget(spaceHeight: 8),
                            const TextWidget(
                              text: AppStrings.citizenship,
                              fontColor: AppColors.black400,
                             fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                            const SpaceWidget(spaceHeight: 4),
                            JobApplyingTextFieldWidget(
                              controller: controller.citizenshipController,
                              maxLines: 1,
                              validator: (value) =>
                                  value!.isEmpty ? "Enter Citizenship" : null,
                            ),
                            const SpaceWidget(spaceHeight: 8),
                            const TextWidget(
                              text: AppStrings.highSchool,
                              fontColor: AppColors.black400,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                            const SpaceWidget(spaceHeight: 4),
                            JobApplyingTextFieldWidget(
                              controller: controller.highSchoolController,
                              maxLines: 1,
                              validator: (value) =>
                                  value!.isEmpty ? "Enter High School" : null,
                            ),
                            const SpaceWidget(spaceHeight: 8),
                            const TextWidget(
                              text: AppStrings.graduatedHighSchoolYear,
                              fontColor: AppColors.black400,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                            const SpaceWidget(spaceHeight: 4),
                            JobApplyingTextFieldWidget(
                              controller:
                                  controller.graduatedHighSchoolYearController,
                              maxLines: 1,
                              validator: (value) => value!.isEmpty
                                  ? "Enter Graduated High School Year"
                                  : null,
                            ),
                            const SpaceWidget(spaceHeight: 8),
                            const TextWidget(
                              text: AppStrings.college,
                              fontColor: AppColors.black400,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                            const SpaceWidget(spaceHeight: 4),
                            JobApplyingTextFieldWidget(
                              controller: controller.collegeController,
                              maxLines: 1,
                              validator: (value) =>
                                  value!.isEmpty ? "Enter College" : null,
                            ),
                            const SpaceWidget(spaceHeight: 8),
                            const TextWidget(
                              text: AppStrings.graduatedYear,
                              fontColor: AppColors.black400,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                            const SpaceWidget(spaceHeight: 4),
                            JobApplyingTextFieldWidget(
                              controller: controller.graduatedYearController,
                              maxLines: 1,
                              validator: (value) => value!.isEmpty
                                  ? "Enter Graduated Year"
                                  : null,
                            ),
                            const SpaceWidget(spaceHeight: 24),
                            SubmitButtonWidget(
                              onPressed: controller.submitForm,
                              label: AppStrings.submit,
                              buttonWidth: double.infinity,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
