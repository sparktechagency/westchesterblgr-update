import 'package:itzel/constants/app_api_url.dart';
import 'package:itzel/models/notification_model.dart';
import 'package:itzel/services/api/api_get_services.dart';

class NotificationRepository {
  final ApiGetServices _apiGetServices = ApiGetServices();

  Future<List<Notification>?> fetchNotifications() async {
    try {
      final response = await _apiGetServices.apiGetServices(
        '${AppApiUrl.baseUrl}${AppApiUrl.notification}',
      );
      if (response != null) {
        final welcome = Welcome.fromJson(response);
        return welcome.data;
      }
    } catch (e) {
      print('Error fetching notifications: $e');
    }
    return null;
  }
}
