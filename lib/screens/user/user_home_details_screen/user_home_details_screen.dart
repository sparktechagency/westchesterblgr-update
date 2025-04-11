import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itzel/routes/app_routes.dart';
import 'package:itzel/screens/user/user_home_details_screen/widgets/fill_button_widget.dart';
import 'package:itzel/screens/user/user_home_details_screen/widgets/stroke_button_widget.dart';
import 'package:video_player/video_player.dart';

import '../../../constants/app_colors.dart';
import '../../../widgets/appbar_widget/appbar_widget.dart';
import '../../../widgets/space_widget/space_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';
import 'controllers/user_home_details_controller.dart';

class UserHomeDetailsScreen extends StatelessWidget {
  final UserHomeDetailsController controller =
      Get.put(UserHomeDetailsController());

  UserHomeDetailsScreen({super.key});

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  String capitalize(String s) =>
      s.isNotEmpty ? s[0].toUpperCase() + s.substring(1) : '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: AppColors.whiteBg,
      appBar: const AppbarWidget(text: 'Back'),
      body: GetBuilder<UserHomeDetailsController>(
        builder: (controller) {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else if (controller.event == null) {
            return const Center(child: Text('Event not found.'));
          } else {
            String displayText = controller.isExpanded
                ? controller.event!.description ?? ''
                : (controller.event!.description?.length ?? 0) > 200
                    ? '${controller.event!.description!.substring(0, 200)}...'
                    : controller.event!.description ?? '';

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
                          child: VideoPlayer(controller.controller),
                        ),
                        if (!controller.isVideoPlaying)
                          GestureDetector(
                            onTap: controller.playPauseVideo,
                            child: Container(
                              color: Colors.black.withOpacity(0.5),
                              child: const Icon(
                                Icons.play_arrow,
                                color: Colors.white,
                                size: 50,
                              ),
                            ),
                          ),
                      ],
                    ),
                  const SpaceWidget(spaceHeight: 16),
                  TextWidget(
                    text: controller.event?.name ?? '',
                    fontColor: AppColors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
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
                    onPressed: () {
                      controller.makePayment(
                        eventId: controller.event?.id ?? '',
                        amount: controller.event?.price ?? 0,
                      );
                    },
                    label: 'Buy Ticket',
                    buttonWidth: double.infinity,
                    buttonHeight: 56,
                    buttonRadius: BorderRadius.circular(16),
                  ),
                  const SpaceWidget(spaceHeight: 12),
                  StrokeButtonWidget(
                    onPressed: () {
                      Get.toNamed(
                        AppRoutes.userMapScreen,
                        arguments: {
                          'name': controller.event?.name ?? '',
                          'coordinate': controller.event?.coordinate,
                        },
                      );
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
