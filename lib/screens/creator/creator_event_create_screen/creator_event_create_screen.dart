import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:itzel/screens/creator/creator_event_create_screen/controllers/creator_event_create_controller.dart';
import 'package:itzel/screens/creator/creator_event_create_screen/widgets/creator_event_textfield_widget.dart';
import 'package:itzel/screens/creator/creator_map_screen/creator_map_screen.dart';
import 'package:itzel/widgets/button_widget/button_widget.dart';
import 'package:itzel/widgets/space_widget/space_widget.dart';
import 'package:itzel/widgets/text_widget/text_widgets.dart';

import '../../../constants/app_colors.dart';
import '../../../widgets/appbar_widget/appbar_widget.dart';

class CreatorEventCreateScreen extends StatelessWidget {
  CreatorEventCreateScreen({super.key});

  final CreatorEventCreateController controller =
      Get.put(CreatorEventCreateController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: AppColors.whiteBg,
      appBar: const AppbarWidget(text: 'Uploading Event'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextWidget(
              text: 'Upload Thumbail',
              fontColor: AppColors.black500,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            const SpaceWidget(spaceHeight: 4),
            DottedBorder(
              borderType: BorderType.RRect,
              radius: const Radius.circular(12),
              child: InkWell(
                onTap: controller.pickImage,
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  child: SizedBox(
                      height: size.height / (size.height / 143),
                      width: double.infinity,
                      child: Obx(
                        () => controller.image.value == null
                            ? const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add,
                                    size: 32,
                                    color: AppColors.black500,
                                  ),
                                  SpaceWidget(spaceHeight: 12),
                                  TextWidget(
                                    text: 'Upload',
                                    fontColor: AppColors.black500,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
                              )
                            : Image.file(
                                controller.image.value!,
                                height: size.height / (size.height / 143),
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                      )),
                ),
              ),
            ),
            const SpaceWidget(spaceHeight: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: TextWidget(
                text: 'Upload Intro Video',
                fontColor: AppColors.grey900,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SpaceWidget(spaceHeight: 4),
            Container(
              padding: const EdgeInsets.only(top: 8, right: 8, bottom: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: TextField(
                        controller: controller.filePathController,
                        style: TextStyle(
                          color: AppColors.black500,
                          fontSize: (MediaQuery.sizeOf(context).width /
                              (MediaQuery.sizeOf(context).width / 14)),
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'No file chosen',
                        ),
                        readOnly:
                            true, // Ensures the user can't edit the text directly
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () =>
                        controller.pickVideo(context, ImageSource.gallery),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(AppColors.black50),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                          side: const BorderSide(color: AppColors.black500),
                        ),
                      ),
                    ),
                    child: const Text('Choose File'),
                  ),
                ],
              ),
            ),
            const SpaceWidget(spaceHeight: 4),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: TextWidget(
                text: 'Please Upload MP4 format only',
                fontColor: AppColors.whiteLighter,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SpaceWidget(spaceHeight: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: TextWidget(
                text: 'Event Name',
                fontColor: AppColors.grey900,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SpaceWidget(spaceHeight: 4),
            CreatorEventTextFieldWidget(
              hintText: '',
              controller: controller.eventNameController,
              maxLines: 1,
            ),
            const SpaceWidget(spaceHeight: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: TextWidget(
                text: 'Time',
                fontColor: AppColors.grey900,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SpaceWidget(spaceHeight: 4),
            CreatorEventTextFieldWidget(
              hintText: '',
              // Optional: A meaningful hint
              controller: controller.timeController,
              maxLines: 1,
              suffixIcon: Icons.calendar_today,
              onTapSuffix: () => controller.pickDateTime(context),
            ),
            const SpaceWidget(spaceHeight: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: TextWidget(
                text: 'Address',
                fontColor: AppColors.grey900,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SpaceWidget(spaceHeight: 4),
            CreatorEventTextFieldWidget(
              hintText: '',
              // Optional: A meaningful hint
              controller: controller.addressController,
              maxLines: 1,
            ),
            const SpaceWidget(spaceHeight: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: TextWidget(
                text: 'Location',
                fontColor: AppColors.grey900,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SpaceWidget(spaceHeight: 4),
            CreatorEventTextFieldWidget(
              hintText: '',
              controller: controller.locationController,
              maxLines: 1,
              suffixIcon: Icons.location_on,
              onTapSuffix: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreatorMapScreen(),
                  ),
                );

                if (result != null && result is Map<String, dynamic>) {
                  final coordinates = result['coordinates'];
                  controller.locationController.text =
                      '${coordinates[0]}, ${coordinates[1]}';
                }
              },
            ),
            const SpaceWidget(spaceHeight: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: TextWidget(
                text: 'Event Description',
                fontColor: AppColors.grey900,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SpaceWidget(spaceHeight: 4),
            CreatorEventTextFieldWidget(
              hintText: '',
              controller: controller.eventDescriptionController,
              maxLines: 1,
            ),
            const SpaceWidget(spaceHeight: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: TextWidget(
                text: 'Event Tags',
                fontColor: AppColors.grey900,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SpaceWidget(spaceHeight: 4),
            CreatorEventTextFieldWidget(
              hintText: '',
              controller: controller.eventTagController,
              maxLines: 1,
            ),
            const SpaceWidget(spaceHeight: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: TextWidget(
                text: 'Price',
                fontColor: AppColors.grey900,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SpaceWidget(spaceHeight: 4),
            CreatorEventTextFieldWidget(
              hintText: '',
              controller: controller.priceController,
              maxLines: 1,
              keyboardType: TextInputType.number,
            ),
            const SpaceWidget(spaceHeight: 32),
            ButtonWidget(
              onPressed: controller.createEvent,
              label: 'Publish Event',
              buttonWidth: double.infinity,
              buttonHeight: (MediaQuery.sizeOf(context).height /
                  (MediaQuery.sizeOf(context).height / 56)),
              buttonRadius: BorderRadius.circular(16),
            ),
          ],
        ),
      ),
    );
  }
}
