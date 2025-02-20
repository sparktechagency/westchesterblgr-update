import 'package:get/get.dart';

import '../../../../models/subscription_model.dart';
import '../../../../services/repository/subscription_repository/subscription_repository.dart';

class CreatorSubscriptionsController extends GetxController {
  final SubscriptionRepository _subscriptionRepository =
      SubscriptionRepository();
  var subscriptions = <Subscription>[].obs;
  var isLoading = true.obs;
  var selectedPackIndex = 0.obs;

  Future<void> fetchSubscriptions() async {
    try {
      isLoading(true);
      final subs = await _subscriptionRepository.fetchSubscriptions();
      if (subs != null) {
        subscriptions.value = subs;
      }
    } catch (e) {
      print("Error in fetchSubscriptions: $e");
    } finally {
      isLoading(false);
    }
  }

  void selectPack(int index) {
    selectedPackIndex.value = index;
  }

  @override
  void onInit() {
    fetchSubscriptions();
    super.onInit();
  }
}
