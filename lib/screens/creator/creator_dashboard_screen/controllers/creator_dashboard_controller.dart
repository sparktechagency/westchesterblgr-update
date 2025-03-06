import 'package:get/get.dart';

import '../../../../models/get_event_status_model.dart';
import '../../../../models/get_job_status_model.dart';
import '../../../../services/repository/event_repository/event_repository.dart';
import '../../../../services/repository/user_job_repository/user_job_repository.dart';
import '../../../../utils/app_all_log/error_log.dart';

class CreatorDashboardController extends GetxController {
  final EventRepository _eventRepository = EventRepository();
  final JobRepository _jobRepository = JobRepository();
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
    totalEarning: 0,
    ticketSold: 0,
  ).obs;

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

  var jobStatus = JobStatus(
    id: '',
    image: '',
    companyName: '',
    role: '',
    description: '',
    address: '',
    level: '',
    jobType: '',
    salary: '',
    requirements: [],
    experience: [],
    additionalRequirement: [],
    questions: [],
    postedBy: '',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    v: 0,
    totalApplicant: 0,
    allApplicants: [],
  ).obs;

  Future<void> fetchJobStatus() async {
    try {
      final status = await _jobRepository.getJobStatus();
      if (status != null) {
        jobStatus.value = status;
      }
    } catch (e) {
      errorLog("Error in fetchJobStatus", e);
    }
  }

  @override
  void onInit() {
    fetchEventStatus();
    fetchJobStatus();
    super.onInit();
  }
}
