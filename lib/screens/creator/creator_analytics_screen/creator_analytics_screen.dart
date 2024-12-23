import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itzel/screens/creator/creator_analytics_screen/widgets/analytics_box_widget.dart';

import '../../../constants/app_colors.dart';
import '../../../utils/app_size.dart';
import '../../../widgets/space_widget/space_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';
import 'controllers/creator_analytics_controller.dart';

class CreatorAnalyticsScreen extends StatelessWidget {
  const CreatorAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ResponsiveUtils.initialize(context);
    return Scaffold(
      backgroundColor: AppColors.whiteBg,
      body: GetBuilder<CreatorAnalyticsController>(
          init: CreatorAnalyticsController(),
          builder: (controller) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TextWidget(
                        text: 'Analytics',
                        fontColor: AppColors.black600,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.blue, // Background color
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: DropdownButton<String>(
                          //itemHeight: 50,
                          //menuMaxHeight:50 ,
                          //isDense: true,
                          value: controller.selectedValue,
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.white,
                            size: 20,
                          ),
                          iconSize: 24,
                          underline:
                              const SizedBox(), // Remove default underline
                          dropdownColor: Colors.blue, // Dropdown menu color
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                          items: controller.dropdownItems
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: controller.updateSelectedValue,
                        ),
                      )
                    ],
                  ),
                  const SpaceWidget(spaceHeight: 16),
                  const Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: AnalyticsBoxWidget(
                          title: 'Ticket Sold',
                          count: '236',
                        ),
                      ),
                      SpaceWidget(spaceWidth: 8),
                      Expanded(
                        flex: 1,
                        child: AnalyticsBoxWidget(
                          title: 'Total Event',
                          count: '87',
                        ),
                      ),
                      SpaceWidget(spaceWidth: 8),
                      Expanded(
                        flex: 1,
                        child: AnalyticsBoxWidget(
                          title: 'Participated',
                          count: '48',
                        ),
                      ),
                    ],
                  ),
                  const SpaceWidget(spaceHeight: 24),
                  Container(
                    width: double.infinity,
                    height: ResponsiveUtils.height(300),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Column(
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextWidget(
                              text: 'Sales Report',
                              fontColor: AppColors.black500,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                            TextWidget(
                              text: '2023-2024',
                              fontColor: AppColors.black300,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                        const SpaceWidget(spaceHeight: 22),
                        const Row(
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 5,
                                  backgroundColor: AppColors.yellow,
                                ),
                                SpaceWidget(spaceWidth: 2),
                                TextWidget(
                                  text: 'Engagement',
                                  fontColor: AppColors.black300,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ],
                            ),
                            SpaceWidget(spaceWidth: 16),
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 5,
                                  backgroundColor: AppColors.purple,
                                ),
                                SpaceWidget(spaceWidth: 2),
                                TextWidget(
                                  text: 'Online Sales',
                                  fontColor: AppColors.black300,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SpaceWidget(spaceHeight: 22),
                        Expanded(
                          child: BarChart(
                            BarChartData(
                              maxY: 30,
                              barTouchData: BarTouchData(
                                touchTooltipData: BarTouchTooltipData(
                                  getTooltipColor: ((group) {
                                    return Colors.grey;
                                  }),
                                  getTooltipItem: (a, b, c, d) => null,
                                ),
                                touchCallback: controller.updateTouchedGroup,
                              ),
                              titlesData: FlTitlesData(
                                show: true,
                                rightTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                topTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    getTitlesWidget: controller.bottomTitles,
                                    reservedSize: 42,
                                  ),
                                ),
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    reservedSize: 28,
                                    interval: 1,
                                    getTitlesWidget: controller.leftTitles,
                                  ),
                                ),
                              ),
                              borderData: FlBorderData(
                                show: false,
                              ),
                              barGroups: controller.showingBarGroups,
                              gridData: const FlGridData(show: false),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SpaceWidget(spaceHeight: 100),
                ],
              ),
            );
          }),
    );
  }
}
