import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itzel/constants/app_icons_path.dart';
import 'package:itzel/widgets/button_widget/button_widget.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_images_path.dart';
import '../../../constants/app_strings.dart';
import '../../../routes/app_routes.dart';
import '../../../widgets/app_image/app_image.dart';
import '../../../widgets/icon_button_widget/icon_button_widget.dart';
import '../../../widgets/space_widget/space_widget.dart';
import '../../../widgets/text_button_widget/text_button_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';
import '../creator_job_details_screen/creator_job_details_screen.dart';
import 'controllers/creator_dashboard_controller.dart';

class CreatorDashboardScreen extends StatefulWidget {
  const CreatorDashboardScreen({super.key});

  @override
  State<CreatorDashboardScreen> createState() => _CreatorDashboardScreenState();
}

class _CreatorDashboardScreenState extends State<CreatorDashboardScreen> {
  final CreatorDashboardController _controller =
      Get.put(CreatorDashboardController());
  String eventStatus =
      'Electro Music Festival - Valleria night with DJ Hardwell';
  int totalEarnings = 632; // Example values
  int totalViews = 20;
  String ticketType = 'Virtual';

  // List of job applicants
  List<Map<String, String>> jobApplicants = [
    {"name": "Itzel Rosengen", "image": "assets/images/chatProfileImage.png"},
    {"name": "John Doe", "image": "assets/images/chatProfileImage.png"},
    {"name": "Jane Smith", "image": "assets/images/chatProfileImage.png"},
    {"name": "Itzel Rosengen", "image": "assets/images/chatProfileImage.png"},
    {"name": "John Doe", "image": "assets/images/chatProfileImage.png"},
    {"name": "Jane Smith", "image": "assets/images/chatProfileImage.png"},
    {"name": "Itzel Rosengen", "image": "assets/images/chatProfileImage.png"},
    {"name": "John Doe", "image": "assets/images/chatProfileImage.png"},
    {"name": "Jane Smith", "image": "assets/images/chatProfileImage.png"},
    {"name": "Itzel Rosengen", "image": "assets/images/chatProfileImage.png"},
    {"name": "John Doe", "image": "assets/images/chatProfileImage.png"},
    {"name": "Jane Smith", "image": "assets/images/chatProfileImage.png"},
  ];

  void updateEventStatus(String newStatus) {
    setState(() {
      eventStatus = newStatus;
    });
  }

  void updateStats(int earnings, int views, String ticket) {
    setState(() {
      totalEarnings = earnings;
      totalViews = views;
      ticketType = ticket;
    });
  }

  void updateJobApplicants(List<Map<String, String>> newApplicants) {
    setState(() {
      jobApplicants = newApplicants;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: AppColors.whiteBg,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SpaceWidget(spaceHeight: 12),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width / (size.width / 20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TextWidget(
                    text: AppStrings.eventStatus,
                    fontColor: AppColors.black500,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  TextButtonWidget(
                    onPressed: () {
                      Get.toNamed(AppRoutes.creatorAllEventStatusScreen);
                    },
                    text: AppStrings.seeMore,
                    textColor: AppColors.blueNormal,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.blueLight,
                  ),
                ],
              ),
            ),
            const SpaceWidget(spaceHeight: 12),
            Obx(() {
              final eventStatus = _controller.eventStatus.value;
              return Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                margin: EdgeInsets.only(
                  left: size.width / (size.width / 20),
                  right: size.width / (size.width / 20),
                  bottom: size.width / (size.width / 12),
                ),
                decoration: BoxDecoration(
                  color: AppColors.blueNormal,
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
                                url: eventStatus.thumbnailImage,
                                height: size.width / (size.width / 45),
                                width: size.width / (size.width / 71),
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SpaceWidget(spaceWidth: 8),
                            SizedBox(
                              width: size.width / (size.width / 180),
                              child: TextWidget(
                                text: eventStatus.name,
                                fontColor: AppColors.whiteBg,
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
                          icon: AppIconsPath.moreIcon,
                          onTap: () {},
                          color: AppColors.whiteBg,
                          size: 24,
                        ),
                      ],
                    ),
                    const SpaceWidget(spaceHeight: 16),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 14),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            flex: 1,
                            child: _buildStatItem('Total Earning',
                                '\$${eventStatus.totalEarning / 100}'),
                          ),
                          //const SpaceWidget(spaceWidth: 2),
                          // _buildDivider(context),
                          // const SpaceWidget(spaceWidth: 2),
                          // Expanded(
                          //   flex: 1,
                          //   child: _buildStatItem(
                          //       'Total Views', '${eventStatus.ticketSold}'),
                          // ),
                          // const SpaceWidget(spaceWidth: 2),
                          _buildDivider(context),
                          const SpaceWidget(spaceWidth: 2),
                          Expanded(
                            flex: 1,
                            child: _buildStatItem('Tickets Sold',
                                eventStatus.ticketSold.toString()),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width / (size.width / 20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TextWidget(
                    text: AppStrings.jobApplicants,
                    fontColor: AppColors.black500,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  TextButtonWidget(
                    onPressed: () {
                      Get.toNamed(AppRoutes.creatorAllJobApplicationScreen);
                    },
                    text: AppStrings.seeMore,
                    textColor: AppColors.blueNormal,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.blueLight,
                  ),
                ],
              ),
            ),
            const SpaceWidget(spaceHeight: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              margin: EdgeInsets.only(
                left: size.width / (size.width / 20),
                right: size.width / (size.width / 20),
                bottom: size.width / (size.width / 12),
              ),
              decoration: BoxDecoration(
                color: AppColors.blueNormal,
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
                              height: size.width / (size.width / 43),
                              width: size.width / (size.width / 45),
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SpaceWidget(spaceWidth: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: size.width / (size.width / 250),
                                child: const TextWidget(
                                  text: 'Assistant Biology Teacher',
                                  fontColor: AppColors.whiteBg,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  overflow: TextOverflow.ellipsis,
                                  textAlignment: TextAlign.left,
                                ),
                              ),
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  TextWidget(
                                    text: 'Saint Marry School',
                                    fontColor: AppColors.grey50,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    overflow: TextOverflow.ellipsis,
                                    textAlignment: TextAlign.left,
                                  ),
                                  SpaceWidget(spaceWidth: 4),
                                  TextWidget(
                                    text: '3 days ago',
                                    fontColor: AppColors.grey500,
                                    fontSize: 10,
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
                    ],
                  ),
                  const SpaceWidget(spaceHeight: 8),
                  Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Center(
                      child: TextWidget(
                        text: 'Total Applicant - 98',
                        fontColor: AppColors.black500,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SpaceWidget(spaceHeight: 10),
                  Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Column(
                      children: [
                        const SpaceWidget(spaceHeight: 10),
                        ...jobApplicants.map(
                          (applicant) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: Image.asset(
                                          applicant["image"] ??
                                              AppImagesPath.chatProfileImage,
                                          height:
                                              size.width / (size.width / 25),
                                          width: size.width / (size.width / 25),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SpaceWidget(spaceWidth: 8),
                                      TextWidget(
                                        text: applicant["name"] ?? "",
                                        fontColor: AppColors.black500,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ],
                                  ),
                                  ButtonWidget(
                                    onPressed: () {
                                      Get.to(() =>
                                          const CreatorJobDetailsScreen());
                                    },
                                    label: 'Details',
                                    buttonWidth: size.width / (size.width / 79),
                                    buttonHeight:
                                        size.width / (size.width / 26),
                                    fontSize: size.width / (size.width / 12),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SpaceWidget(spaceHeight: 80),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String title, String value) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextWidget(
          text: title,
          fontColor: AppColors.black900,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        const SpaceWidget(spaceHeight: 8),
        TextWidget(
          text: value,
          fontColor: AppColors.black900,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ],
    );
  }

  Widget _buildDivider(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Container(
      height: size.height / (size.height / 25),
      width: size.width / (size.width / 1.5),
      color: Colors.black,
    );
  }
}
