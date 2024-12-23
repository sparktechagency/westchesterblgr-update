import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:itzel/utils/app_size.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_strings.dart';
import '../../../routes/app_routes.dart';
import '../../../widgets/space_widget/space_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';
import 'controllers/user_event_controller.dart';

class UserEventScreen extends StatefulWidget {
  const UserEventScreen({super.key});

  @override
  State<UserEventScreen> createState() => _UserEventScreenState();
}

class _UserEventScreenState extends State<UserEventScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final List<String> type = [
    'Party',
    'Night concert',
    'DJ Music',
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: AppColors.whiteBg,
        body: GetBuilder<UserEventController>(
            init: UserEventController(),
            builder: (controller) {
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
                      tabs: const [
                        Tab(text: AppStrings.upcomingEvent),
                        Tab(text: AppStrings.eventHistory)
                      ],
                      controller: _tabController,
                      indicatorSize: TabBarIndicatorSize.tab,
                    ),
                  ),
                  const SpaceWidget(spaceHeight: 16),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              ...List.generate(5, (index) {
                                return InkWell(
                                  onTap: () {
                                    Get.toNamed(
                                        AppRoutes.userHomeDetailsScreen);
                                  },
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  child: Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.all(
                                      size.width / (size.width / 8),
                                    ),
                                    margin: EdgeInsets.only(
                                        left: size.width / (size.width / 20),
                                        right: size.width / (size.width / 20),
                                        bottom: size.width / (size.width / 12)),
                                    decoration: BoxDecoration(
                                        color: AppColors.white,
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(
                                          color: AppColors.greyLighter,
                                          width:
                                              size.width / (size.width / 0.7),
                                        )),
                                    child: Column(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Image.asset(
                                            'assets/images/homeImage.png',
                                            height: AppSize.height(value: 192),
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        const SpaceWidget(spaceHeight: 6),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                ...controller.types.map((type) {
                                                  return Container(
                                                    padding: EdgeInsets
                                                        .symmetric(
                                                            horizontal: size
                                                                    .width /
                                                                (size.width /
                                                                    7),
                                                            vertical: size
                                                                    .width /
                                                                (size.width /
                                                                    4)),
                                                    margin: EdgeInsets.only(
                                                        right: size.width /
                                                            (size.width / 4)),
                                                    decoration: BoxDecoration(
                                                      color: AppColors.blue50,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                    ),
                                                    child: TextWidget(
                                                      text: type,
                                                      fontColor:
                                                          AppColors.black,
                                                      fontSize: 8,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  );
                                                }).toList(),
                                              ],
                                            ),
                                            const TextWidget(
                                              text: '\$9.32',
                                              fontColor: AppColors.black500,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ],
                                        ),
                                        const SpaceWidget(spaceHeight: 8),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: AppSize.width(value: 200),
                                              child: const TextWidget(
                                                text:
                                                    'Electro Music Festival - Valleria night with DJ Hardwell',
                                                fontColor: AppColors.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                textAlignment: TextAlign.start,
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {},
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: size.width /
                                                        (size.width / 9),
                                                    vertical: size.width /
                                                        (size.width / 4)),
                                                margin: EdgeInsets.only(
                                                    right: size.width /
                                                        (size.width / 4)),
                                                decoration: BoxDecoration(
                                                  color: AppColors.blueNormal,
                                                  borderRadius:
                                                      BorderRadius.circular(4),
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
                            ],
                          ),
                        ),
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              ...List.generate(5, (index) {
                                return InkWell(
                                  onTap: () {
                                    Get.toNamed(
                                        AppRoutes.userHomeDetailsScreen);
                                  },
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  child: Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.all(
                                        size.width / (size.width / 8)),
                                    margin: EdgeInsets.only(
                                      left: size.width / (size.width / 20),
                                      right: size.width / (size.width / 20),
                                      bottom: size.width / (size.width / 12),
                                    ),
                                    decoration: BoxDecoration(
                                        color: AppColors.white,
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(
                                          color: AppColors.greyLighter,
                                          width:
                                              size.width / (size.width / 0.7),
                                        )),
                                    child: Column(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Image.asset(
                                            'assets/images/homeImage.png',
                                            height:
                                                size.width / (size.width / 192),
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        const SpaceWidget(spaceHeight: 6),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                ...controller.types.map((type) {
                                                  return Container(
                                                    padding: EdgeInsets
                                                        .symmetric(
                                                            horizontal: size
                                                                    .width /
                                                                (size.width /
                                                                    7),
                                                            vertical: size
                                                                    .width /
                                                                (size.width /
                                                                    4)),
                                                    margin: EdgeInsets.only(
                                                        right: size.width /
                                                            (size.width / 4)),
                                                    decoration: BoxDecoration(
                                                      color: AppColors.blue50,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                    ),
                                                    child: TextWidget(
                                                      text: type,
                                                      fontColor:
                                                          AppColors.black,
                                                      fontSize: 8,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  );
                                                }).toList(),
                                              ],
                                            ),
                                            const TextWidget(
                                              text: '\$9.32',
                                              fontColor: AppColors.black500,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ],
                                        ),
                                        const SpaceWidget(spaceHeight: 8),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: size.width /
                                                  (size.width / 200),
                                              child: const TextWidget(
                                                text:
                                                    'Electro Music Festival - Valleria night with DJ Hardwell',
                                                fontColor: AppColors.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                textAlignment: TextAlign.start,
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {},
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: size.width /
                                                        (size.width / 9),
                                                    vertical: size.width /
                                                        (size.width / 4)),
                                                margin: EdgeInsets.only(
                                                    right: size.width /
                                                        (size.width / 4)),
                                                decoration: BoxDecoration(
                                                  color: AppColors.blueNormal,
                                                  borderRadius:
                                                      BorderRadius.circular(4),
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
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SpaceWidget(spaceHeight: 80),
                ],
              );
            }),
      ),
    );
  }
}
