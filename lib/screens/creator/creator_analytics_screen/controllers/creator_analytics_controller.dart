import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CreatorAnalyticsController extends GetxController {
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
  void onInit() {
    super.onInit();
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
      selectedValue = newValue;
      update();
    }
  }

  void updateTouchedGroup(FlTouchEvent event, BarTouchResponse? response) {
    if (response == null || response.spot == null) {
      touchedGroupIndex = -1;
      showingBarGroups = List.of(rawBarGroups);
      update();
      return;
    }

    touchedGroupIndex = response.spot!.touchedBarGroupIndex;

    if (!event.isInterestedForInteractions) {
      touchedGroupIndex = -1;
      showingBarGroups = List.of(rawBarGroups);
      update();
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
    update();
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
}
