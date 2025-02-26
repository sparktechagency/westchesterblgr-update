import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:itzel/screens/creator/creator_business_information_screen/widgets/business_information_textfield_widget.dart';
import 'package:itzel/screens/creator/creator_business_information_screen/widgets/headerTextWidget.dart';
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
  final birthdateController = TextEditingController();
  final nameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();
  final idNumberController = TextEditingController();
  final accountHolderNameController = TextEditingController();
  final accountHolderTypeController = TextEditingController();
  final currencyController = TextEditingController();
  final routingNumberController = TextEditingController();
  final lineOneController = TextEditingController();
  final stateController = TextEditingController();
  final cityController = TextEditingController();
  final postalCodeController = TextEditingController();
  final countryController = TextEditingController();

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
    birthdateController.dispose();
    nameController.dispose();
    phoneNumberController.dispose();
    emailController.dispose();
    idNumberController.dispose();
    accountHolderNameController.dispose();
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
            const HeaderTextWidget(text: 'Personal Information'),
            const SpaceWidget(spaceHeight: 12),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: TextWidget(
                text: 'Date of Birth',
                fontColor: AppColors.grey900,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SpaceWidget(spaceHeight: 4),
            BusinessInformationTextFieldWidget(
              hintText: '',
              controller: birthdateController,
              maxLines: 1,
            ),
            const SpaceWidget(spaceHeight: 8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: TextWidget(
                text: 'Name',
                fontColor: AppColors.grey900,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SpaceWidget(spaceHeight: 4),
            BusinessInformationTextFieldWidget(
              hintText: '',
              controller: nameController,
              maxLines: 1,
            ),
            const SpaceWidget(spaceHeight: 8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: TextWidget(
                text: 'Phone Number',
                fontColor: AppColors.grey900,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SpaceWidget(spaceHeight: 4),
            BusinessInformationTextFieldWidget(
              hintText: '',
              controller: phoneNumberController,
              maxLines: 1,
              keyboardType: TextInputType.number,
            ),
            const SpaceWidget(spaceHeight: 8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: TextWidget(
                text: 'Email',
                fontColor: AppColors.grey900,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SpaceWidget(spaceHeight: 4),
            BusinessInformationTextFieldWidget(
              hintText: '',
              controller: emailController,
              maxLines: 1,
              keyboardType: TextInputType.number,
            ),
            const SpaceWidget(spaceHeight: 8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: TextWidget(
                text: 'ID Number',
                fontColor: AppColors.grey900,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SpaceWidget(spaceHeight: 4),
            BusinessInformationTextFieldWidget(
              hintText: '',
              controller: idNumberController,
              maxLines: 1,
              keyboardType: TextInputType.number,
            ),
            const SpaceWidget(spaceHeight: 12),
            const HeaderTextWidget(text: 'Bank Information'),
            const SpaceWidget(spaceHeight: 12),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: TextWidget(
                text: 'Account Holder Name',
                fontColor: AppColors.grey900,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SpaceWidget(spaceHeight: 4),
            BusinessInformationTextFieldWidget(
              hintText: '',
              controller: accountHolderNameController,
              maxLines: 1,
            ),
            const SpaceWidget(spaceHeight: 8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: TextWidget(
                text: 'Account Holder Type',
                fontColor: AppColors.grey900,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SpaceWidget(spaceHeight: 4),
            BusinessInformationTextFieldWidget(
              hintText: '',
              controller: accountHolderTypeController,
              maxLines: 1,
            ),
            const SpaceWidget(spaceHeight: 8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: TextWidget(
                text: 'Currency',
                fontColor: AppColors.grey900,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SpaceWidget(spaceHeight: 4),
            BusinessInformationTextFieldWidget(
              hintText: '',
              controller: currencyController,
              maxLines: 1,
            ),
            const SpaceWidget(spaceHeight: 8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: TextWidget(
                text: 'Routing Number',
                fontColor: AppColors.grey900,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SpaceWidget(spaceHeight: 4),
            BusinessInformationTextFieldWidget(
              hintText: '',
              controller: routingNumberController,
              maxLines: 1,
              keyboardType: TextInputType.number,
            ),
            const SpaceWidget(spaceHeight: 12),
            const TextWidget(
              text: 'Address',
              fontColor: AppColors.black500,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            const SpaceWidget(spaceHeight: 12),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: TextWidget(
                text: 'Line 1',
                fontColor: AppColors.grey900,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SpaceWidget(spaceHeight: 4),
            BusinessInformationTextFieldWidget(
              hintText: '',
              controller: lineOneController,
              maxLines: 1,
            ),
            const SpaceWidget(spaceHeight: 8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: TextWidget(
                text: 'State',
                fontColor: AppColors.grey900,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SpaceWidget(spaceHeight: 4),
            BusinessInformationTextFieldWidget(
              hintText: '',
              controller: stateController,
              maxLines: 1,
            ),
            const SpaceWidget(spaceHeight: 8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: TextWidget(
                text: 'City',
                fontColor: AppColors.grey900,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SpaceWidget(spaceHeight: 4),
            BusinessInformationTextFieldWidget(
              hintText: '',
              controller: cityController,
              maxLines: 1,
            ),
            const SpaceWidget(spaceHeight: 8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: TextWidget(
                text: 'Postal Code',
                fontColor: AppColors.grey900,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SpaceWidget(spaceHeight: 4),
            BusinessInformationTextFieldWidget(
              hintText: '',
              controller: postalCodeController,
              maxLines: 1,
            ),
            const SpaceWidget(spaceHeight: 8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: TextWidget(
                text: 'Country',
                fontColor: AppColors.grey900,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SpaceWidget(spaceHeight: 4),
            BusinessInformationTextFieldWidget(
              hintText: '',
              controller: countryController,
              maxLines: 1,
            ),
            const SpaceWidget(spaceHeight: 12),
            const TextWidget(
              text: 'Upload File',
              fontColor: AppColors.black500,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            const SpaceWidget(spaceHeight: 12),

            // upload

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
                      text: fileName ?? 'No File Chosen',
                      fontColor: AppColors.black500,
                      fontSize: 14,
                      overflow: TextOverflow.ellipsis,
                      textAlignment: TextAlign.start,
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
              text: 'Please Upload PDF, JPG format only',
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
