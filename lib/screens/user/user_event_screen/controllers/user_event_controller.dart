import 'package:get/get.dart';

class UserEventController extends GetxController {
  // Making variables observable
  var types = ['Party', 'Night concert', 'DJ Music'].obs;
  var ticketPrice = 9.32.obs;
  var eventName =
      'Electro Music Festival - Valleria night with DJ Hardwell'.obs;

  void updateTicketPrice(double newPrice) {
    ticketPrice.value = newPrice; // Use .value to update the observable
  }

  void updateEventName(String newName) {
    eventName.value = newName; // Use .value to update the observable
  }
}
