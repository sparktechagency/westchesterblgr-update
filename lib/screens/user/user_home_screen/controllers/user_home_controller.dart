import 'package:get/get.dart';
import 'package:itzel/models/event_model.dart';
import 'package:itzel/services/repository/event_repository/event_repository.dart';

import '../../../../utils/app_all_log/error_log.dart';

class UserHomeController extends GetxController {
  final EventRepository _eventRepository = EventRepository();
  var events = <EventModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchEvents();
  }

  void fetchEvents() async {
    try {
      isLoading(true);
      var fetchedEvents = await _eventRepository.getAllEvents();
      if (fetchedEvents != null) {
        events.assignAll(fetchedEvents);
      }
    } catch (e) {
      // Handle or log the error
      errorLog("Error fetching events", e);
      print('Error fetching events: $e');
    } finally {
      isLoading(false);
    }
  }
}
