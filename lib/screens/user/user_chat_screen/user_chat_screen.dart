import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:itzel/routes/app_routes.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_icons_path.dart';
import '../../../widgets/icon_widget/icon_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';

import 'controllers/user_chat_controller.dart';
import 'widgets/user_appbar_widget.dart';

class ChatMessage {
  String messageContent;
  String messageType;

  ChatMessage({
    required this.messageContent,
    required this.messageType,
  });
}

class UserChatScreen extends StatefulWidget {
  UserChatScreen({super.key});

  @override
  State<UserChatScreen> createState() => _UserChatScreenState();
}

class _UserChatScreenState extends State<UserChatScreen> {
  final TextEditingController messageController = TextEditingController();

  // Move messages list to state
  List<ChatMessage> messages = [
    ChatMessage(messageContent: "Hello, Will", messageType: "receiver"),
    ChatMessage(messageContent: "How have you been?", messageType: "receiver"),
    ChatMessage(
        messageContent: "Hey Kriss, I am doing fine dude. wbu?",
        messageType: "sender"),
    ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
    ChatMessage(
        messageContent: "Is there any thing wrong?", messageType: "sender"),
  ];

  void sendMessage(String content) {
    if (content.isNotEmpty) {
      setState(() {
        messages.add(ChatMessage(
          messageContent: content,
          messageType: "sender",
        ));
      });
    }
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
        appBar: UserAppBarWidget(
          onTitleTap: () {
            Get.toNamed(AppRoutes.userChatReceiverInfoScreen);
          },
          onInfoTap: () {
            Get.toNamed(AppRoutes.userChatReceiverInfoScreen);
          },
          onMoreTap: () {},
          titleText: 'Bryan Lewis',
          subTitleText: 'Last Seen 12h ago',
        ),
        body: Stack(
          children: [
            // Chat messages list
            ListView.builder(
              itemCount: messages.length,
              padding: const EdgeInsets.only(top: 10, bottom: 70),
              itemBuilder: (context, index) {
                final message = messages[index];
                return Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width / (size.width / 14),
                    vertical: size.width / (size.width / 10),
                  ),
                  child: Align(
                    alignment: message.messageType == "receiver"
                        ? Alignment.topLeft
                        : Alignment.topRight,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: message.messageType == "receiver"
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
                      padding: EdgeInsets.all(size.width / (size.width / 16)),
                      child: TextWidget(
                        text: message.messageContent,
                        fontColor: message.messageType == "receiver"
                            ? AppColors.black500
                            : AppColors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                );
              },
            ),
            // Bottom input field
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
                    // Send button
                    GestureDetector(
                      onTap: () {
                        sendMessage(messageController.text);
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
