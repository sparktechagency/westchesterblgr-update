import 'package:itzel/constants/app_api_url.dart';
import 'package:itzel/models/event_model.dart';
import 'package:itzel/services/api/api_get_services.dart';

import '../../../utils/app_all_log/error_log.dart';

class EventRepository {
  final ApiGetServices _apiGetServices = ApiGetServices();

  Future<List<EventModel>?> getAllEvents() async {
    try {
      final response = await _apiGetServices.apiGetServices(AppApiUrl.allEvent);
      if (response != null && response['data'] != null) {
        return List<EventModel>.from(
            response['data'].map((event) => EventModel.fromJson(event)));
      }
    } catch (e) {
      // Handle or log the error
      errorLog("Error fetching events", e);
      print('Error fetching events: $e');
    }
    return null;
  }
}
