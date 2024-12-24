import 'package:get/get.dart';

class CreatorAllJobApplicationController extends GetxController {
  // Initialize jobApplications as an RxList of Map
  var jobApplications = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Initial data setup
    jobApplications.addAll(List.generate(
      5,
      (index) => {
        "title": "Assistant Biology Teacher",
        "company": "Saint Marry School",
        "posted": "3 days ago",
        "totalApplicants": 98,
        "applicants": List.generate(
          10,
          (i) => {
            "name": "Bryan Lewis",
            "profileImage": "assets/images/chatProfileImage.png",
          },
        ),
      },
    ));
  }

  @override
  void onClose() {
    // Dispose resources if any
    super.onClose();
  }
}
