import 'package:get/get.dart';

class UserEventController extends GetxController {
  List<String> types = ['Party', 'Night concert', 'DJ Music'];
  double ticketPrice = 9.32;
  String eventName = 'Electro Music Festival - Valleria night with DJ Hardwell';

  void updateTicketPrice(double newPrice) {
    ticketPrice = newPrice;
    update(); // Notify listeners
  }

  void updateEventName(String newName) {
    eventName = newName;
    update(); // Notify listeners
  }
}
