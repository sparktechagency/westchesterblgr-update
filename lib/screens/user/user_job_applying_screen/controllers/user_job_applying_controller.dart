import 'package:get/get.dart';
import 'package:itzel/models/get_job_model.dart';
import 'package:itzel/services/repository/user_job_repository/user_job_repository.dart';

class UserJobApplyingController extends GetxController {
  final JobRepository _jobDetailsRepository = JobRepository();
  var jobDetails = Datum(
    id: '',
    image: '',
    companyName: '',
    role: '',
    description: '',
    address: '',
    level: '',
    jobType: '',
    salary: '',
    questions: [],
    postedBy: '',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    v: 0,
    requirements: [],
    experience: [],
    additionalRequirement: [],
  ).obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    final jobId = Get.arguments['jobId'];
    fetchJobDetails(jobId);
  }

  Future<void> fetchJobDetails(String jobId) async {
    try {
      isLoading.value = true;
      final fetchedJobDetails =
          await _jobDetailsRepository.fetchJobDetails(jobId);
      if (fetchedJobDetails != null) {
        jobDetails.value = fetchedJobDetails;
      }
    } catch (e) {
      print('Error fetching job details: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
