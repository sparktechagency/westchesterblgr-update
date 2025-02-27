import 'package:get/get.dart';

// Be explicit about which Welcome class you're using
import '../../../../models/event_schedule_model.dart' as EventSchedule;
import '../../../../services/repository/event_repository/event_repository.dart';
import '../../../../widgets/app_snack_bar/app_snack_bar.dart';

class UserEventController extends GetxController {
  final EventRepository _repository = EventRepository();

  // Specify which Welcome class you're using
  var eventSchedule = Rxn<EventSchedule.Welcome>();
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchEventSchedule();
  }

  Future<void> fetchEventSchedule() async {
    try {
      isLoading(true);
      final EventSchedule.Welcome? schedule =
          await _repository.getEventSchedule();

      if (schedule != null) {
        eventSchedule.value = schedule;
        print('Event schedule fetched successfully: ${schedule.data}');
      } else {
        eventSchedule.value = null;
        AppSnackBar.error('Failed to fetch event schedule');
      }
    } catch (e) {
      print('Controller error: $e');
      eventSchedule.value = null;
      AppSnackBar.error('An error occurred while fetching event schedule');
    } finally {
      isLoading(false);
    }
  }
}
