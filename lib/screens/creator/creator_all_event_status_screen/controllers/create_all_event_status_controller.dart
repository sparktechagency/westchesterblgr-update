import 'package:get/get.dart';

import '../../../../models/get_event_status_model.dart';
import '../../../../services/repository/event_repository/event_repository.dart';
import '../../../../utils/app_all_log/error_log.dart';

class CreatorAllEventStatusController extends GetxController {
  final EventRepository _eventRepository = EventRepository();
  var allEventStatus = <EventStatus>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllEventStatus();
  }

  Future<void> fetchAllEventStatus() async {
    try {
      final statusList = await _eventRepository.getAllEventStatus();
      if (statusList != null) {
        allEventStatus.value = statusList;
      }
    } catch (e) {
      errorLog("Error in fetchAllEventStatus", e);
    }
  }
}
