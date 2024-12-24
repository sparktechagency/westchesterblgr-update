import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itzel/constants/app_colors.dart';
import 'package:itzel/routes/app_routes.dart';
import 'package:itzel/widgets/appbar_widget/appbar_widget.dart';
import 'package:itzel/widgets/space_widget/space_widget.dart';
import 'package:itzel/widgets/text_widget/text_widgets.dart';

class UserSavedJobsScreen extends StatelessWidget {
  final List<String> jobType = [
    'Part Time',
    'Senior-Level',
  ];
  UserSavedJobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: AppColors.whiteBg,
      appBar: const AppbarWidget(text: 'Saved Jobs'),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(size.width / (size.width / 16)),
            margin: EdgeInsets.only(
                left: size.width / (size.width / 20),
                right: size.width / (size.width / 20),
                bottom: size.width / (size.width / 12)),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppColors.greyLighter,
                width: size.width / (size.width / 0.7),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    'assets/images/homeImage.png',
                    height: size.width / (size.width / 32),
                    width: size.width / (size.width / 32),
                    fit: BoxFit.cover,
                  ),
                ),
                const SpaceWidget(spaceHeight: 8),
                const Row(
                  children: [
                    TextWidget(
                      text: 'Saint Marry School',
                      fontColor: AppColors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    SpaceWidget(spaceWidth: 4),
                    TextWidget(
                      text: '3 days ago',
                      fontColor: AppColors.grey700,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
                const SpaceWidget(spaceHeight: 8),
                const TextWidget(
                  text: 'Assistant Biology Teacher',
                  fontColor: AppColors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                const SpaceWidget(spaceHeight: 8),
                Row(
                  children: [
                    ...List.generate(jobType.length, (index) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width / (size.width / 7),
                            vertical: size.width / (size.width / 4)),
                        margin: EdgeInsets.only(
                            right: size.width / (size.width / 4)),
                        decoration: BoxDecoration(
                          color: AppColors.blue50,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: TextWidget(
                          text: jobType[index],
                          fontColor: AppColors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      );
                    }).toList(),
                  ],
                ),
                const SpaceWidget(spaceHeight: 30),
                Container(
                  color: AppColors.grey100,
                  height: size.height / (size.height / 1),
                  width: double.infinity,
                ),
                const SpaceWidget(spaceHeight: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          width: size.width / (size.width / 180),
                          child: const TextWidget(
                            text: '\$200-220/month',
                            fontColor: AppColors.black500,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            overflow: TextOverflow.ellipsis,
                            textAlignment: TextAlign.start,
                          ),
                        ),
                        SizedBox(
                          width: size.width / (size.width / 180),
                          child: const TextWidget(
                            text: '54/B St, Huston.',
                            fontColor: AppColors.grey700,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            overflow: TextOverflow.ellipsis,
                            textAlignment: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed(AppRoutes.userJobApplyingScreen);
                      },
                      borderRadius: BorderRadius.circular(4),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width / (size.width / 9),
                            vertical: size.width / (size.width / 4)),
                        margin: EdgeInsets.only(
                            right: size.width / (size.width / 4)),
                        decoration: BoxDecoration(
                          color: AppColors.blueNormal,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const TextWidget(
                          text: 'Apply now',
                          fontColor: AppColors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
