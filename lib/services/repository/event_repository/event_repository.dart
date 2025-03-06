import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:itzel/constants/app_api_url.dart';
import 'package:itzel/models/event_model.dart';
import 'package:itzel/services/api/api_get_services.dart';
import 'package:mime/mime.dart';

import '../../../models/event_schedule_model.dart' as EventSchedule;
import '../../../models/get_event_status_model.dart';
import '../../../utils/app_all_log/error_log.dart';
import '../../api/api_delete_services.dart';
import '../../api/api_post_services.dart';

class EventRepository {
  final ApiGetServices _apiGetServices = ApiGetServices();
  final ApiPostServices _apiPostServices = ApiPostServices();
  final ApiDeleteServices _apiDeleteServices = ApiDeleteServices();

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

  Future<bool> removeFromWishlist(String eventId) async {
    try {
      final response = await _apiDeleteServices.apiDeleteServices(
        '${AppApiUrl.baseUrl}/user/wishlist/event/remove/$eventId',
      );
      if (response != null) {
        return true;
      }
      return false;
    } catch (e) {
      errorLog("Error removing event from wishlist", e);
      return false;
    }
  }

  Future<Map<String, dynamic>?> createPaymentIntent(int amount) async {
    try {
      final response = await _apiPostServices.apiPostServices(
        url: '${AppApiUrl.baseUrl}${AppApiUrl.createPaymentIntent}',
        body: {'amount': amount},
      );
      return response;
    } catch (e) {
      errorLog("Error creating payment intent", e);
      return null;
    }
  }

  Future<List<EventModel>?> getEventsByDate(String date) async {
    try {
      print('Attempting to fetch events with date: $date');

      final response = await _apiGetServices.apiGetServices(
        '${AppApiUrl.baseUrl}/event',
        queryParameters: {'time': date},
      );

      print('Raw API response: $response');

      if (response != null && response['data'] != null) {
        print('Response data type: ${response['data'].runtimeType}');
        print('Response data: ${response['data']}');

        return List<EventModel>.from(
            response['data'].map((event) => EventModel.fromJson(event)));
      } else {
        print('No data found in the response');
      }
    } catch (e, stackTrace) {
      errorLog("Error fetching events by date", e);
      print('Error fetching events by date: $e');
      print('Stacktrace: $stackTrace');
    }
    return null;
  }

// Creator

  Future<bool> createEvent(Map<String, dynamic> eventData,
      {File? imageFile, File? videoFile}) async {
    try {
      FormData formData = FormData.fromMap({
        ...eventData,
      });

      if (imageFile != null && await imageFile.exists()) {
        String imageFileName = imageFile.path.split('/').last;
        String? imageMimeType = lookupMimeType(imageFile.path);
        formData.files.add(MapEntry(
          'thumbnailImage',
          await MultipartFile.fromFile(
            imageFile.path,
            filename: imageFileName,
            contentType: MediaType.parse(imageMimeType ?? 'image/jpeg'),
          ),
        ));
      }

      if (videoFile != null && await videoFile.exists()) {
        String videoFileName = videoFile.path.split('/').last;
        String? videoMimeType = lookupMimeType(videoFile.path);
        formData.files.add(MapEntry(
          'introMedia',
          await MultipartFile.fromFile(
            videoFile.path,
            filename: videoFileName,
            contentType: MediaType.parse(videoMimeType ?? 'video/mp4'),
          ),
        ));
      }

      final response = await _apiPostServices.apiPostServices(
        url: AppApiUrl.createEvent,
        body: formData,
      );

      return response != null;
    } catch (e) {
      errorLog("Error creating event with files", e);
      return false;
    }
  }

  Future<EventStatus?> getEventStatus() async {
    try {
      final response = await _apiGetServices
          .apiGetServices('${AppApiUrl.baseUrl}${AppApiUrl.getEventStatus}');
      if (response != null) {
        return EventStatus.fromJson(response['data']);
      }
    } catch (e) {
      errorLog("Error fetching event status", e);
    }
    return null;
  }

  Future<List<EventStatus>?> getAllEventStatus() async {
    try {
      final response = await _apiGetServices
          .apiGetServices('${AppApiUrl.baseUrl}${AppApiUrl.getAllEventStatus}');
      if (response != null && response['data'] != null) {
        return List<EventStatus>.from(
            response['data'].map((event) => EventStatus.fromJson(event)));
      }
    } catch (e) {
      errorLog("Error fetching all event status", e);
    }
    return null;
  }

  Future<EventSchedule.Welcome?> getEventSchedule() async {
    try {
      final response =
          await _apiGetServices.apiGetServices(AppApiUrl.eventSchedule);
      print('Raw response from getEventSchedule: $response');

      if (response != null) {
        return EventSchedule.Welcome.fromJson(response as Map<String, dynamic>);
      }
      return null;
    } catch (e, stackTrace) {
      errorLog("Error fetching event schedule", e);
      print('Error fetching event schedule: $e');
      print('Stack trace: $stackTrace');
      return null;
    }
  }
}
