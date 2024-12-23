import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/app_size.dart';
import '../../../widgets/space_widget/space_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';
import 'controllers/user_home_controller.dart';

class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    ResponsiveUtils.initialize(context);
    return Scaffold(
      backgroundColor: AppColors.whiteBg,
      body: GetBuilder<UserHomeController>(
          init: UserHomeController(),
          builder: (controller) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SpaceWidget(spaceHeight: 12),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: ResponsiveUtils.width(20)),
                    child: const TextWidget(
                      text: 'Featured',
                      fontColor: AppColors.black500,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SpaceWidget(spaceHeight: 5),
                  ...List.generate(5, (index) {
                    return InkWell(
                      onTap: () {
                        Get.toNamed(AppRoutes.userHomeDetailsScreen);
                      },
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(size.width / (size.width / 8)),
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
                            )),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                'assets/images/homeImage.png',
                                height: size.height / (size.height / 192),
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SpaceWidget(spaceHeight: 6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    ...controller.types.map((type) {
                                      return Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                size.width / (size.width / 7),
                                            vertical:
                                                size.width / (size.width / 4)),
                                        margin: EdgeInsets.only(
                                            right:
                                                size.width / (size.width / 4)),
                                        decoration: BoxDecoration(
                                          color: AppColors.blue50,
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: TextWidget(
                                          text: type,
                                          fontColor: AppColors.black,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      );
                                    }).toList(),
                                  ],
                                ),
                                const TextWidget(
                                  text: '\$9.32',
                                  fontColor: AppColors.black500,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                            const SpaceWidget(spaceHeight: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: size.width / (size.width / 210),
                                  child: const TextWidget(
                                    text:
                                        'Electro Music Festival - Valleria night with DJ Hardwell',
                                    fontColor: AppColors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlignment: TextAlign.start,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {},
                                  borderRadius: BorderRadius.circular(4),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            size.width / (size.width / 9),
                                        vertical:
                                            size.width / (size.width / 4)),
                                    margin: EdgeInsets.only(
                                        right: size.width / (size.width / 4)),
                                    decoration: BoxDecoration(
                                      color: AppColors.blueNormal,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: const TextWidget(
                                      text: 'Go now',
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
                    );
                  }),
                  const SpaceWidget(spaceHeight: 80),
                ],
              ),
            );
          }),
    );
  }
}
