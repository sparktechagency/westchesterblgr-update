import 'package:get/get.dart';

import '../../../../models/profile_model.dart';
import '../../../../routes/app_routes.dart';
import '../../../../services/repository/profile_repository/profile_repository.dart';
import '../../../../services/storage_services/app_auth_storage.dart';
import '../../../../widgets/app_snack_bar/app_snack_bar.dart';

class UserDrawerController extends GetxController {
  AppAuthStorage appAuthStorage = AppAuthStorage();
  final ProfileRepository _profileRepository = ProfileRepository();
  var eventWishlist = <EventWishList>[].obs;
  var jobWishlist = <JobWishList>[].obs;

  Future<void> fetchEventWishlist() async {
    try {
      final profile = await _profileRepository.fetchProfile();
      if (profile != null) {
        eventWishlist.value = profile.eventWishList;
      }
    } catch (e) {
      AppSnackBar.error("Error fetching event wishlist: $e");
    }
  }

  Future<void> fetchJobWishlist() async {
    try {
      final profile = await _profileRepository.fetchProfile();
      if (profile != null) {
        jobWishlist.value = profile.jobWishList;
      }
    } catch (e) {
      AppSnackBar.error("Error fetching job wishlist: $e");
    }
  }

  Future<void> logout() async {
    try {
      await appAuthStorage.storageClear();
      AppSnackBar.success("Logged out successfully!");
      Get.offAllNamed(AppRoutes.loginScreen);
    } catch (e) {
      AppSnackBar.error("Failed to log out. Please try again.");
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchEventWishlist();
    fetchJobWishlist();
  }
}
