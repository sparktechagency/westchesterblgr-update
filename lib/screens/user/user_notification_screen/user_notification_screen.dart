import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_strings.dart';
import '../../../widgets/appbar_widget/appbar_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';

class UserNotificationScreen extends StatelessWidget {
  final List<String> title = [
    "Order is completed",
    "Delivery is completed",
    "New Winter Collection Available!",
  ];

  final List<String> subTitle = [
    "Payment method is Cash On Delivery",
    "Your order has been delivered by Mr. Reza",
    "Check new featured winter collection",
  ];

  final List<String> date = [
    "20-Dec-2024, 3:00 PM",
    "20-Dec-2024, 3:00 PM",
    "20-Dec-2024, 3:00 PM",
  ];

  UserNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
        backgroundColor: AppColors.whiteBg,
        appBar: const AppbarWidget(text: AppStrings.notification),
        body: ListView.builder(
            itemCount: title.length,
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
                      text: title[index],
                      fontColor: AppColors.whiteBg,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      maxLines: 2,
                    ),
                    TextWidget(
                      text: subTitle[index],
                      fontColor: AppColors.whiteBg,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      maxLines: 2,
                    ),
                    TextWidget(
                      text: date[index],
                      fontColor: AppColors.whiteLight,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
              );
            }));
  }
}
