import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:itzel/screens/user/user_job_applying_screen/widgets/SubmitButtonWidget.dart';
import 'package:itzel/screens/user/user_job_applying_screen/widgets/job_applying_text_field_widget.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_strings.dart';
import '../../../utils/app_size.dart';
import '../../../widgets/app_image/app_image.dart';
import '../../../widgets/appbar_widget/appbar_widget.dart';
import '../../../widgets/space_widget/space_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';
import 'controllers/user_job_applying_controller.dart';

class UserJobApplyingScreen extends StatelessWidget {
  final UserJobApplyingController _controller =
      Get.put(UserJobApplyingController());

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final experienceController = TextEditingController();
  final citizenshipController = TextEditingController();
  final highSchoolController = TextEditingController();
  final graduatedHighSchoolYearController = TextEditingController();
  final collegeController = TextEditingController();
  final graduatedYearController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  void submitForm() {
    if (formKey.currentState!.validate()) {
      // Perform submit action
      print('Form Submitted Successfully');
    } else {
      print('Validation Failed');
    }
  }

  UserJobApplyingScreen({super.key});

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
        body: Obx(() {
          if (_controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else {
            final job = _controller.jobDetails.value;
            return SingleChildScrollView(
              child: Form(
                key: formKey,
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
                                child: AppImage(
                                  url: job.image,
                                  height: size.width / (size.width / 40),
                                  width: size.width / (size.width / 40),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SpaceWidget(spaceWidth: 6),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextWidget(
                                    text: capitalize(job.role),
                                    fontColor: AppColors.black500,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  const SpaceWidget(spaceHeight: 4),
                                  Row(
                                    children: [
                                      TextWidget(
                                        text: capitalize(job.companyName),
                                        fontColor: AppColors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      const SpaceWidget(spaceWidth: 4),
                                      TextWidget(
                                        text: DateFormat('dd.MM.yyyy, hh:mm a')
                                            .format(job.createdAt),
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
                          TextWidget(
                            text: capitalize(job.description),
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
                          ...job.requirements.map((requirement) => TextWidget(
                                text: capitalize("• $requirement"),
                                fontColor: AppColors.grey700,
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                textAlignment: TextAlign.justify,
                              )),
                          const SpaceWidget(spaceHeight: 12),
                          const TextWidget(
                            text: AppStrings.experience,
                            fontColor: AppColors.grey900,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                          const SpaceWidget(spaceHeight: 12),
                          ...job.experience.map((exp) => TextWidget(
                                text: capitalize("• $exp"),
                                fontColor: AppColors.grey700,
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                textAlignment: TextAlign.justify,
                              )),
                          const SpaceWidget(spaceHeight: 12),
                          const TextWidget(
                            text: AppStrings.additionalRequirements,
                            fontColor: AppColors.grey900,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                          const SpaceWidget(spaceHeight: 12),
                          ...job.additionalRequirement
                              .map((additionalReq) => TextWidget(
                                    text: capitalize("• $additionalReq"),
                                    fontColor: AppColors.grey700,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    textAlignment: TextAlign.justify,
                                  )),
                          const SpaceWidget(spaceHeight: 16),
                          const TextWidget(
                            text: AppStrings.name,
                            fontColor: AppColors.black400,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                          const SpaceWidget(spaceHeight: 4),
                          JobApplyingTextFieldWidget(
                            controller: nameController,
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
                            controller: addressController,
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
                            controller: emailController,
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
                            controller: phoneNumberController,
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
                            controller: experienceController,
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
                            controller: citizenshipController,
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
                            controller: highSchoolController,
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
                            controller: graduatedHighSchoolYearController,
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
                            controller: collegeController,
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
                            controller: graduatedYearController,
                            maxLines: 1,
                            validator: (value) =>
                                value!.isEmpty ? "Enter Graduated Year" : null,
                          ),
                          const SpaceWidget(spaceHeight: 24),
                          SubmitButtonWidget(
                            onPressed: submitForm,
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
          }
        }),
      ),
    );
  }
}
