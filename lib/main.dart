import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get_storage/get_storage.dart';

import 'main_app_entry.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await GetStorage.init();

  Stripe.publishableKey =
      "pk_test_51Q6nR92LZOEqC8MemSRnQiKzVKDAgKCR1tXitV8wvqW0fEvw9YubxnwLQ25jIjvWeHv2GA8eSYqYSi9zsA7fbEPm00AAdbfdzK";
  await Stripe.instance.applySettings();

  runApp(

      //     DevicePreview(
      //   enabled: !kReleaseMode,
      //   builder: (context) => const MainApp(), // Wrap your app
      // )

      const MainApp());
}
