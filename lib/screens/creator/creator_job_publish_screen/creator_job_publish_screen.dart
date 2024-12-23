import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itzel/screens/creator/creator_job_publish_screen/widgets/creator_job_publish_textfield_widget.dart';

import '../../../constants/app_colors.dart';
import '../../../widgets/appbar_widget/appbar_widget.dart';
import '../../../widgets/button_widget/button_widget.dart';
import '../../../widgets/space_widget/space_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';
import 'controllers/creator_job_publish_controller.dart';

class CreatorJobPublishScreen extends StatelessWidget {
  const CreatorJobPublishScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: AppColors.whiteBg,
      appBar: const AppbarWidget(text: 'Publishing Job'),
      body: GetBuilder<CreatorJobPublishController>(
          init: CreatorJobPublishController(),
          builder: (controller) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TextWidget(
                    text: 'Upload Picture',
                    fontColor: AppColors.black500,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  const SpaceWidget(spaceHeight: 4),
                  DottedBorder(
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(12),
                    child: InkWell(
                      onTap: controller.getImage,
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                        child: SizedBox(
                          height: size.height / (size.height / 143),
                          width: double.infinity,
                          child: controller.image == null
                              ? const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add,
                                      size: 32,
                                      color: AppColors.black500,
                                    ),
                                    SpaceWidget(spaceHeight: 12),
                                    TextWidget(
                                      text: 'Upload',
                                      fontColor: AppColors.black500,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ],
                                )
                              : Image.file(
                                  File(controller.image!.path),
                                  height: size.height / (size.height / 143),
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                    ),
                  ),
                  const SpaceWidget(spaceHeight: 16),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: TextWidget(
                      text: 'Company Name',
                      fontColor: AppColors.grey900,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SpaceWidget(spaceHeight: 4),
                  CreatorJobPublishTextFieldWidget(
                    hintText: '',
                    controller: controller.companyNameController,
                    maxLines: 1,
                  ),
                  const SpaceWidget(spaceHeight: 8),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: TextWidget(
                      text: 'Address',
                      fontColor: AppColors.grey900,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SpaceWidget(spaceHeight: 4),
                  CreatorJobPublishTextFieldWidget(
                    hintText: '',
                    controller: controller.addressController,
                    maxLines: 1,
                  ),
                  const SpaceWidget(spaceHeight: 8),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: TextWidget(
                      text: 'Role',
                      fontColor: AppColors.grey900,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SpaceWidget(spaceHeight: 4),
                  CreatorJobPublishTextFieldWidget(
                    hintText: '',
                    controller: controller.roleController,
                    maxLines: 1,
                  ),
                  const SpaceWidget(spaceHeight: 8),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: TextWidget(
                      text: 'Job Description',
                      fontColor: AppColors.grey900,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SpaceWidget(spaceHeight: 4),
                  CreatorJobPublishTextFieldWidget(
                    hintText: '',
                    controller: controller.jobDescriptionController,
                    maxLines: 1,
                  ),
                  const SpaceWidget(spaceHeight: 8),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: TextWidget(
                      text: 'Job Type',
                      fontColor: AppColors.grey900,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SpaceWidget(spaceHeight: 4),
                  CreatorJobPublishTextFieldWidget(
                    hintText: '',
                    controller: controller.jobTypeController,
                    maxLines: 1,
                  ),
                  const SpaceWidget(spaceHeight: 8),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: TextWidget(
                      text: 'Price',
                      fontColor: AppColors.grey900,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SpaceWidget(spaceHeight: 4),
                  CreatorJobPublishTextFieldWidget(
                    hintText: '',
                    controller: controller.priceController,
                    maxLines: 1,
                    keyboardType: TextInputType.number,
                  ),
                  const SpaceWidget(spaceHeight: 12),
                  ...List.generate(
                    controller.questions.length,
                    (index) {
                      final questionController =
                          controller.questions[index]['question']!;
                      final answerController =
                          controller.questions[index]['answer']!;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: TextWidget(
                                text: questionController.text,
                                fontColor: AppColors.grey900,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SpaceWidget(spaceHeight: 4),
                            CreatorJobPublishTextFieldWidget(
                              hintText: '',
                              controller: answerController,
                              maxLines: 1,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  InkWell(
                    onTap: () => controller.addQuestion(context),
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CircleAvatar(
                          radius: 15,
                          backgroundColor: AppColors.starIconUnselected,
                          child: Icon(
                            Icons.add,
                            size: 24,
                          ),
                        ),
                        SpaceWidget(spaceWidth: 9),
                        TextWidget(
                          text: 'Add Question',
                          fontColor: AppColors.black500,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                  ),
                  const SpaceWidget(spaceHeight: 48),
                  ButtonWidget(
                    onPressed: () {},
                    label: 'Publish Job',
                    buttonWidth: double.infinity,
                    buttonHeight: (size.height / (size.height / 56)),
                    buttonRadius: BorderRadius.circular(16),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
