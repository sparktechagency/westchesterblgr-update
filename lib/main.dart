import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';

import 'main_app_entry.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await GetStorage.init();
  runApp(

      //     DevicePreview(
      //   enabled: !kReleaseMode,
      //   builder: (context) => const MainApp(), // Wrap your app
      // )

      const MainApp());
}
