import 'package:get/get.dart';

class CreatorSubscriptionsController extends GetxController {
  final List<String> subscriptionPack = ["Basic", "Standard", "Premium"];
  final List<String> features = [
    'Unlimited advertisement',
    'Priority support',
    'Analytics dashboard',
    'Custom branding',
    'API access',
    'Advanced reporting'
  ];

  int selectedPackIndex = 0;

  void selectPack(int index) {
    selectedPackIndex = index;
    update();
  }

  void subscribe() {
    // Implement subscription logic here
    print('Subscribing to ${subscriptionPack[selectedPackIndex]} pack');
  }
}
