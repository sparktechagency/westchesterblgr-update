import 'package:get/get.dart';

import '../../../../models/my_group_model.dart';
import '../../../../models/profile_model.dart';
import '../../../../services/repository/my_group_repository/my_group_repository.dart';
import '../../../user/user_profile_screen/controllers/user_profile_controller.dart';

class UserGroupChatController extends GetxController {
  final MyGroup group;
  RxList<MyGroup> messages = <MyGroup>[].obs;
  final RxString receiverName = ''.obs;
  RxBool isLoading = false.obs;
  final MyGroupRepository _myGroupRepository = MyGroupRepository();
  final UserProfileController _userProfileController =
      Get.put(UserProfileController());
  Data? userProfile;

  UserGroupChatController({required this.group}) {
    receiverName.value = group.name ?? 'Unknown Group';
    fetchUserProfile();
    fetchMessages();
  }

  void fetchUserProfile() async {
    try {
      userProfile = await _userProfileController.fetchProfileData();
    } catch (e) {
      print('Error fetching user profile: $e');
    }
  }

  void fetchMessages() async {
    try {
      isLoading.value = true;
      final fetchedMessages =
          await _myGroupRepository.fetchMessagesByGroupId(group.id!);
      if (fetchedMessages != null) {
        messages.value = fetchedMessages;
      }
    } catch (e) {
      print('Error fetching messages: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void sendMessage(String content) async {
    if (content.isNotEmpty) {
      try {
        final success =
            await _myGroupRepository.postMessage(group.id!, content);
        if (success) {
          messages.add(MyGroup(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            message: content,
            from: From(
              id: userProfile?.id,
              name: userProfile?.name,
              email: userProfile?.email,
              profile: userProfile?.profile,
            ),
            createdAt: DateTime.now(),
          ));
        }
      } catch (e) {
        print('Error sending message: $e');
      }
    }
  }
}
