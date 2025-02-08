import 'package:itzel/constants/app_api_url.dart';
import 'package:itzel/models/profile_model.dart';
import 'package:itzel/services/api/api_get_services.dart';
import 'package:itzel/utils/app_all_log/error_log.dart';

class ProfileRepository {
  final ApiGetServices _apiGetServices = ApiGetServices();

  Future<Data?> fetchProfile() async {
    try {
      final response = await _apiGetServices.apiGetServices(AppApiUrl.profile);
      if (response != null && response['success'] == true) {
        final data = Data.fromJson(response['data']);
        return data;
      } else {
        print('API call failed with status: ${response['status']}');
        print('Response body: ${response['message']}');
      }
    } catch (e, stackTrace) {
      print('Error fetching profile data: $e');
      print('Stack trace: $stackTrace');
      errorLog('Error fetching profile data', e);
    }
    return null;
  }
}
