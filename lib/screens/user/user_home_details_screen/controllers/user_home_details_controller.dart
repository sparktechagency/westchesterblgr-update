import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class UserHomeDetailsController extends GetxController {
  late VideoPlayerController _controller;
  bool isVideoEnded = false;
  bool isBookmarked = false;
  bool isExpanded = false;
  bool isVideoInitialized = false;

  @override
  void onInit() {
    super.onInit();
    // Initialize video only once
    _controller = VideoPlayerController.network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    )
      ..setLooping(false)
      ..initialize().then((_) {
        isVideoInitialized = true;
        update(); // Notify listeners that video is initialized
      });
  }

  @override
  void onClose() {
    _controller.dispose();
    super.onClose();
  }

  void toggleBookmark() {
    isBookmarked = !isBookmarked;
    update(); // Rebuild UI after bookmark state change
  }

  void toggleExpansion() {
    isExpanded = !isExpanded;
    update(); // Rebuild UI after text expansion state change
  }

  void playPauseVideo() {
    if (isVideoEnded) {
      _controller.seekTo(Duration.zero);
      _controller.play();
      isVideoEnded = false;
    } else if (_controller.value.isPlaying) {
      _controller.pause();
    } else {
      _controller.play();
    }
    update(); // Rebuild UI after play/pause state change
  }

  VideoPlayerController get controller => _controller;
  bool get isVideoPlaying => _controller.value.isPlaying;
}
