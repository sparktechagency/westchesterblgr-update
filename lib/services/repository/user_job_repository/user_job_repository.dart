import 'package:itzel/constants/app_api_url.dart';
import 'package:itzel/models/get_job_model.dart';
import 'package:itzel/services/api/api_get_services.dart';
import 'package:itzel/utils/app_all_log/error_log.dart';

import '../../api/api_delete_services.dart';
import '../../api/api_post_services.dart';

class JobRepository {
  final ApiGetServices _apiGetServices = ApiGetServices();
  final ApiPostServices _apiPostServices = ApiPostServices();
  final ApiDeleteServices _apiDeleteServices = ApiDeleteServices();

  Future<Welcome?> fetchAllJobs() async {
    try {
      final response = await _apiGetServices.apiGetServices(AppApiUrl.allJob);
      if (response != null && response['success'] == true) {
        return Welcome.fromJson(response);
      } else {
        print('API call failed with status: ${response['status']}');
        print('Response body: ${response['message']}');
        return null;
      }
    } catch (e, stackTrace) {
      print('Error fetching jobs: $e');
      print('Stack trace: $stackTrace');
      errorLog('Error fetching jobs', e);
      return null;
    }
  }

  Future<Datum?> fetchJobDetails(String jobId) async {
    try {
      final response =
          await _apiGetServices.apiGetServices('${AppApiUrl.allJob}/$jobId');
      if (response != null && response['success'] == true) {
        return Datum.fromJson(response['data']);
      } else {
        print('API call failed with status: ${response['status']}');
        print('Response body: ${response['message']}');
        return null;
      }
    } catch (e, stackTrace) {
      print('Error fetching job details: $e');
      print('Stack trace: $stackTrace');
      errorLog('Error fetching job details', e);
      return null;
    }
  }

  Future<bool> addToJobWishlist(String jobId) async {
    try {
      final response = await _apiPostServices.apiPostServices(
        url: '${AppApiUrl.baseUrl}/user/wishlist/job/add/$jobId',
      );
      if (response != null) {
        return true;
      }
      return false;
    } catch (e) {
      errorLog("Error adding job to wishlist", e);
      return false;
    }
  }

  Future<bool> removeJobFromWishlist(String jobId) async {
    try {
      final response = await _apiDeleteServices.apiDeleteServices(
        '${AppApiUrl.baseUrl}/user/wishlist/job/remove/$jobId',
      );
      if (response != null) {
        return true;
      }
      return false;
    } catch (e) {
      errorLog("Error removing job from wishlist", e);
      return false;
    }
  }
}
