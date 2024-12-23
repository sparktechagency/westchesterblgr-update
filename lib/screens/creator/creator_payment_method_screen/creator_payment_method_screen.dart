import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itzel/screens/creator/creator_payment_method_screen/widgets/creator_payment_method_textfield_widget.dart';
import 'package:itzel/screens/creator/creator_payment_method_screen/widgets/date_picker_widget.dart';

import '../../../constants/app_colors.dart';
import '../../../widgets/appbar_widget/appbar_widget.dart';
import '../../../widgets/button_widget/button_widget.dart';
import '../../../widgets/space_widget/space_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';
import 'controllers/creator_payment_method_controller.dart';

class CreatorPaymentMethodScreen extends StatelessWidget {
  const CreatorPaymentMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: AppColors.whiteBg,
      appBar: const AppbarWidget(text: 'Payment  Method'),
      body: GetBuilder<CreatorPaymentMethodController>(
          init: CreatorPaymentMethodController(),
          builder: (controller) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      'assets/images/debitCardImage.png',
                      height: size.height / (size.height / 215),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SpaceWidget(spaceHeight: 16),
                  const TextWidget(
                    text: 'Name',
                    fontColor: AppColors.grey900,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  const SpaceWidget(spaceHeight: 4),
                  CreatorPaymentMethodTextFieldWidget(
                    hintText: '',
                    controller: controller.nameController,
                    maxLines: 1,
                  ),
                  const SpaceWidget(spaceHeight: 8),
                  const TextWidget(
                    text: 'Card Number',
                    fontColor: AppColors.grey900,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  const SpaceWidget(spaceHeight: 4),
                  CreatorPaymentMethodTextFieldWidget(
                    hintText: '',
                    controller: controller.cardNumberController,
                    maxLines: 1,
                    keyboardType: TextInputType.number,
                  ),
                  const SpaceWidget(spaceHeight: 8),
                  Row(
                    children: [
                      Expanded(
                        child: DatePickerWidget(
                          label: 'Expired Date',
                          onDateSelected: controller.setExpiryDate,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: DatePickerWidget(
                          label: 'CVV',
                          onDateSelected: controller.setCvvDate,
                        ),
                      ),
                    ],
                  ),
                  const SpaceWidget(spaceHeight: 40),
                  ButtonWidget(
                    onPressed: controller.updatePaymentMethod,
                    label: 'Update',
                    buttonWidth: double.infinity,
                  ),
                ],
              ),
            );
          }),
    );
  }
}
