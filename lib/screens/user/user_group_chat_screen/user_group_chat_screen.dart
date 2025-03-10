import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_icons_path.dart';
import '../../../models/my_group_model.dart';
import '../../../widgets/icon_widget/icon_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';
import 'controller/user_group_chat_controller.dart';

class UserGroupChatScreen extends StatefulWidget {
  final MyGroup? group;

  UserGroupChatScreen({super.key, this.group});

  @override
  State<UserGroupChatScreen> createState() => _UserGroupChatScreenState();
}

class _UserGroupChatScreenState extends State<UserGroupChatScreen> {
  final TextEditingController messageController = TextEditingController();
  late final UserGroupChatController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(UserGroupChatController(group: widget.group!));
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: AppColors.whiteBg,
        appBar: AppBar(
          title: Obx(() => Text(controller.receiverName.value)),
        ),
        body: Stack(
          children: [
            Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return ListView.builder(
                  controller: controller.scrollController,
                  physics: const BouncingScrollPhysics(),
                  itemCount: controller.messages.length,
                  padding: const EdgeInsets.only(top: 10, bottom: 70),
                  itemBuilder: (context, index) {
                    final message = controller.messages[index];
                    final isReceived =
                        message.from?.id != controller.userProfile?.id;

                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width / (size.width / 14),
                        vertical: size.width / (size.width / 10),
                      ),
                      child: Align(
                        alignment:
                            isReceived ? Alignment.topLeft : Alignment.topRight,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: isReceived
                                ? AppColors.white
                                : AppColors.blueNormal,
                            boxShadow: const [
                              BoxShadow(
                                color: AppColors.grey300,
                                spreadRadius: 1,
                                blurRadius: 3,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(size.width / (size.width / 16)),
                          child: Column(
                            crossAxisAlignment: isReceived
                                ? CrossAxisAlignment.start
                                : CrossAxisAlignment.end,
                            children: [
                              if (message.from?.name != null)
                                TextWidget(
                                  text: message.from!.name!,
                                  fontColor: isReceived
                                      ? AppColors.grey600
                                      : AppColors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                ),
                              TextWidget(
                                text: message.message ?? '',
                                fontColor: isReceived
                                    ? AppColors.black500
                                    : AppColors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            }),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(right: size.width / (size.width / 20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(
                          left: size.width / (size.width / 20),
                          bottom: size.width / (size.width / 20),
                          right: size.width / (size.width / 11),
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(100),
                          boxShadow: const [
                            BoxShadow(
                              color: AppColors.grey300,
                              spreadRadius: 1,
                              blurRadius: 3,
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: messageController,
                          cursorColor: AppColors.blueNormal,
                          decoration: InputDecoration(
                            hintText: "Type here...",
                            hintStyle:
                                const TextStyle(color: AppColors.black300),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: size.width / (size.width / 16),
                              vertical: size.width / (size.width / 20),
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.sendMessage(messageController.text);
                        messageController.clear();
                      },
                      child: Container(
                        height: size.width / (size.width / 48),
                        width: size.width / (size.width / 48),
                        padding: EdgeInsets.all(size.width / (size.width / 12)),
                        margin: EdgeInsets.only(
                          bottom: size.width / (size.width / 20),
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.blueNormal,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: const IconWidget(
                          icon: AppIconsPath.sendIcon,
                          width: 24,
                          height: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
