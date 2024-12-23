import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserReviewController extends GetxController {
  TextEditingController searchController = TextEditingController();
  TextEditingController feedbackController = TextEditingController();

  List<String> reviewImages = [
    'assets/images/reviewImage1.png',
    'assets/images/reviewImage2.png',
    'assets/images/reviewImage3.png',
  ];

  List<String> reviewComments = [
    'It was awesome service. Recommended for sure',
    'It was awesome service. Recommended for sure',
    'It was awesome service. Recommended for sure',
  ];

  double rating = 3.0;

  void updateRating(double value) {
    rating = value;
    update(); // Notify GetBuilder of state changes
  }

  void submitReview() {
    print('Rating: $rating');
    print('Feedback: ${feedbackController.text}');
    Get.back();
  }
}
