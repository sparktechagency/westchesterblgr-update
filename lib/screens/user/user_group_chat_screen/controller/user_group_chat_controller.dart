import 'package:get/get.dart';

import '../../../../models/my_group_model.dart';
import '../../../../services/repository/my_group_repository/my_group_repository.dart';

class UserGroupChatController extends GetxController {
  final MyGroup group;
  RxList<MyGroup> messages = <MyGroup>[].obs;
  final RxString receiverName = ''.obs;
  RxBool isLoading = false.obs;
  final MyGroupRepository _myGroupRepository = MyGroupRepository();

  UserGroupChatController({required this.group}) {
    receiverName.value = group.name ?? 'Unknown Group';
    fetchMessages();
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
            from: group.from,
            createdAt: DateTime.now(),
          ));
        }
      } catch (e) {
        print('Error sending message: $e');
      }
    }
  }
}
