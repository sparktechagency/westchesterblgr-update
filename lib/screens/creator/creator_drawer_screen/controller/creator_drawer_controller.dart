import 'package:get/get.dart';

import '../../../../routes/app_routes.dart';
import '../../../../services/storage_services/app_auth_storage.dart';
import '../../../../widgets/app_snack_bar/app_snack_bar.dart';

class CreatorDrawerController extends GetxController {
  AppAuthStorage appAuthStorage = AppAuthStorage();

  Future<void> logout() async {
    try {
      await appAuthStorage.storageClear();
      AppSnackBar.success("Logged out successfully!");
      Get.offAllNamed(AppRoutes.loginScreen);
    } catch (e) {
      AppSnackBar.error("Failed to log out. Please try again.");
    }
  }
}
