import 'package:flutter/material.dart';
import 'package:itzel/screens/user/user_map_screen/widgets/map_appbar_widget.dart';

import '../../../constants/app_colors.dart';

class UserMapScreen extends StatelessWidget {
  const UserMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: AppColors.whiteBg,
      appBar: const MapAppBarWidget(
        titleText: 'Summer Exotic DJ Party',
        subTitleText: 'Address : 32 St. Block A, Western Park',
      ),
      body: Image.asset(
        'assets/images/mapImage.png',
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}
