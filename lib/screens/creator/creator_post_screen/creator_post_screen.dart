import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:itzel/routes/app_routes.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_icons_path.dart';
import '../../../utils/app_size.dart';
import '../../../widgets/app_image/app_image.dart';
import '../../../widgets/button_widget/button_widget.dart';
import '../../../widgets/icon_button_widget/icon_button_widget.dart';
import '../../../widgets/space_widget/space_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';
import 'controllers/creator_post_controller.dart';

class CreatorPostScreen extends StatefulWidget {
  const CreatorPostScreen({super.key});

  @override
  State<CreatorPostScreen> createState() => _CreatorPostScreenState();
}

class _CreatorPostScreenState extends State<CreatorPostScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  final CreatorPostController controller = Get.put(CreatorPostController());

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
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else if (controller.creatorStatus.value.allJobs.isEmpty &&
              controller.creatorStatus.value.allEvents.isEmpty) {
            return const Center(child: Text('No data available.'));
          } else {
            return Column(
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
                        text:
                            "Event Post (${controller.creatorStatus.value.allEvents.length})",
                      ),
                      Tab(
                        text:
                            "Job Post (${controller.creatorStatus.value.allJobs.length})",
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
            );
          }
        }),
      ),
    );
  }

  Widget _buildEventPostTab(Size size) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ...controller.creatorStatus.value.allEvents.map(
            (event) {
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
                              child: AppImage(
                                url: event.thumbnailImage,
                                height: size.width / (size.width / 45),
                                width: size.width / (size.width / 45),
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SpaceWidget(spaceWidth: 8),
                            SizedBox(
                              width: size.width / (size.width / 215),
                              child: TextWidget(
                                text: event.name,
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
          ).toList(),
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
          ...controller.creatorStatus.value.allJobs.map(
            (job) {
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
                              child: AppImage(
                                url: job.image,
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
                                  child: TextWidget(
                                    text: job.role,
                                    fontColor: AppColors.black900,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    overflow: TextOverflow.ellipsis,
                                    textAlignment: TextAlign.left,
                                  ),
                                ),
                                const SpaceWidget(spaceHeight: 4),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    TextWidget(
                                      text: job.companyName,
                                      fontColor: AppColors.black,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      overflow: TextOverflow.ellipsis,
                                      textAlignment: TextAlign.left,
                                    ),
                                    const SpaceWidget(spaceWidth: 4),
                                    TextWidget(
                                      text: DateFormat('dd.MM.yyyy, hh:mm a')
                                          .format(job.createdAt),
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
          ).toList(),
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
