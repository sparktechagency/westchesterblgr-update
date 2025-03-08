import 'package:get/get.dart';
import 'package:itzel/models/event_model.dart';
import 'package:itzel/services/repository/event_repository/event_repository.dart';

class UserHomeController extends GetxController {
  final EventRepository _eventRepository = EventRepository();
  final RxList<EventModel> events = <EventModel>[].obs;
  final RxBool isLoading = true.obs;
  final RxString error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchEvents();
  }

  Future<void> fetchEvents() async {
    try {
      isLoading(true);
      error('');
      final fetchedEvents = await _eventRepository.getAllEvents();

      if (fetchedEvents != null) {
        events.assignAll(fetchedEvents);
      } else {
        error('No events found');
      }
    } catch (e) {
      error('Failed to load events: ${e.toString()}');
      print('Error fetching events: $e');
    } finally {
      isLoading(false);
    }
  }
}
