import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_strings.dart';
import '../../../widgets/appbar_widget/appbar_widget.dart';
import '../../../widgets/space_widget/space_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';

class UserFaqScreen extends StatelessWidget {
  const UserFaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    final List<Map<String, String>> faqList = [
      {
        "question": AppStrings.faqQues1,
        "answer": AppStrings.faqAns1,
      },
      {
        "question": AppStrings.faqQues2,
        "answer": AppStrings.faqAns2,
      },
      {
        "question": AppStrings.faqQues3,
        "answer": AppStrings.faqAns3,
      },
      {
        "question": AppStrings.faqQues4,
        "answer": AppStrings.faqAns4,
      },
      {
        "question": AppStrings.faqQues5,
        "answer": AppStrings.faqAns5,
      },
      {
        "question": AppStrings.faqQues6,
        "answer": AppStrings.faqAns6,
      },
    ];
    return Scaffold(
      backgroundColor: AppColors.whiteBg,
      appBar: const AppbarWidget(text: AppStrings.faqTitle),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            faqList.length,
            (index) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  text: faqList[index]["question"] ?? "",
                  fontColor: AppColors.blackLight2,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  textAlignment: TextAlign.start,
                ),
                const SpaceWidget(spaceHeight: 2),
                TextWidget(
                  text: faqList[index]["answer"] ?? "",
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
      ),
    );
  }
}
