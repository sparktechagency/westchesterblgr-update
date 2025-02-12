import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itzel/screens/user/user_home_details_screen/widgets/fill_button_widget.dart';
import 'package:itzel/screens/user/user_home_details_screen/widgets/stroke_button_widget.dart';
import 'package:video_player/video_player.dart';

import '../../../constants/app_colors.dart';
import '../../../models/event_model.dart';
import '../../../routes/app_routes.dart';
import '../../../widgets/appbar_widget/appbar_widget.dart';
import '../../../widgets/space_widget/space_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';
import '../user_account_screen/controllers/user_account_controller.dart';
import 'controllers/user_home_details_controller.dart';

class UserHomeDetailsScreen extends StatelessWidget {
  final UserHomeDetailsController controller =
      Get.put(UserHomeDetailsController());
  final UserAccountController userAccountController =
      Get.put(UserAccountController());

  UserHomeDetailsScreen({super.key});

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: AppColors.whiteBg,
      appBar: const AppbarWidget(text: 'Back'),
      body: GetBuilder<UserHomeDetailsController>(
        builder: (controller) {
          if (controller.event == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            String displayText = controller.isExpanded
                ? controller.event!.description
                : '${controller.event!.description.substring(0, 200)}...';
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width / (size.width / 20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (controller.isVideoInitialized)
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        AspectRatio(
                          aspectRatio: controller.controller.value.aspectRatio,
                          child: Stack(
                            children: [
                              // Video Player
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: VideoPlayer(controller.controller),
                              ),

                              // Semi-transparent overlay when paused
                              if (!controller.isVideoPlaying)
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),

                              // Progress bar at bottom
                              Positioned(
                                left: 0,
                                right: 0,
                                bottom: 0,
                                child: VideoProgressIndicator(
                                  controller.controller,
                                  allowScrubbing: true,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 12),
                                  colors: VideoProgressColors(
                                    playedColor: AppColors.blueLight,
                                    bufferedColor:
                                        Colors.white.withOpacity(0.5),
                                    backgroundColor:
                                        Colors.white.withOpacity(0.2),
                                  ),
                                ),
                              ),

                              // Play/Pause/Replay button
                              Center(
                                child: GestureDetector(
                                  onTap: controller.playPauseVideo,
                                  child: Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.6),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      controller.isVideoEnded
                                          ? Icons.replay
                                          : controller.isVideoPlaying
                                              ? Icons.pause
                                              : Icons.play_arrow,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),

                              // Duration indicators
                              Positioned(
                                left: 12,
                                bottom: 24,
                                child: ValueListenableBuilder<VideoPlayerValue>(
                                  valueListenable: controller.controller,
                                  builder: (context, value, child) {
                                    return Text(
                                      _formatDuration(value.position),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    );
                                  },
                                ),
                              ),

                              Positioned(
                                right: 12,
                                bottom: 24,
                                child: Text(
                                  _formatDuration(
                                      controller.controller.value.duration),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
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
                        child: TextWidget(
                          text: controller.event?.name ?? '',
                          fontColor: AppColors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          overflow: TextOverflow.ellipsis,
                          textAlignment: TextAlign.start,
                        ),
                      ),
                      IconButton(
                        onPressed: () => controller
                            .toggleBookmark(controller.event?.id ?? ''),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        style: const ButtonStyle(
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        icon: Icon(
                          controller.isBookmarked
                              ? Icons.bookmark
                              : Icons.bookmark_border,
                          color: AppColors.black,
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                    ],
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
                      final location = controller.event?.location;
                      if (location is LocationClass) {
                        Get.toNamed(
                          AppRoutes.userMapScreen,
                          arguments: {
                            'name': controller.event?.name ?? '',
                            'coordinate': location.coordinate,
                          },
                        );
                      } else if (location is String) {
                        Get.toNamed(
                          AppRoutes.userMapScreen,
                          arguments: {
                            'name': controller.event?.name ?? '',
                            'coordinate': [0.0, 0.0],
                          },
                        );
                      }
                    },
                    label: 'See Location',
                    buttonWidth: double.infinity,
                    buttonHeight: 56,
                    buttonRadius: BorderRadius.circular(16),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
