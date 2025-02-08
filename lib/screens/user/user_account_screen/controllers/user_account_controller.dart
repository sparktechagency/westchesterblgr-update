import 'package:get/get.dart';
import 'package:itzel/models/profile_model.dart';
import 'package:itzel/services/repository/profile_repository/profile_repository.dart';

class UserAccountController extends GetxController {
  final ProfileRepository _profileRepository = ProfileRepository();

  final RxString username = ''.obs;
  final RxString email = ''.obs;
  final RxString contactNumber = ''.obs;
  final RxString profileImage = ''.obs;
  final RxString role = ''.obs;
  final RxBool verified = false.obs;

  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProfileData();
  }

  Future<void> fetchProfileData() async {
    isLoading.value = true;
    try {
      final Data? data = await _profileRepository.fetchProfile();
      if (data != null) {
        username.value = data.name;
        email.value = data.email;
        contactNumber.value = data.contact;
        profileImage.value = data.profile;
        role.value = data.role;
        verified.value = data.verified;
      }
    } catch (e) {
      print('Error fetching profile data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
