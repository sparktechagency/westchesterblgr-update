import 'package:get/get.dart';

class CreatorAllEventStatusController extends GetxController {
  List<Map<String, String>> eventStatusList = List.generate(
    10,
    (index) => {
      "title": "Electro Music Festival - Valleria night with DJ Hardwell",
      "totalEarnings": "\$6.32",
      "totalViews": "20",
      "ticketsSold": "85",
    },
  );

  // Function to update data, if needed
  void updateEventStatusList(List<Map<String, String>> newList) {
    eventStatusList = newList;
    update(); // Notify listeners
  }
}
