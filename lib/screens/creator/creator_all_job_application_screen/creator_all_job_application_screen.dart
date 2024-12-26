import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../widgets/appbar_widget/appbar_widget.dart';
import '../../../widgets/button_widget/button_widget.dart';
import '../../../widgets/space_widget/space_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';
import '../creator_job_details_screen/creator_job_details_screen.dart';

class CreatorAllJobApplicationScreen extends StatelessWidget {
  final List<Map<String, dynamic>> jobApplications = List.generate(
    5,
    (index) => {
      "title": "Assistant Biology Teacher",
      "company": "Saint Marry School",
      "posted": "3 days ago",
      "totalApplicants": 98,
      "applicants": List.generate(
        10,
        (i) => {
          "name": "Bryan Lewis",
          "profileImage": "assets/images/chatProfileImage.png",
        },
      ),
    },
  );

  CreatorAllJobApplicationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: AppColors.whiteBg,
      appBar: const AppbarWidget(text: 'All Job Application'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SpaceWidget(spaceHeight: 10),
            ...jobApplications.map(
              (event) {
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
                                    child: TextWidget(
                                      text: event['title']?.toString() ?? "",
                                      fontColor: AppColors.whiteBg,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      overflow: TextOverflow.ellipsis,
                                      textAlignment: TextAlign.left,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      TextWidget(
                                        text:
                                            event['company']?.toString() ?? "",
                                        fontColor: AppColors.grey50,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        overflow: TextOverflow.ellipsis,
                                        textAlignment: TextAlign.left,
                                      ),
                                      const SpaceWidget(spaceWidth: 4),
                                      TextWidget(
                                        text: event['posted']?.toString() ?? "",
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 7),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Center(
                          child: TextWidget(
                            text:
                                'Total Applicant - ${event['totalApplicants']}',
                            fontColor: AppColors.black500,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SpaceWidget(spaceHeight: 10),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 7),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Column(
                          children: [
                            const SpaceWidget(spaceHeight: 10),
                            ...event['applicants']?.map<Widget>(
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
                                              applicant['profileImage'],
                                              height: size.width /
                                                  (size.width / 25),
                                              width: size.width /
                                                  (size.width / 25),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          const SpaceWidget(spaceWidth: 8),
                                          TextWidget(
                                            text: applicant['name'] ?? "",
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
                                        buttonWidth:
                                            size.width / (size.width / 79),
                                        buttonHeight:
                                            size.width / (size.width / 26),
                                        fontSize:
                                            size.width / (size.width / 12),
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
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
