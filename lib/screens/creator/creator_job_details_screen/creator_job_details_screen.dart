import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../../widgets/appbar_widget/appbar_widget.dart';
import '../../../widgets/space_widget/space_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';

class CreatorJobDetailsScreen extends StatelessWidget {
  const CreatorJobDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: AppColors.whiteBg,
      appBar: const AppbarWidget(text: 'Applicant Details'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.asset(
                  'assets/images/chatProfileImage.png',
                  height: size.width / (size.width / 100),
                  width: size.width / (size.width / 100),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SpaceWidget(spaceHeight: 24),
            const InfoTile(label: "Name:", value: "John Doe"),
            const SpaceWidget(spaceHeight: 4),
            const InfoTile(
                label: "Address:", value: "123 Main Street, Cityville"),
            const SpaceWidget(spaceHeight: 4),
            const InfoTile(label: "Email:", value: "johndoe@example.com"),
            const SpaceWidget(spaceHeight: 4),
            const InfoTile(label: "Phone Number:", value: "+1 234 567 890"),
            const SpaceWidget(spaceHeight: 4),
            const InfoTile(
                label: "Experience:", value: "5 years in software development"),
            const SpaceWidget(spaceHeight: 4),
            const InfoTile(label: "Citizenship:", value: "United States"),
            const SpaceWidget(spaceHeight: 4),
            const InfoTile(label: "High School:", value: "City High School"),
            const SpaceWidget(spaceHeight: 4),
            const InfoTile(label: "Graduated High School Year:", value: "2010"),
            const SpaceWidget(spaceHeight: 4),
            const InfoTile(label: "College:", value: "State University"),
            const SpaceWidget(spaceHeight: 4),
            const InfoTile(label: "Graduated Year:", value: "2014"),
            const SpaceWidget(spaceHeight: 16),
          ],
        ),
      ),
    );
  }
}

class InfoTile extends StatelessWidget {
  final String label;
  final String value;

  const InfoTile({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            text: label,
            fontColor: AppColors.black500,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          const SpaceWidget(spaceHeight: 4),
          TextWidget(
            text: value,
            fontColor: AppColors.black400,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: CreatorJobDetailsScreen(),
  ));
}
