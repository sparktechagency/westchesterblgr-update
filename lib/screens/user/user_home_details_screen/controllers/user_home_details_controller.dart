import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:itzel/models/event_model.dart';
import 'package:itzel/services/api/api_post_services.dart';
import 'package:itzel/services/repository/event_repository/event_repository.dart';
import 'package:video_player/video_player.dart';

import '../../../../constants/app_api_url.dart';
import '../../../../services/repository/profile_repository/profile_repository.dart';
import '../../../../utils/app_all_log/error_log.dart';

class UserHomeDetailsController extends GetxController {
  final EventRepository _eventRepository = EventRepository();
  final ProfileRepository _profileRepository = ProfileRepository();
  final ApiPostServices _apiPostServices = ApiPostServices();

  VideoPlayerController? _controller;
  bool isVideoEnded = false;
  bool isBookmarked = false;
  bool isExpanded = false;
  bool isVideoInitialized = false;
  bool hasVideoError = false;
  EventModel? event;
  var isLoading = false.obs;

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

  ///<============================================================================>

  ///========================= Create Payment Intent =========================

  bool paymentLoader = false;

  Future<Map<String, dynamic>?> createPaymentIntent(int amount) async {
    try {
      final ApiPostServices _apiPostServices = ApiPostServices();

      final response = await _apiPostServices.apiPostServices(
        url: '${AppApiUrl.baseUrl}${AppApiUrl.createPaymentIntent}',
        body: {'amount': amount},
      );
      return response;
    } catch (e) {
      errorLog("Error creating payment intent", e);
      return null;
    }
  }

  ///========================= Make Payment =========================
  Future<bool> makePayment({
    required String eventId,
    required int amount,
  }) async {
    try {
      final paymentIntentData = await createPaymentIntent(amount);
      if (paymentIntentData == null) {
        debugPrint("Failed to create payment intent");
        return false;
      }

      final clientSecret = paymentIntentData["data"]["client_secret"];
      if (clientSecret == null || clientSecret.isEmpty) {
        debugPrint("Missing client secret");
        return false;
      }

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: 'Itzel',
          style: ThemeMode.system,
        ),
      );

      try {
        await Stripe.instance.presentPaymentSheet();
        debugPrint('Payment successful');

        final response = await _apiPostServices.apiPostServices(
          url: '${AppApiUrl.baseUrl}/group/join/',
          body: {
            'event': eventId,
            'transactionId': paymentIntentData["data"]["paymentIntent"],
          },
        );

        if (response != null && response['success'] == true) {
          debugPrint('Payment successfully processed');
          return true;
        } else {
          debugPrint('Failed to process payment on backend');
          return false;
        }
      } catch (e) {
        debugPrint('Error presenting payment sheet: $e');
        return false;
      }
    } catch (e) {
      debugPrint("Error in payment process: $e");
      return false;
    }
  }
}
