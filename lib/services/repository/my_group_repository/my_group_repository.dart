import '../../../constants/app_api_url.dart';
import '../../../models/my_group_model.dart';
import '../../../utils/app_all_log/error_log.dart';
import '../../api/api_get_services.dart';

class MyGroupRepository {
  final ApiGetServices _apiGetServices = ApiGetServices();

  Future<Welcome?> fetchUserGroups() async {
    try {
      final response = await _apiGetServices.apiGetServices(AppApiUrl.myGroup);
      if (response != null && response['success'] == true) {
        return Welcome.fromJson(response);
      } else {
        print('API call failed with status: ${response['status']}');
        print('Response body: ${response['message']}');
        return null;
      }
    } catch (e, stackTrace) {
      print('Error fetching user groups: $e');
      print('Stack trace: $stackTrace');
      errorLog('Error fetching user groups', e);
      return null;
    }
  }
}
