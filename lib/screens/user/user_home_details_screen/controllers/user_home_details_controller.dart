import 'package:get/get.dart';
import 'package:itzel/models/event_model.dart';
import 'package:itzel/services/repository/event_repository/event_repository.dart';
import 'package:video_player/video_player.dart';

import '../../../../constants/app_api_url.dart';
import '../../../../services/repository/profile_repository/profile_repository.dart';
import '../../../../utils/app_all_log/error_log.dart';

class UserHomeDetailsController extends GetxController {
  final EventRepository _eventRepository = EventRepository();
  final ProfileRepository _profileRepository = ProfileRepository();
  VideoPlayerController? _controller;
  bool isVideoEnded = false;
  bool isBookmarked = false;
  bool isExpanded = false;
  bool isVideoInitialized = false;
  bool hasVideoError = false;
  EventModel? event;

  @override
  void onInit() {
    super.onInit();
    String eventId = Get.arguments['id'] ?? '';
    if (eventId.isNotEmpty) {
      fetchEventDetails(eventId);
      checkIfBookmarked(eventId);
    } else {
      errorLog("No event ID provided", "EventID is empty");
    }
  }

  @override
  void onClose() {
    _controller?.dispose();
    super.onClose();
  }

  Future<void> initializeVideoPlayer(String videoUrl) async {
    try {
      _controller = VideoPlayerController.network(videoUrl);

      await _controller!.initialize();

      _controller!.addListener(() {
        if (_controller!.value.position >= _controller!.value.duration) {
          isVideoEnded = true;
          update();
        }
      });

      isVideoInitialized = true;
      hasVideoError = false;
      update();
    } catch (e) {
      hasVideoError = true;
      errorLog("Error initializing video player", e);
      print('Error initializing video player: $e');
      update();
    }
  }

  void fetchEventDetails(String id) async {
    try {
      event = await _eventRepository.getEventById(id);
      if (event != null && event!.introMedia.isNotEmpty) {
        // Check if the URL already contains the domain
        String videoUrl = event!.introMedia.startsWith('http')
            ? event!.introMedia
            : '${AppApiUrl.domain}/${event!.introMedia}';

        print('Video URL: $videoUrl'); // Debug log
        await initializeVideoPlayer(videoUrl);
      } else {
        errorLog("Event or video URL is null", "No video available");
      }
      update();
    } catch (e) {
      errorLog("Error fetching event details", e);
      print('Error fetching event details: $e');
    }
  }

  void checkIfBookmarked(String eventId) async {
    try {
      final profile = await _profileRepository.fetchProfile();
      if (profile != null) {
        isBookmarked =
            profile.eventWishList.any((event) => event.id == eventId);
        update();
      }
    } catch (e) {
      errorLog("Error checking if event is bookmarked", e);
    }
  }

  void toggleBookmark(String eventId) async {
    try {
      bool success;
      if (isBookmarked) {
        success = await _eventRepository.removeFromWishlist(eventId);
      } else {
        success = await _eventRepository.addToWishlist(eventId);
      }
      if (success) {
        isBookmarked = !isBookmarked;
        update();
      } else {
        // Handle error (e.g., show a snackbar)
      }
    } catch (e) {
      errorLog("Error toggling bookmark", e);
    }
  }

  void toggleExpansion() {
    isExpanded = !isExpanded;
    update();
  }

  void playPauseVideo() {
    if (_controller == null || !isVideoInitialized) return;

    if (isVideoEnded) {
      _controller!.seekTo(Duration.zero);
      _controller!.play();
      isVideoEnded = false;
    } else if (_controller!.value.isPlaying) {
      _controller!.pause();
    } else {
      _controller!.play();
    }
    update();
  }

  VideoPlayerController get controller => _controller!;

  bool get isVideoPlaying => _controller?.value.isPlaying ?? false;
}
