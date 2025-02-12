import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';

import '../../../../services/repository/event_repository/event_repository.dart';
import '../../../../utils/app_all_log/error_log.dart';

class PaymentController extends GetxController {
  static const String publishableKey =
      "pk_test_51Q6nR92LZOEqC8MemSRnQiKzVKDAgKCR1tXitV8wvqW0fEvw9YubxnwLQ25jIjvWeHv2GA8eSYqYSi9zsA7fbEPm00AAdbfdzK";

  @override
  void onInit() {
    super.onInit();
    Stripe.publishableKey = publishableKey;
  }

  Future<void> makePayment(String clientSecret) async {
    try {
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: 'Your Merchant Name',
        ),
      );

      await Stripe.instance.presentPaymentSheet();
      Get.snackbar('Success', 'Payment completed successfully',
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar('Error', 'Payment failed: $e',
          snackPosition: SnackPosition.BOTTOM);
      errorLog("Error making payment", e);
    }
  }

  Future<void> buyTicket(int amount) async {
    try {
      final response = await EventRepository().buyTicket(amount);
      if (response != null && response['data'] != null) {
        final clientSecret = response['data']['paymentIntent'];
        await makePayment(clientSecret);
      } else {
        Get.snackbar('Error', 'Failed to create payment intent',
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar('Error', 'Error buying ticket: $e',
          snackPosition: SnackPosition.BOTTOM);
      errorLog("Error buying ticket", e);
    }
  }
}
