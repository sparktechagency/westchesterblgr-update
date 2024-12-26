import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:itzel/screens/creator/creator_analytics_screen/widgets/analytics_box_widget.dart';

import '../../../constants/app_colors.dart';
import '../../../utils/app_size.dart';
import '../../../widgets/space_widget/space_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';

class CreatorAnalyticsScreen extends StatefulWidget {
  const CreatorAnalyticsScreen({super.key});

  @override
  State<CreatorAnalyticsScreen> createState() => _CreatorAnalyticsScreenState();
}

class _CreatorAnalyticsScreenState extends State<CreatorAnalyticsScreen> {
  String selectedValue = 'Last 1 month';
  final double width = 7;
  int touchedGroupIndex = -1;

  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;

  final List<String> dropdownItems = [
    'Last 1 month',
    'Last 3 months',
    'Last 6 months',
    'Last year',
  ];

  @override
  void initState() {
    super.initState();
    initializeBarGroups();
  }

  void initializeBarGroups() {
    final barGroup1 = makeGroupData(0, 5, 12);
    final barGroup2 = makeGroupData(1, 16, 12);
    final barGroup3 = makeGroupData(2, 18, 5);
    final barGroup4 = makeGroupData(3, 20, 16);
    final barGroup5 = makeGroupData(4, 17, 6);
    final barGroup6 = makeGroupData(5, 19, 1.5);
    final barGroup7 = makeGroupData(6, 10, 1.5);

    final items = [
      barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
      barGroup5,
      barGroup6,
      barGroup7,
    ];

    rawBarGroups = items;
    showingBarGroups = rawBarGroups;
  }

  void updateSelectedValue(String? newValue) {
    if (newValue != null) {
      setState(() {
        selectedValue = newValue;
      });
    }
  }

  void updateTouchedGroup(FlTouchEvent event, BarTouchResponse? response) {
    if (response == null || response.spot == null) {
      setState(() {
        touchedGroupIndex = -1;
        showingBarGroups = List.of(rawBarGroups);
      });
      return;
    }

    setState(() {
      touchedGroupIndex = response.spot!.touchedBarGroupIndex;

      if (!event.isInterestedForInteractions) {
        touchedGroupIndex = -1;
        showingBarGroups = List.of(rawBarGroups);
        return;
      }

      showingBarGroups = List.of(rawBarGroups);
      if (touchedGroupIndex != -1) {
        var sum = 0.0;
        for (final rod in showingBarGroups[touchedGroupIndex].barRods) {
          sum += rod.toY;
        }
        final avg = sum / showingBarGroups[touchedGroupIndex].barRods.length;

        showingBarGroups[touchedGroupIndex] =
            showingBarGroups[touchedGroupIndex].copyWith(
          barRods: showingBarGroups[touchedGroupIndex].barRods.map((rod) {
            return rod.copyWith(toY: avg, color: Colors.red);
          }).toList(),
        );
      }
    });
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1,
          color: Colors.purple,
          width: width,
        ),
        BarChartRodData(
          toY: y2,
          color: Colors.yellow,
          width: width,
        ),
      ],
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.w400,
      fontSize: 10,
    );
    String text;
    if (value == 0) {
      text = '\$0';
    } else if (value == 10) {
      text = '\$250';
    } else if (value == 19) {
      text = '\$500';
    } else if (value == 29) {
      text = '\$1K';
    } else {
      return Container();
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 0,
      child: Text(text, style: style),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    final titles = <String>['Mn', 'Te', 'Wd', 'Tu', 'Fr', 'St', 'Su'];

    final Widget text = Text(
      titles[value.toInt()],
      style: const TextStyle(
        color: Color(0xff7589a2),
        fontWeight: FontWeight.w400,
        fontSize: 10,
      ),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }

  @override
  Widget build(BuildContext context) {
    ResponsiveUtils.initialize(context);
    return Scaffold(
      backgroundColor: AppColors.whiteBg,
      body: SingleChildScrollView(
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
                    value: selectedValue,
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.white,
                      size: 20,
                    ),
                    iconSize: 24,
                    underline: const SizedBox(),
                    // Remove default underline
                    dropdownColor: Colors.blue,
                    // Dropdown menu color
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                    items: dropdownItems
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: updateSelectedValue,
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
                          touchCallback: updateTouchedGroup,
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
                              getTitlesWidget: bottomTitles,
                              reservedSize: 42,
                            ),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 28,
                              interval: 1,
                              getTitlesWidget: leftTitles,
                            ),
                          ),
                        ),
                        borderData: FlBorderData(
                          show: false,
                        ),
                        barGroups: showingBarGroups,
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
      ),
    );
  }
}
