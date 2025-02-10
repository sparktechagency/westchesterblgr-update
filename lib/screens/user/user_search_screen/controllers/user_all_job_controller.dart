import 'package:get/get.dart';
import 'package:itzel/models/get_job_model.dart';

import '../../../../services/repository/user_job_repository/user_job_repository.dart';

class UserAllJobController extends GetxController {
  final JobRepository _jobRepository = JobRepository();
  var jobs = <Datum>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchJobs();
  }

  Future<void> fetchJobs() async {
    try {
      isLoading.value = true;
      final fetchedJobs = await _jobRepository.fetchAllJobs();
      if (fetchedJobs != null) {
        jobs.value = fetchedJobs.data;
      }
    } catch (e) {
      print('Error fetching jobs: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
