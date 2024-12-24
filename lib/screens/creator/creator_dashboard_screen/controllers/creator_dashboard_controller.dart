import 'package:get/get.dart';

class CreatorDashboardController extends GetxController {
  String eventStatus =
      'Electro Music Festival - Valleria night with DJ Hardwell';
  int totalEarnings = 632; // Example values
  int totalViews = 20;
  String ticketType = 'Virtual';

  // List of job applicants
  List<Map<String, String>> jobApplicants = [
    {"name": "Itzel Rosengen", "image": "assets/images/chatProfileImage.png"},
    {"name": "John Doe", "image": "assets/images/chatProfileImage.png"},
    {"name": "Jane Smith", "image": "assets/images/chatProfileImage.png"},
    {"name": "Itzel Rosengen", "image": "assets/images/chatProfileImage.png"},
    {"name": "John Doe", "image": "assets/images/chatProfileImage.png"},
    {"name": "Jane Smith", "image": "assets/images/chatProfileImage.png"},
    {"name": "Itzel Rosengen", "image": "assets/images/chatProfileImage.png"},
    {"name": "John Doe", "image": "assets/images/chatProfileImage.png"},
    {"name": "Jane Smith", "image": "assets/images/chatProfileImage.png"},
    {"name": "Itzel Rosengen", "image": "assets/images/chatProfileImage.png"},
    {"name": "John Doe", "image": "assets/images/chatProfileImage.png"},
    {"name": "Jane Smith", "image": "assets/images/chatProfileImage.png"},
  ];

  void updateEventStatus(String newStatus) {
    eventStatus = newStatus;
    update(); // This triggers GetBuilder to rebuild
  }

  void updateStats(int earnings, int views, String ticket) {
    totalEarnings = earnings;
    totalViews = views;
    ticketType = ticket;
    update();
  }

  void updateJobApplicants(List<Map<String, String>> newApplicants) {
    jobApplicants = newApplicants;
    update();
  }

  @override
  void onClose() {
    // Dispose resources if any
    super.onClose();
  }
}
