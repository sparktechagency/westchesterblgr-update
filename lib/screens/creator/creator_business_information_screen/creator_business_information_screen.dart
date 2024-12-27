import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:itzel/screens/creator/creator_business_information_screen/widgets/business_information_textfield_widget.dart';
import 'package:itzel/widgets/button_widget/button_widget.dart';

import '../../../constants/app_colors.dart';
import '../../../widgets/appbar_widget/appbar_widget.dart';
import '../../../widgets/space_widget/space_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';

class CreatorBusinessInformationScreen extends StatefulWidget {
  const CreatorBusinessInformationScreen({super.key});

  @override
  State<CreatorBusinessInformationScreen> createState() =>
      _CreatorBusinessInformationScreenState();
}

class _CreatorBusinessInformationScreenState
    extends State<CreatorBusinessInformationScreen> {
  final businessNameController = TextEditingController();
  final businessPhoneNumberController = TextEditingController();
  final yearsInBusinessController = TextEditingController();
  final businessWebsiteOrSocialMediaController = TextEditingController();

  String? fileName;

  Future<void> pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        setState(() {
          fileName = result.files.single.name;
        });
      }
    } catch (e) {
      debugPrint('Error picking file: $e');
    }
  }

  void updateAndSave() {
    // Implement your save logic here
    print('Saving business information...');
    // You can access the values using controllers:
    // businessNameController.text
    // businessPhoneNumberController.text
    // etc.
  }

  @override
  void dispose() {
    businessNameController.dispose();
    businessPhoneNumberController.dispose();
    yearsInBusinessController.dispose();
    businessWebsiteOrSocialMediaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: AppColors.whiteBg,
      appBar: const AppbarWidget(text: 'Business Information'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: TextWidget(
                text: 'Business Name',
                fontColor: AppColors.grey900,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SpaceWidget(spaceHeight: 4),
            BusinessInformationTextFieldWidget(
              hintText: '',
              controller: businessNameController,
              maxLines: 1,
            ),
            const SpaceWidget(spaceHeight: 8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: TextWidget(
                text: 'Business Phone Number',
                fontColor: AppColors.grey900,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SpaceWidget(spaceHeight: 4),
            BusinessInformationTextFieldWidget(
              hintText: '',
              controller: businessPhoneNumberController,
              maxLines: 1,
              keyboardType: TextInputType.number,
            ),
            const SpaceWidget(spaceHeight: 8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: TextWidget(
                text: 'Years in Business',
                fontColor: AppColors.grey900,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SpaceWidget(spaceHeight: 4),
            BusinessInformationTextFieldWidget(
              hintText: '',
              controller: yearsInBusinessController,
              maxLines: 1,
              keyboardType: TextInputType.number,
            ),
            const SpaceWidget(spaceHeight: 8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: TextWidget(
                text: 'Business Website or Social Media',
                fontColor: AppColors.grey900,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SpaceWidget(spaceHeight: 4),
            BusinessInformationTextFieldWidget(
              hintText: '',
              controller: businessWebsiteOrSocialMediaController,
              maxLines: 1,
            ),
            const SpaceWidget(spaceHeight: 8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: TextWidget(
                text: 'Upload Business License(If Available)',
                fontColor: AppColors.grey900,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SpaceWidget(spaceHeight: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: (size.width / (size.width / 165)),
                    child: TextWidget(
                      text:
                          fileName ?? 'Upload Business License (If Available)',
                      fontColor: AppColors.black500,
                      fontSize: 14,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: pickFile,
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
            const TextWidget(
              text: 'Please Upload JPG format only',
              fontColor: AppColors.whiteLighter,
              fontSize: 10,
              fontWeight: FontWeight.w400,
            ),
            const SpaceWidget(spaceHeight: 36),
            ButtonWidget(
              onPressed: updateAndSave,
              label: 'Update & Save',
              buttonWidth: double.infinity,
            ),
          ],
        ),
      ),
    );
  }
}
