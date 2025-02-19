import 'package:get/get.dart';

import '../../../../models/get_job_status_model.dart';
import '../../../../services/repository/user_job_repository/user_job_repository.dart';
import '../../../../utils/app_all_log/error_log.dart';

class CreatorAllJobApplicationController extends GetxController {
  final JobRepository _jobRepository = JobRepository();
  var allJobStatuses = <JobStatus>[].obs;

  Future<void> fetchAllJobStatuses() async {
    try {
      final statuses = await _jobRepository.fetchAllJobStatuses();
      if (statuses != null) {
        allJobStatuses.value = statuses;
      }
    } catch (e) {
      errorLog("Error in fetchAllJobStatuses", e);
    }
  }

  @override
  void onInit() {
    fetchAllJobStatuses();
    super.onInit();
  }
}
