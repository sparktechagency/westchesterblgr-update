import 'package:flutter/material.dart';
import 'package:itzel/widgets/appbar_widget/appbar_widget.dart';
import 'package:itzel/widgets/space_widget/space_widget.dart';
import 'package:itzel/widgets/text_button_widget/text_button_widget.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../constants/app_colors.dart';
import '../../../widgets/text_widget/text_widgets.dart';

class UserCalenderScreen extends StatefulWidget {
  const UserCalenderScreen({super.key});

  @override
  _UserCalenderScreenState createState() => _UserCalenderScreenState();
}

class _UserCalenderScreenState extends State<UserCalenderScreen> {
  DateTime _focusedDate = DateTime.now();
  DateTime? _selectedDate;
  CalendarFormat _calendarFormat = CalendarFormat.week;

  void _toggleCalendarFormat() {
    setState(() {
      _calendarFormat = _calendarFormat == CalendarFormat.week
          ? CalendarFormat.month
          : CalendarFormat.week;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteBg,
      appBar: const AppbarWidget(
        text: 'Events',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDate,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDate, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDate = selectedDay;
                  _focusedDate = focusedDay;
                });
              },
              calendarStyle: const CalendarStyle(
                selectedDecoration: BoxDecoration(
                  color: AppColors.starIcon,
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: AppColors.blue500,
                  shape: BoxShape.circle,
                ),
              ),
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
            ),
            const SpaceWidget(spaceHeight: 8),
            TextButtonWidget(
              onPressed: _toggleCalendarFormat,
              text: (_calendarFormat == CalendarFormat.week
                  ? 'Tap to expand Month'
                  : 'Tap to see Week'),
              fontSize: 13,
              textColor: AppColors.blue500,
              fontWeight: FontWeight.w500,
            ),
            const SpaceWidget(spaceHeight: 16),
            const Divider(
              thickness: 1,
              color: AppColors.grey200,
            ),
            const SpaceWidget(spaceHeight: 16),
            _buildClassItem(
                "4:00 AM", "Adult Lap Pool Swim", "", "Adult Swim", 420),
            _buildClassItem(
                "5:30 AM", "GTX", "Kristen M.", "Signature Group Training", 60),
            _buildClassItem("5:30 AM", "SOL GUIDED VINYASA: Medium Heat",
                "Alessia A.", "Yoga", 60),
            _buildClassItem("5:45 AM", "SHRED", "Loubna A.", "Strength", 45),
          ],
        ),
      ),
    );
  }

  Widget _buildClassItem(
    String time,
    String title,
    String instructor,
    String type,
    int duration,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Time Section
            TextWidget(
              text: time,
              fontColor: AppColors.black500,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            const SpaceWidget(spaceWidth: 16),
            // Class Details Section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    text: type.toUpperCase(),
                    fontColor: AppColors.black300,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                  const SpaceWidget(spaceHeight: 4),
                  TextWidget(
                    text: title,
                    fontColor: AppColors.blue500,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    textAlignment: TextAlign.left,
                  ),
                  if (instructor.isNotEmpty)
                    TextWidget(
                      text: instructor,
                      fontColor: AppColors.black500,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      textAlignment: TextAlign.left,
                    ),
                ],
              ),
            ),
            TextWidget(
              text: "$duration min",
              fontColor: AppColors.black300,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              textAlignment: TextAlign.left,
            ),
          ],
        ),
        const Divider(
          thickness: 1,
          color: AppColors.grey200,
        ),
      ],
    );
  }
}
