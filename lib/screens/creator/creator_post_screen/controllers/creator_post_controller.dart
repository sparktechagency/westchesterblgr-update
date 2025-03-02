import 'package:get/get.dart';

import '../../../../models/get_event_status_model.dart';
import '../../../../models/get_job_status_model.dart';
import '../../../../services/repository/creator_status_repository/creator_status_repository.dart';

class CreatorPostController extends GetxController {
  final CreatorStatusRepository _repository = CreatorStatusRepository();

  var isLoading = true.obs;
  var allEvents = <EventStatus>[].obs;
  var allJobs = <JobStatus>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllStatuses();
  }

  Future<void> fetchAllStatuses() async {
    try {
      isLoading(true);
      final events = await _repository.fetchAllEventStatus();
      final jobs = await _repository.fetchAllJobStatus();
      if (events != null) {
        allEvents.assignAll(events);
      }
      if (jobs != null) {
        allJobs.assignAll(jobs);
      }
    } catch (e) {
      print('Error fetching statuses: $e');
    } finally {
      isLoading(false);
    }
  }
}
