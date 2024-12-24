import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_icons_path.dart';
import '../../../constants/app_images_path.dart';
import '../../../constants/app_strings.dart';
import '../../../routes/app_routes.dart';
import '../../../widgets/icon_button_widget/icon_button_widget.dart';
import '../../../widgets/icon_widget/icon_widget.dart';
import '../../../widgets/space_widget/space_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';

class CreatorAllChatScreen extends StatefulWidget {
  const CreatorAllChatScreen({super.key});

  @override
  State<CreatorAllChatScreen> createState() => _CreatorAllChatScreenState();
}

class _CreatorAllChatScreenState extends State<CreatorAllChatScreen> {
  final TextEditingController searchController = TextEditingController();
  bool isExpanded = false;

  void toggleExpanded() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: AppColors.whiteBg,
        body: Column(
          children: [
            const SpaceWidget(spaceHeight: 8),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width / (size.width / 20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Visibility(
                    visible: !isExpanded,
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 300),
                      opacity: isExpanded ? 0.0 : 1.0,
                      child: const TextWidget(
                        text: AppStrings.allChat,
                        fontColor: AppColors.black500,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: isExpanded
                            ? size.width / (size.width / 300)
                            : size.width / (size.width / 48),
                        height: size.height / (size.height / 45),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(33),
                          color:
                              isExpanded ? AppColors.white : AppColors.whiteBg,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Material(
                              type: MaterialType.transparency,
                              child: IconButton(
                                onPressed: toggleExpanded,
                                icon: isExpanded
                                    ? const Icon(Icons.close)
                                    : const IconWidget(
                                        icon: AppIconsPath.newChatIcon,
                                        height: 24,
                                        width: 24,
                                      ),
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                              ),
                            ),
                            Flexible(
                              child: isExpanded
                                  ? TextField(
                                      controller: searchController,
                                      style: const TextStyle(
                                          color: AppColors.black),
                                      cursorColor: AppColors.black,
                                      decoration: const InputDecoration(
                                        hintText: 'Search',
                                        hintStyle:
                                            TextStyle(color: AppColors.grey600),
                                        contentPadding:
                                            EdgeInsets.fromLTRB(5, 8, 20, 10),
                                        border: InputBorder.none,
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                            ),
                            if (isExpanded)
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.search),
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                              ),
                          ],
                        ),
                      ),
                      const SpaceWidget(spaceWidth: 12),
                      PopupMenuButton<int>(
                        icon: const Icon(
                          Icons.more_vert,
                          color: AppColors.black,
                          size: 24,
                        ),
                        onSelected: (int result) {
                          // Handle menu item selection
                          switch (result) {
                            case 0:
                              // Action for first menu item
                              break;
                          }
                        },
                        itemBuilder: (BuildContext context) =>
                            <PopupMenuEntry<int>>[
                          const PopupMenuItem<int>(
                            value: 0,
                            child: Row(
                              children: [
                                Icon(Icons.settings, size: 20),
                                SpaceWidget(spaceWidth: 6),
                                Text('Settings'),
                              ],
                            ),
                          ),
                          // Add more PopupMenuItem widgets for additional menu items
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SpaceWidget(spaceHeight: 8),
            ...List.generate(
              5,
              (index) {
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.creatorChatScreen);
                  },
                  borderRadius: BorderRadius.circular(16),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    margin: EdgeInsets.only(
                      left: size.width / (size.width / 20),
                      right: size.width / (size.width / 20),
                      bottom: size.width / (size.width / 12),
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                          color: AppColors.grey300,
                          spreadRadius: 1,
                          blurRadius: 3,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.asset(
                                AppImagesPath.chatProfileImage,
                                height: size.width / (size.width / 48),
                                width: size.width / (size.width / 48),
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SpaceWidget(spaceWidth: 8),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextWidget(
                                  text: AppStrings.chatUserName,
                                  fontColor: AppColors.black500,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                                SpaceWidget(spaceHeight: 7),
                                TextWidget(
                                  text: AppStrings.chatDetails,
                                  fontColor: AppColors.black500,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              height: size.width / (size.width / 16),
                              width: size.width / (size.width / 16),
                              decoration: BoxDecoration(
                                color: AppColors.red,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: const Center(
                                child: TextWidget(
                                  text: AppStrings.unreadChatQuantity,
                                  fontColor: AppColors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SpaceWidget(spaceHeight: 8),
                            const TextWidget(
                              text: AppStrings.unreadChatTime,
                              fontColor: AppColors.black300,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
