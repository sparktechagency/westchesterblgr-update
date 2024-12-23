import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreatorPostController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  RxInt eventPostCount = 2.obs;
  RxInt jobPostCount = 5.obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
