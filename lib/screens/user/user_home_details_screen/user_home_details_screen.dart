import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itzel/screens/user/user_home_details_screen/widgets/fill_button_widget.dart';
import 'package:itzel/screens/user/user_home_details_screen/widgets/stroke_button_widget.dart';
import 'package:video_player/video_player.dart';

import '../../../constants/app_colors.dart';
import '../../../routes/app_routes.dart';
import '../../../widgets/appbar_widget/appbar_widget.dart';
import '../../../widgets/space_widget/space_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';
import 'controllers/user_home_details_controller.dart';

class UserHomeDetailsScreen extends StatelessWidget {
  const UserHomeDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    String text =
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type speci";

    // Return a single screen with GetBuilder
    return GetBuilder<UserHomeDetailsController>(
      init: UserHomeDetailsController(),
      builder: (controller) {
        String displayText =
            controller.isExpanded ? text : text.substring(0, 100) + '...';

        return Scaffold(
          backgroundColor: AppColors.whiteBg,
          appBar: const AppbarWidget(text: 'Back'),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
                horizontal: size.width / (size.width / 20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Video player only initialized once
                if (controller.isVideoInitialized)
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      AspectRatio(
                        aspectRatio: controller.controller.value.aspectRatio,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: VideoPlayer(controller.controller),
                        ),
                      ),
                      GestureDetector(
                        onTap: controller.playPauseVideo,
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.black54,
                          child: Icon(
                            controller.isVideoEnded
                                ? Icons.replay
                                : controller.controller.value.isPlaying
                                    ? Icons.pause
                                    : Icons.play_arrow,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                const SpaceWidget(spaceHeight: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: size.width / (size.width / 300),
                      child: const TextWidget(
                        text: 'Electro Music Festival - DJ Hardwell',
                        fontColor: AppColors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                      onPressed: controller.toggleBookmark,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      style: const ButtonStyle(
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      icon: Icon(
                        controller.isBookmarked
                            ? Icons.bookmark
                            : Icons.bookmark_border,
                        color: controller.isBookmarked
                            ? AppColors.black
                            : AppColors.black,
                      ),
                    )
                  ],
                ),
                const SpaceWidget(spaceHeight: 12),
                const TextWidget(
                  text: 'Description',
                  fontColor: AppColors.black900,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                const SpaceWidget(spaceHeight: 2),
                TextWidget(
                  text: displayText,
                  fontColor: AppColors.grey800,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  textAlignment: TextAlign.left,
                ),
                InkWell(
                  onTap: controller.toggleExpansion,
                  child: TextWidget(
                    text: controller.isExpanded ? 'see less' : 'see more',
                    fontColor: AppColors.blueLight,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    textAlignment: TextAlign.left,
                  ),
                ),
                const SpaceWidget(spaceHeight: 32),
                FillButtonWidget(
                  onPressed: () {},
                  label: 'Buy Ticket',
                  buttonWidth: double.infinity,
                  buttonHeight: 56,
                  buttonRadius: BorderRadius.circular(16),
                ),
                const SpaceWidget(spaceHeight: 12),
                StrokeButtonWidget(
                  onPressed: () {
                    Get.toNamed(AppRoutes.userMapScreen);
                  },
                  label: 'See Location',
                  buttonWidth: double.infinity,
                  buttonHeight: 56,
                  buttonRadius: BorderRadius.circular(16),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
