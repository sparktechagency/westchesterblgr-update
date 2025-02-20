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
}
