import 'package:get/get.dart';
import 'package:itzel/models/notification_model.dart';
import 'package:itzel/services/repository/notification_repository/notification_repository.dart';

class UserNotificationController extends GetxController {
  final NotificationRepository _notificationRepository =
      NotificationRepository();
  var notifications = <Notification>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
  }

  Future<void> fetchNotifications() async {
    try {
      isLoading.value = true;
      final fetchedNotifications =
          await _notificationRepository.fetchNotifications();
      if (fetchedNotifications != null) {
        notifications.value = fetchedNotifications;
      } else {
        notifications.clear();
      }
    } catch (e) {
      print('Error fetching notifications: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
