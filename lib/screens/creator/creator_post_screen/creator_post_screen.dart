import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:itzel/routes/app_routes.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_icons_path.dart';
import '../../../utils/app_size.dart';
import '../../../widgets/button_widget/button_widget.dart';
import '../../../widgets/icon_button_widget/icon_button_widget.dart';
import '../../../widgets/space_widget/space_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';

class CreatorPostScreen extends StatefulWidget {
  const CreatorPostScreen({super.key});

  @override
  State<CreatorPostScreen> createState() => _CreatorPostScreenState();
}

class _CreatorPostScreenState extends State<CreatorPostScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  int eventPostCount = 2;
  int jobPostCount = 5;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: AppColors.whiteBg,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TabBar(
                unselectedLabelColor: AppColors.grey700,
                labelColor: AppColors.blueNormal,
                dividerColor: AppColors.blueLighter,
                indicator: UnderlineTabIndicator(
                  borderRadius: BorderRadius.circular(100),
                  borderSide: BorderSide(
                    color: AppColors.blueNormal,
                    width: AppSize.width(value: 5),
                  ),
                ),
                tabs: [
                  Tab(
                    text: "Event Post ($eventPostCount)",
                  ),
                  Tab(
                    text: "Job Post ($jobPostCount)",
                  ),
                ],
                controller: tabController,
                indicatorSize: TabBarIndicatorSize.tab,
              ),
            ),
            const SpaceWidget(spaceHeight: 16),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  _buildEventPostTab(size),
                  _buildJobPostTab(size),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventPostTab(Size size) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ...List.generate(
            5,
            (index) {
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                margin: EdgeInsets.only(
                  left: size.width / (size.width / 20),
                  right: size.width / (size.width / 20),
                  bottom: size.width / (size.width / 12),
                ),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.grey200,
                      spreadRadius: 1,
                      blurRadius: 3,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.asset(
                                'assets/images/homeImage.png',
                                height: size.width / (size.width / 45),
                                width: size.width / (size.width / 45),
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SpaceWidget(spaceWidth: 8),
                            SizedBox(
                              width: size.width / (size.width / 215),
                              child: const TextWidget(
                                text:
                                    'Electro Music Festival - Valleria night with DJ Hardwell',
                                fontColor: AppColors.black900,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlignment: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                        IconButtonWidget(
                          icon: AppIconsPath.newChatIcon,
                          onTap: () {},
                          color: AppColors.black900,
                          size: 24,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
          const SpaceWidget(spaceHeight: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ButtonWidget(
              onPressed: () {
                Get.toNamed(AppRoutes.creatorEventCreateScreen);
              },
              label: 'Create Event',
              buttonWidth: double.infinity,
              buttonHeight: size.height / (size.height / 56),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJobPostTab(Size size) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ...List.generate(
            5,
            (index) {
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                margin: EdgeInsets.only(
                  left: size.width / (size.width / 20),
                  right: size.width / (size.width / 20),
                  bottom: size.width / (size.width / 12),
                ),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.grey200,
                      spreadRadius: 1,
                      blurRadius: 3,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.asset(
                                'assets/images/jobProfileImage.png',
                                height: size.width / (size.width / 45),
                                width: size.width / (size.width / 45),
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SpaceWidget(spaceWidth: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: size.width / (size.width / 215),
                                  child: const TextWidget(
                                    text: 'Assistant Biology Teacher',
                                    fontColor: AppColors.black900,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    overflow: TextOverflow.ellipsis,
                                    textAlignment: TextAlign.left,
                                  ),
                                ),
                                const SpaceWidget(spaceHeight: 4),
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    TextWidget(
                                      text: 'Saint Marry School',
                                      fontColor: AppColors.black,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      overflow: TextOverflow.ellipsis,
                                      textAlignment: TextAlign.left,
                                    ),
                                    SpaceWidget(spaceWidth: 4),
                                    TextWidget(
                                      text: '3 days ago',
                                      fontColor: AppColors.grey700,
                                      fontSize: 8,
                                      fontWeight: FontWeight.w500,
                                      overflow: TextOverflow.ellipsis,
                                      textAlignment: TextAlign.left,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        IconButtonWidget(
                          icon: AppIconsPath.newChatIcon,
                          onTap: () {},
                          color: AppColors.black900,
                          size: 24,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
          const SpaceWidget(spaceHeight: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ButtonWidget(
              onPressed: () {
                Get.toNamed(AppRoutes.creatorJobPublishScreen);
              },
              label: 'Publish Job Post',
              buttonWidth: double.infinity,
              buttonHeight: size.height / (size.height / 56),
            ),
          ),
        ],
      ),
    );
  }
}
