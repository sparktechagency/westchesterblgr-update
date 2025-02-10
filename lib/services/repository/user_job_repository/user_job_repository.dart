import 'package:itzel/constants/app_api_url.dart';
import 'package:itzel/models/get_job_model.dart';
import 'package:itzel/services/api/api_get_services.dart';
import 'package:itzel/utils/app_all_log/error_log.dart';

class JobRepository {
  final ApiGetServices _apiGetServices = ApiGetServices();

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
}
