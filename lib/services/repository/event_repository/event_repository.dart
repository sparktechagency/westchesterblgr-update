import 'package:itzel/constants/app_api_url.dart';
import 'package:itzel/models/event_model.dart';
import 'package:itzel/services/api/api_get_services.dart';

import '../../../utils/app_all_log/error_log.dart';
import '../../api/api_post_services.dart';

class EventRepository {
  final ApiGetServices _apiGetServices = ApiGetServices();
  final ApiPostServices _apiPostServices = ApiPostServices();

  Future<List<EventModel>?> getAllEvents() async {
    try {
      final response = await _apiGetServices.apiGetServices(AppApiUrl.allEvent);
      if (response != null) {
        if (response is List) {
          return List<EventModel>.from(
              response.map((event) => EventModel.fromJson(event)));
        } else if (response['data'] != null) {
          return List<EventModel>.from(
              response['data'].map((event) => EventModel.fromJson(event)));
        }
      }
    } catch (e) {
      errorLog("Error fetching events", e);
      print('Error fetching events: $e');
    }
    return null;
  }

  Future<EventModel?> getEventById(String id) async {
    try {
      final response = await _apiGetServices
          .apiGetServices('${AppApiUrl.baseUrl}/event/$id');
      if (response != null) {
        if (response is List && response.isNotEmpty) {
          // If response is a list, take the first item
          return EventModel.fromJson(response[0]);
        } else if (response is Map<String, dynamic>) {
          // If response is an object with data property
          if (response['data'] != null) {
            if (response['data'] is List) {
              return response['data'].isNotEmpty
                  ? EventModel.fromJson(response['data'][0])
                  : null;
            }
            return EventModel.fromJson(response['data']);
          }
          // If response is a direct object
          return EventModel.fromJson(response);
        }
      }
    } catch (e) {
      errorLog("Error fetching event by ID", e);
      print('Error fetching event by ID: $e');
    }
    return null;
  }

  Future<bool> addToWishlist(String eventId) async {
    try {
      final response = await _apiPostServices.apiPostServices(
        url: '${AppApiUrl.baseUrl}/user/wishlist/event/add/$eventId',
      );
      if (response != null) {
        return true;
      }
      return false;
    } catch (e) {
      errorLog("Error adding event to wishlist", e);
      return false;
    }
  }
}
