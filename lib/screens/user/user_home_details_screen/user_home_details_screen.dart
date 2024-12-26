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

class UserHomeDetailsScreen extends StatefulWidget {
  const UserHomeDetailsScreen({super.key});

  @override
  State<UserHomeDetailsScreen> createState() => _UserHomeDetailsScreenState();
}

class _UserHomeDetailsScreenState extends State<UserHomeDetailsScreen> {
  late VideoPlayerController _videoController;
  bool _isVideoEnded = false;
  bool _isBookmarked = false;
  bool _isExpanded = false;
  bool _isVideoInitialized = false;

  final String _text =
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type speci";

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    )
      ..setLooping(false)
      ..initialize().then((_) {
        setState(() {
          _isVideoInitialized = true;
        });
      });

    _videoController.addListener(() {
      if (_videoController.value.position == _videoController.value.duration) {
        setState(() {
          _isVideoEnded = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  void _toggleBookmark() {
    setState(() {
      _isBookmarked = !_isBookmarked;
    });
  }

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  void _playPauseVideo() {
    if (_isVideoEnded) {
      _videoController.seekTo(Duration.zero);
      _videoController.play();
      setState(() {
        _isVideoEnded = false;
      });
    } else if (_videoController.value.isPlaying) {
      _videoController.pause();
    } else {
      _videoController.play();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    String displayText = _isExpanded ? _text : _text.substring(0, 100) + '...';
    // Return a single screen with GetBuilder
    return GetBuilder<UserHomeDetailsController>(
      init: UserHomeDetailsController(),
      builder: (controller) {


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
                if (_isVideoInitialized)
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      AspectRatio(
                        aspectRatio: _videoController.value.aspectRatio,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: VideoPlayer(_videoController),
                        ),
                      ),
                      GestureDetector(
                        onTap: controller.playPauseVideo,
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.black54,
                          child: Icon(
                            _isVideoEnded
                                ? Icons.replay
                                : _videoController.value.isPlaying
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
                      onPressed: _toggleBookmark,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      style: const ButtonStyle(
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      icon: Icon(
                        _isBookmarked ? Icons.bookmark : Icons.bookmark_border,
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
                TextWidget(
                  text: displayText,
                  fontColor: AppColors.grey800,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  textAlignment: TextAlign.left,
                ),
                InkWell(
                  onTap: _toggleExpansion,
                  child: TextWidget(
                    text: _isExpanded ? 'see less' : 'see more',
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
