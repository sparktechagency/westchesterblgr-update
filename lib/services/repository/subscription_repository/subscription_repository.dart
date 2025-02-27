import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../../../constants/app_api_url.dart';
import '../../../models/subscription_model.dart';
import '../../api/api_get_services.dart';

class SubscriptionRepository {
  final ApiGetServices _apiGetServices = ApiGetServices();

  Future<List<Subscription>?> fetchSubscriptions() async {
    try {
      final response =
          await _apiGetServices.apiGetServices(AppApiUrl.subscription);
      if (response != null && response['success'] == true) {
        return List<Subscription>.from(
            response['data'].map((x) => Subscription.fromJson(x)));
      } else {
        print('API call failed with status: ${response['status']}');
        print('Response body: ${response['message']}');
        return null;
      }
    } catch (e, stackTrace) {
      print('Error fetching subscriptions: $e');
      print('Stack trace: $stackTrace');
      return null;
    }
  }

  Future<bool> postBusinessInformation(Map<String, dynamic> data,
      Uint8List fileData, String fileName, String token) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(AppApiUrl.paymentAccountSetup),
      );

      request.fields['data'] = json.encode(data);
      request.files.add(
        http.MultipartFile.fromBytes(
          'KYC',
          fileData,
          filename: fileName,
          contentType: MediaType('application', 'pdf'),
        ),
      );

      request.headers['Authorization'] = 'Bearer $token';

      var response = await request.send();

      if (response.statusCode == 200) {
        return true;
      } else {
        print('Failed to post business information: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error posting business information: $e');
      return false;
    }
  }
}
