import 'package:get/get.dart';

import '../../../../constants/app_icons_path.dart';
import '../../../../constants/app_strings.dart';
import '../../../../routes/app_routes.dart';

class UserDrawerController extends GetxController {
  // List of titles for the drawer
  final List<String> titles = [
    AppStrings.myProfile,
    AppStrings.savedEvents,
    AppStrings.faq,
    AppStrings.termsConditions,
    AppStrings.changePassword,
    AppStrings.deleteAccount,
  ];

  // List of icons for the drawer
  final List<String> icons = [
    AppIconsPath.myProfileIcon,
    AppIconsPath.savedEventsIcon,
    AppIconsPath.faqIcon,
    AppIconsPath.termsConditionIcon,
    AppIconsPath.changePasswordIcon,
    AppIconsPath.deleteAccountIcon,
  ];

  // Navigate to different screens based on the index
  void onItemTapped(int index) {
    if (index < 0 || index >= titles.length || index >= icons.length) {
      Get.snackbar("Error", "Invalid selection");
      return;
    }

    switch (index) {
      case 0:
        Get.toNamed(AppRoutes.userProfileScreen);
        break;
      case 1:
        // Get.toNamed('/savedEvents');
        break;
      case 2:
        Get.toNamed(AppRoutes.userFaqScreen);
        break;
      case 3:
        Get.toNamed(AppRoutes.userTermsConditionScreen);
        break;
      case 4:
        Get.toNamed(AppRoutes.userChangePasswordScreen);
        break;
      case 5:
        Get.toNamed(AppRoutes.userDeleteAccountScreen);
        break;
      default:
        Get.snackbar("Error", "Invalid selection");
    }
  }

  void addNewOption(String title, String icon) {
    titles.add(title);
    icons.add(icon);
    update(); // Rebuild the UI
  }
}
