import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_strings.dart';
import '../../../utils/app_size.dart';
import '../../../widgets/appbar_widget/appbar_widget.dart';
import '../../../widgets/space_widget/space_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';
import 'controllers/creator_faq_controller.dart';

class CreatorFaqScreen extends StatelessWidget {
  const CreatorFaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: AppColors.whiteBg,
      appBar: const AppbarWidget(text: AppStrings.faqTitle),
      body: GetBuilder<CreatorFaqController>(
        init: CreatorFaqController(),
        builder: (controller) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                controller.faqList.length,
                (index) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      text: controller.faqList[index]["question"] ?? "",
                      fontColor: AppColors.blackLight2,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      textAlignment: TextAlign.start,
                    ),
                    const SpaceWidget(spaceHeight: 2),
                    TextWidget(
                      text: controller.faqList[index]["answer"] ?? "",
                      fontColor: AppColors.blackLight2,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      textAlignment: TextAlign.start,
                    ),
                    const SpaceWidget(spaceHeight: 24),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
