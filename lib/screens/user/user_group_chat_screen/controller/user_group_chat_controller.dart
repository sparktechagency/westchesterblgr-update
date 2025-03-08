// lib/screens/user/user_group_chat_screen/controller/user_group_chat_controller.dart
import 'package:get/get.dart';

import '../../../../models/my_group_model.dart';

class UserGroupChatController extends GetxController {
  final MyGroup group;
  RxList<MyGroup> messages = <MyGroup>[].obs;
  final RxString receiverName = ''.obs;
  RxBool isLoading = false.obs;

  UserGroupChatController({required this.group}) {
    receiverName.value = group.name ?? 'Unknown Group';
    initializeMessages();
  }

  void initializeMessages() {
    if (group.message != null && group.message!.isNotEmpty) {
      messages.add(group);
    }
  }

  void sendMessage(String content) {
    if (content.isNotEmpty) {
      messages.add(MyGroup(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        message: content,
        from: group.from,
        createdAt: DateTime.now(),
      ));
    }
  }
}
