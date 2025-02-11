import 'package:get/get.dart';
import 'package:itzel/models/get_job_model.dart';

import '../../../../services/repository/profile_repository/profile_repository.dart';
import '../../../../services/repository/user_job_repository/user_job_repository.dart';
import '../../../../widgets/app_snack_bar/app_snack_bar.dart';

class UserAllJobController extends GetxController {
  final JobRepository _jobRepository = JobRepository();
  final ProfileRepository _profileRepository = ProfileRepository();
  var jobs = <Datum>[].obs;
  var isLoading = true.obs;
  var isBookmarked = false.obs;
  var jobWishlist = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchJobs();
    fetchJobWishlist();
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

  Future<void> fetchJobWishlist() async {
    try {
      final profile = await _profileRepository.fetchProfile();
      if (profile != null) {
        jobWishlist.value = profile.jobWishList.map((job) => job.id).toList();
      }
    } catch (e) {
      print('Error fetching job wishlist: $e');
    }
  }

  Future<void> addToWishlist(String jobId) async {
    try {
      bool success = await _jobRepository.addToJobWishlist(jobId);
      if (success) {
        isBookmarked.value = true;
        AppSnackBar.success('Job added to wishlist');
      } else {
        AppSnackBar.error('Failed to add job to wishlist');
      }
    } catch (e) {
      AppSnackBar.error('Error adding job to wishlist: $e');
    }
  }

  bool isJobInWishlist(String jobId) {
    return jobWishlist.contains(jobId);
  }
}
