import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itzel/widgets/button_widget/button_widget.dart';

import '../../../constants/app_colors.dart';
import '../../../widgets/appbar_widget/appbar_widget.dart';
import '../../../widgets/space_widget/space_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';
import 'controllers/creator_subscription_controller.dart';

class CreatorSubscriptionsScreen extends StatelessWidget {
  const CreatorSubscriptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: AppColors.whiteBg,
      appBar: const AppbarWidget(text: 'Subscriptions'),
      body: GetBuilder<CreatorSubscriptionsController>(
          init: CreatorSubscriptionsController(),
          builder: (controller) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...List.generate(
                    controller.subscriptionPack.length,
                    (index) {
                      return InkWell(
                        onTap: () => controller.selectPack(index),
                        borderRadius: BorderRadius.circular(16),
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        child: Container(
                          width: double.infinity,
                          padding:
                              EdgeInsets.all(size.width / (size.width / 16)),
                          margin: EdgeInsets.only(
                              bottom: size.width / (size.width / 12)),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: (index == controller.selectedPackIndex)
                                  ? AppColors.blueNormal
                                  : AppColors.grey300,
                              width: size.width / (size.width / 2),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(
                                text: controller.subscriptionPack[index],
                                fontColor: AppColors.black500,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                              const SpaceWidget(spaceHeight: 2),
                              const TextWidget(
                                text: '\$6.23/month',
                                fontColor: AppColors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                              const SpaceWidget(spaceHeight: 12),
                              GridView.count(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                childAspectRatio: 8,
                                crossAxisCount: 2,
                                crossAxisSpacing: size.width / (size.width / 2),
                                mainAxisSpacing: size.width / (size.width / 2),
                                children: controller.features.map((feature) {
                                  return Row(
                                    children: [
                                      const CircleAvatar(
                                        radius: 3,
                                        backgroundColor: AppColors.blueNormal,
                                      ),
                                      const SpaceWidget(spaceWidth: 4),
                                      TextWidget(
                                        text: feature,
                                        fontColor: AppColors.blueNormal,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ],
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const SpaceWidget(spaceHeight: 24),
                  ButtonWidget(
                    onPressed: controller.subscribe,
                    label: 'Subscribe',
                    buttonWidth: double.infinity,
                  ),
                  const SpaceWidget(spaceHeight: 12),
                  const TextWidget(
                    text:
                        'By subscribing you will be able to access all the feature and you will be able to cancel anytime.',
                    fontColor: AppColors.grey700,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
            );
          }),
    );
  }
}
