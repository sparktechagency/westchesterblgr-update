import 'package:get/get.dart';

import '../../../../models/get_event_status_model.dart';
import '../../../../services/repository/event_repository/event_repository.dart';
import '../../../../utils/app_all_log/error_log.dart';

class CreatorDashboardController extends GetxController {
  final EventRepository _eventRepository = EventRepository();
  var eventStatus = EventStatus(
    id: '',
    thumbnailImage: '',
    introMedia: '',
    name: '',
    time: DateTime.now(),
    description: '',
    tags: [],
    price: 0,
    creator: '',
    address: '',
    coordinate: [],
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    v: 0,
    totalEarning: 0,
    ticketSold: 0,
  ).obs;

  @override
  void onInit() {
    super.onInit();
    fetchEventStatus();
  }

  Future<void> fetchEventStatus() async {
    try {
      final status = await _eventRepository.getEventStatus();
      if (status != null) {
        eventStatus.value = status;
      }
    } catch (e) {
      errorLog("Error in fetchEventStatus", e);
    }
  }
}
