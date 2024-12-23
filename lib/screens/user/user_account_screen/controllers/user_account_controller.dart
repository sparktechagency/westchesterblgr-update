import 'package:get/get.dart';

class UserAccountController extends GetxController {
  // Observable fields for the user data
  final RxString username = 'its_cheryl_btw'.obs;
  final RxString email = 'cherylboss@gmail.com'.obs;
  final RxString contactNumber = '+999999999999'.obs;

  // You can add methods to update the values
  void updateUsername(String newUsername) {
    username.value = newUsername;
  }

  void updateEmail(String newEmail) {
    email.value = newEmail;
  }

  void updateContactNumber(String newContact) {
    contactNumber.value = newContact;
  }
}
