import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:itzel/screens/creator/creator_business_information_screen/widgets/business_information_textfield_widget.dart';
import 'package:itzel/screens/creator/creator_business_information_screen/widgets/headerTextWidget.dart';
import 'package:itzel/screens/creator/creator_business_information_screen/widgets/title_text_widget.dart';
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
  Uint8List? fileData;

  Future<void> pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        setState(() {
          fileName = result.files.single.name;
          fileData = result.files.single.bytes;
        });
      }
    } catch (e) {
      debugPrint('Error picking file: $e');
    }
  }

  @override
  void dispose() {
    birthdateController.dispose();
    nameController.dispose();
    phoneNumberController.dispose();
    emailController.dispose();
    idNumberController.dispose();
    accountHolderNameController.dispose();
    accountHolderTypeController.dispose();
    currencyController.dispose();
    routingNumberController.dispose();
    lineOneController.dispose();
    stateController.dispose();
    cityController.dispose();
    postalCodeController.dispose();
    countryController.dispose();
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
            const TitleTextWidget(text: 'Date of Birth'),
            const SpaceWidget(spaceHeight: 4),
            BusinessInformationTextFieldWidget(
              hintText: '',
              controller: birthdateController,
              maxLines: 1,
            ),
            const SpaceWidget(spaceHeight: 8),
            const TitleTextWidget(text: 'Name'),
            const SpaceWidget(spaceHeight: 4),
            BusinessInformationTextFieldWidget(
              hintText: '',
              controller: nameController,
              maxLines: 1,
            ),
            const SpaceWidget(spaceHeight: 8),
            const TitleTextWidget(text: 'Phone Number'),
            const SpaceWidget(spaceHeight: 4),
            BusinessInformationTextFieldWidget(
              hintText: '',
              controller: phoneNumberController,
              maxLines: 1,
              keyboardType: TextInputType.number,
            ),
            const SpaceWidget(spaceHeight: 8),
            const TitleTextWidget(text: 'Email'),
            const SpaceWidget(spaceHeight: 4),
            BusinessInformationTextFieldWidget(
              hintText: '',
              controller: emailController,
              maxLines: 1,
            ),
            const SpaceWidget(spaceHeight: 8),
            const TitleTextWidget(text: 'ID Number'),
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
            const TitleTextWidget(text: 'Account Holder Name'),

            const SpaceWidget(spaceHeight: 4),
            BusinessInformationTextFieldWidget(
              hintText: '',
              controller: accountHolderNameController,
              maxLines: 1,
            ),
            const SpaceWidget(spaceHeight: 8),
            const TitleTextWidget(text: 'Account Holder Type'),

            const SpaceWidget(spaceHeight: 4),
            BusinessInformationTextFieldWidget(
              hintText: '',
              controller: accountHolderTypeController,
              maxLines: 1,
            ),
            const SpaceWidget(spaceHeight: 8),
            const TitleTextWidget(text: 'Currency'),

            const SpaceWidget(spaceHeight: 4),
            BusinessInformationTextFieldWidget(
              hintText: '',
              controller: currencyController,
              maxLines: 1,
            ),
            const SpaceWidget(spaceHeight: 8),
            const TitleTextWidget(text: 'Routing Number'),

            const SpaceWidget(spaceHeight: 4),
            BusinessInformationTextFieldWidget(
              hintText: '',
              controller: routingNumberController,
              maxLines: 1,
              keyboardType: TextInputType.number,
            ),
            const SpaceWidget(spaceHeight: 12),
            const HeaderTextWidget(text: 'Address'),
            const SpaceWidget(spaceHeight: 12),
            const TitleTextWidget(text: 'Line 1'),

            const SpaceWidget(spaceHeight: 4),
            BusinessInformationTextFieldWidget(
              hintText: '',
              controller: lineOneController,
              maxLines: 1,
            ),
            const SpaceWidget(spaceHeight: 8),
            const TitleTextWidget(text: 'State'),

            const SpaceWidget(spaceHeight: 4),
            BusinessInformationTextFieldWidget(
              hintText: '',
              controller: stateController,
              maxLines: 1,
            ),
            const SpaceWidget(spaceHeight: 8),
            const TitleTextWidget(text: 'City'),

            const SpaceWidget(spaceHeight: 4),
            BusinessInformationTextFieldWidget(
              hintText: '',
              controller: cityController,
              maxLines: 1,
            ),
            const SpaceWidget(spaceHeight: 8),
            const TitleTextWidget(text: 'Postal Code'),

            const SpaceWidget(spaceHeight: 4),
            BusinessInformationTextFieldWidget(
              hintText: '',
              controller: postalCodeController,
              maxLines: 1,
            ),
            const SpaceWidget(spaceHeight: 8),
            const TitleTextWidget(text: 'Country'),

            const SpaceWidget(spaceHeight: 4),
            BusinessInformationTextFieldWidget(
              hintText: '',
              controller: countryController,
              maxLines: 1,
            ),
            const SpaceWidget(spaceHeight: 12),
            const HeaderTextWidget(text: 'Upload File'),
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
              onPressed: () {},
              label: 'Update & Save',
              buttonWidth: double.infinity,
            ),
          ],
        ),
      ),
    );
  }
}
