import '../../../constants/app_api_url.dart';
import '../../../models/creator_analytics_status_model.dart';
import '../../../models/creator_status_model.dart';
import '../../../models/earning_status_model.dart';
import '../../../models/get_event_status_model.dart';
import '../../../models/get_job_status_model.dart';
import '../../api/api_get_services.dart';

class CreatorStatusRepository {
  final ApiGetServices _apiGetServices = ApiGetServices();

  Future<CreatorStatus?> fetchCreatorStatus() async {
    try {
      final response =
          await _apiGetServices.apiGetServices(AppApiUrl.getCreatorStatus);
      if (response != null && response['success'] == true) {
        return CreatorStatus.fromJson(response['data']);
      } else {
        print('API call failed with status: ${response['status']}');
        print('Response body: ${response['message']}');
        return null;
      }
    } catch (e, stackTrace) {
      print('Error fetching creator status: $e');
      print('Stack trace: $stackTrace');
      return null;
    }
  }

  Future<CreatorAnalyticsStatus?> fetchAnalyticsStatus() async {
    try {
      final response = await _apiGetServices
          .apiGetServices(AppApiUrl.creatorAnalyticsStatus);
      if (response != null && response['success'] == true) {
        return CreatorAnalyticsStatus.fromJson(response);
      } else {
        print('API call failed with status: ${response['status']}');
        print('Response body: ${response['message']}');
        return null;
      }
    } catch (e, stackTrace) {
      print('Error fetching analytics status: $e');
      print('Stack trace: $stackTrace');
      return null;
    }
  }

  Future<List<EarningStatus>?> fetchEarningsByYear(int year) async {
    try {
      final response = await _apiGetServices.apiGetServices(
        AppApiUrl.creatorEarningStatus,
        queryParameters: {'year': year},
      );
      if (response != null && response['success'] == true) {
        return (response['data'] as List)
            .map((e) => EarningStatus.fromJson(e))
            .toList();
      } else {
        print('API call failed with status: ${response['status']}');
        print('Response body: ${response['message']}');
        return null;
      }
    } catch (e, stackTrace) {
      print('Error fetching earnings by year: $e');
      print('Stack trace: $stackTrace');
      return null;
    }
  }

  Future<List<EventStatus>?> fetchAllEventStatus() async {
    try {
      final response =
          await _apiGetServices.apiGetServices(AppApiUrl.getAllEventStatus);
      if (response != null && response['success'] == true) {
        return (response['data'] as List)
            .map((e) => EventStatus.fromJson(e))
            .toList();
      } else {
        print('API call failed with status: ${response['status']}');
        print('Response body: ${response['message']}');
        return null;
      }
    } catch (e, stackTrace) {
      print('Error fetching all event status: $e');
      print('Stack trace: $stackTrace');
      return null;
    }
  }

  Future<List<JobStatus>?> fetchAllJobStatus() async {
    try {
      final response =
          await _apiGetServices.apiGetServices(AppApiUrl.getAllJobStatus);
      if (response != null && response['success'] == true) {
        return (response['data'] as List)
            .map((e) => JobStatus.fromJson(e))
            .toList();
      } else {
        print('API call failed with status: ${response['status']}');
        print('Response body: ${response['message']}');
        return null;
      }
    } catch (e, stackTrace) {
      print('Error fetching all job status: $e');
      print('Stack trace: $stackTrace');
      return null;
    }
  }
}
