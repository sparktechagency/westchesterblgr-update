import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itzel/utils/app_size.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_strings.dart';
import '../../../widgets/appbar_widget/appbar_widget.dart';
import '../../../widgets/space_widget/space_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';
import 'controllers/creator_terms_condition_controller.dart';

class CreatorTermsConditionScreen extends StatelessWidget {
  const CreatorTermsConditionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: AppColors.whiteBg,
      appBar: const AppbarWidget(text: AppStrings.termsConditions),
      body: GetBuilder<CreatorTermsConditionController>(
        init: CreatorTermsConditionController(),
        builder: (controller) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                controller.termsList.length,
                (index) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      text: controller.termsList[index]["question"] ?? "",
                      fontColor: AppColors.blackLight2,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      textAlignment: TextAlign.start,
                    ),
                    const SpaceWidget(spaceHeight: 2),
                    TextWidget(
                      text: controller.termsList[index]["answer"] ?? "",
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
