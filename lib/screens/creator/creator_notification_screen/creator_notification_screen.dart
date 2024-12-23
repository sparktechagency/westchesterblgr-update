import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_strings.dart';
import '../../../utils/app_size.dart';
import '../../../widgets/appbar_widget/appbar_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';
import 'controllers/creator_notification_controller.dart';

class CreatorNotificationScreen extends StatelessWidget {
  const CreatorNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: AppColors.whiteBg,
      appBar: const AppbarWidget(text: AppStrings.notification),
      body: GetBuilder<CreatorNotificationController>(
          init: CreatorNotificationController(),
          builder: (controller) {
            return ListView.builder(
                itemCount: controller.title.length,
                padding: EdgeInsets.only(top: size.width / (size.width / 12)),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(size.width / (size.width / 12)),
                    margin: EdgeInsets.only(
                      left: size.width / (size.width / 20),
                      right: size.width / (size.width / 20),
                      bottom: size.width / (size.width / 12),
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.blueNormal,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          text: controller.title[index],
                          fontColor: AppColors.whiteBg,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          maxLines: 2,
                        ),
                        TextWidget(
                          text: controller.subTitle[index],
                          fontColor: AppColors.whiteBg,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          maxLines: 2,
                        ),
                        TextWidget(
                          text: controller.date[index],
                          fontColor: AppColors.whiteLight,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                  );
                });
          }),
    );
  }
}
