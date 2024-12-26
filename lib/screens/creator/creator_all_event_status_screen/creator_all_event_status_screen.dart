import 'package:flutter/material.dart';
import 'package:itzel/screens/creator/creator_all_event_status_screen/widgets/divider_widget.dart';
import 'package:itzel/screens/creator/creator_all_event_status_screen/widgets/event_card_widget.dart';
import 'package:itzel/screens/creator/creator_all_event_status_screen/widgets/state_item_widget.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_icons_path.dart';
import '../../../widgets/appbar_widget/appbar_widget.dart';
import '../../../widgets/icon_button_widget/icon_button_widget.dart';
import '../../../widgets/space_widget/space_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';

class CreatorAllEventStatusScreen extends StatelessWidget {
  final List<Map<String, String>> eventStatusList = List.generate(
    10,
    (index) => {
      "title": "Electro Music Festival - Valleria night with DJ Hardwell",
      "totalEarnings": "\$6.32",
      "totalViews": "20",
      "ticketsSold": "85",
    },
  );

  CreatorAllEventStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
        backgroundColor: AppColors.whiteBg,
        appBar: const AppbarWidget(text: 'All Event Status'),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SpaceWidget(spaceHeight: 10),
              ...eventStatusList.map(
                (event) {
                  return EventCardWidget(
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
                                    width: size.width / (size.width / 71),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SpaceWidget(spaceWidth: 8),
                                SizedBox(
                                  width: size.width / (size.width / 180),
                                  child: TextWidget(
                                    text: event["title"] ?? "",
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
                                  child: StatItemWidget(
                                    title: 'Total Earning',
                                    value: event["totalEarnings"] ?? "",
                                  )),
                              const SpaceWidget(spaceWidth: 2),
                              DividerWidget(
                                height: size.height / (size.height / 25),
                                width: size.width / (size.width / 1.5),
                              ),
                              const SpaceWidget(spaceWidth: 2),
                              Expanded(
                                  flex: 1,
                                  child: StatItemWidget(
                                    title: 'Total Views',
                                    value: event["totalViews"] ?? "",
                                  )),
                              const SpaceWidget(spaceWidth: 2),
                              DividerWidget(
                                height: size.height / (size.height / 25),
                                width: size.width / (size.width / 1.5),
                              ),
                              const SpaceWidget(spaceWidth: 2),
                              Expanded(
                                  flex: 1,
                                  child: StatItemWidget(
                                    title: 'Tickets Sold',
                                    value: event["ticketsSold"] ?? "",
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ).toList(),
            ],
          ),
        ));
  }
}
