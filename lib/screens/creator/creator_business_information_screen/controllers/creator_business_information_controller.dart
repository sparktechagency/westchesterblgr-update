import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:itzel/services/repository/subscription_repository/subscription_repository.dart';
import 'package:itzel/services/storage_services/app_auth_storage.dart';

import '../../../../widgets/app_snack_bar/app_snack_bar.dart';

class CreatorBusinessInformationController extends GetxController {
  final SubscriptionRepository _repository = SubscriptionRepository();
  final AppAuthStorage _authStorage = AppAuthStorage();

  Future<void> postBusinessInformation(
      Map<String, dynamic> data, Uint8List fileData, String fileName) async {
    String? token = _authStorage.getToken();
    if (token == null) {
      AppSnackBar.error('Token not found. Please log in again.');
      return;
    }

    bool success = await _repository.postBusinessInformation(
        data, fileData, fileName, token);
    if (success) {
      AppSnackBar.success('Business information posted successfully');
    } else {
      AppSnackBar.error('Failed to post business information');
    }
  }
}
