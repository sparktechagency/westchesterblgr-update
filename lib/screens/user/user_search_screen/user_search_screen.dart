import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:itzel/screens/user/user_search_screen/widgets/search_text_field_widget.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_strings.dart';
import '../../../routes/app_routes.dart';
import '../../../widgets/app_image/app_image.dart';
import '../../../widgets/space_widget/space_widget.dart';
import '../../../widgets/text_button_widget/text_button_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';
import '../user_all_category_screen/controller/user_all_category_controller.dart';

class UserSearchScreen extends StatefulWidget {
  UserSearchScreen({super.key});

  @override
  State<UserSearchScreen> createState() => _UserSearchScreenState();
}

class _UserSearchScreenState extends State<UserSearchScreen> {
  final UserAllCategoryController _controller =
      Get.put(UserAllCategoryController());

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  final TextEditingController searchController = TextEditingController();
  final List<bool> isSavedList = List.generate(5, (index) => false);
  final List<String> categoryImages = [
    'assets/images/schoolImage.png',
    'assets/images/medicalImage.png',
    'assets/images/fitnessImage.png',
    'assets/images/restaurentImage.png',
    'assets/images/travelImage.png',
  ];
  final List<String> categoryTitles = [
    'Education',
    'Health',
    'Spa/Beauty',
    'Restaurant',
    'Travel',
  ];
  final List<String> jobType = [
    'Part-time',
    'Senior-Level',
  ];

  void toggleSaveState(int index) {
    setState(() {
      isSavedList[index] = !isSavedList[index];
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: AppColors.whiteBg,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SpaceWidget(spaceHeight: 16),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width / (size.width / 20)),
              child: SearchTextFieldWidget(
                hintText: 'Search',
                controller: searchController,
                maxLines: 1,
              ),
            ),
            const SpaceWidget(spaceHeight: 12),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width / (size.width / 20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TextWidget(
                    text: AppStrings.categories,
                    fontColor: AppColors.black500,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  TextButtonWidget(
                    onPressed: () {
                      Get.toNamed(AppRoutes.userAllCategoryScreen);
                    },
                    text: AppStrings.seeAll,
                    textColor: AppColors.blueLight,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.blueLight,
                  ),
                ],
              ),
            ),
            const SpaceWidget(spaceHeight: 8),
            Obx(() {
              if (_controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      const SpaceWidget(spaceWidth: 20),
                      ...List.generate(
                        _controller.categories.length > 5
                            ? 5
                            : _controller.categories.length,
                        (index) {
                          final category = _controller.categories[index];
                          return Padding(
                            padding: EdgeInsets.only(
                                right: size.width / (size.width / 12)),
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: AppImage(
                                    url: category.image,
                                    height: size.width / (size.width / 70),
                                    width: size.width / (size.width / 70),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SpaceWidget(spaceHeight: 4),
                                TextWidget(
                                  text: capitalize(category.name),
                                  fontColor: AppColors.black500,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      const SpaceWidget(spaceWidth: 8),
                    ],
                  ),
                );
              }
            }),
            const SpaceWidget(spaceHeight: 8),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width / (size.width / 20)),
              child: const TextWidget(
                text: 'Recent Job Post',
                fontColor: AppColors.black500,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SpaceWidget(spaceHeight: 8),
            ...List.generate(5, (index) {
              return Container(
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        InkWell(
                          onTap: () => toggleSaveState(index),
                          borderRadius: BorderRadius.circular(4),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width / (size.width / 9),
                                vertical: size.width / (size.width / 4)),
                            margin: EdgeInsets.only(
                                right: size.width / (size.width / 4)),
                            decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: AppColors.black500,
                                    width: size.width / (size.width / 1))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TextWidget(
                                  text: isSavedList[index] ? 'Saved' : 'Save',
                                  fontColor: AppColors.black500,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                                Icon(
                                  isSavedList[index]
                                      ? Icons.bookmark
                                      : Icons.bookmark_border,
                                  color: AppColors.black500,
                                  size: 14,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
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
              );
            }),
            const SpaceWidget(spaceHeight: 80),
          ],
        ),
      ),
    );
  }
}
