import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../routes/app_routes.dart';
import '../../../widgets/button_widget/button_widget.dart';
import '../../../widgets/checkbox_widget/checkbox_widget.dart';
import '../../../widgets/gradient_text_widget/gradient_text_widget.dart';
import '../../../widgets/space_widget/space_widget.dart';
import '../../../widgets/text_field_widget/text_field_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool isCreator = false;
  bool isUserChecked = false;
  bool isCreatorChecked = false;

  final userFormKey = GlobalKey<FormState>();
  final creatorFormKey = GlobalKey<FormState>();

  final userNameController = TextEditingController();
  final userEmailController = TextEditingController();
  final userPasswordController = TextEditingController();
  final userConfirmPasswordController = TextEditingController();

  final creatorNameController = TextEditingController();
  final creatorEmailController = TextEditingController();
  final creatorPasswordController = TextEditingController();
  final creatorConfirmPasswordController = TextEditingController();

  void toggleRole(bool isCreatorSelected) {
    setState(() {
      isCreator = isCreatorSelected;
    });
  }

  void toggleUserChecked(bool value) {
    setState(() {
      isUserChecked = value;
    });
  }

  void toggleCreatorChecked(bool value) {
    setState(() {
      isCreatorChecked = value;
    });
  }

  void submitForm() {
    final formKey = isCreator ? creatorFormKey : userFormKey;
    final nameController =
        isCreator ? creatorNameController : userNameController;
    final emailController =
        isCreator ? creatorEmailController : userEmailController;
    final passwordController =
        isCreator ? creatorPasswordController : userPasswordController;
    final confirmPasswordController = isCreator
        ? creatorConfirmPasswordController
        : userConfirmPasswordController;
    final isChecked = isCreator ? isCreatorChecked : isUserChecked;

    if (formKey.currentState!.validate() && isChecked) {
      if (passwordController.text != confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Passwords do not match')),
        );
        return;
      }

      String userRole = isCreator ? 'Creator' : 'User';

      Navigator.pushReplacementNamed(context, AppRoutes.bottomNavScreen,
          arguments: userRole);
      nameController.clear();
      emailController.clear();
      passwordController.clear();
      confirmPasswordController.clear();
    } else if (!isChecked) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please accept terms of service')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields correctly')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: AppColors.grey100,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SpaceWidget(spaceHeight: 80),
                const Center(
                  child: TextWidget(
                    text: 'Create Account',
                    fontColor: AppColors.black500,
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SpaceWidget(spaceHeight: 12),
                const Center(
                  child: TextWidget(
                    text: 'Choose your role before creating\nyour account.',
                    fontColor: AppColors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    maxLines: 2,
                  ),
                ),
                const SpaceWidget(spaceHeight: 24),
                // Role Selection Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () => toggleRole(false),
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      child: Container(
                        height: MediaQuery.sizeOf(context).height /
                            (MediaQuery.sizeOf(context).height / 48),
                        width: MediaQuery.sizeOf(context).width /
                            (MediaQuery.sizeOf(context).width / 165),
                        decoration: BoxDecoration(
                          gradient: !isCreator
                              ? const LinearGradient(
                                  colors: [AppColors.blue500, AppColors.blue],
                                )
                              : const LinearGradient(
                                  colors: [
                                    AppColors.blue200,
                                    AppColors.blue200
                                  ],
                                ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                        ),
                        child: Center(
                          child: Text(
                            'User',
                            style: TextStyle(
                              color: AppColors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: (MediaQuery.sizeOf(context).width /
                                  (MediaQuery.sizeOf(context).width / 16)),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SpaceWidget(spaceWidth: 16),
                    InkWell(
                      onTap: () => toggleRole(true),
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      child: Container(
                        height: MediaQuery.sizeOf(context).height /
                            (MediaQuery.sizeOf(context).height / 48),
                        width: MediaQuery.sizeOf(context).width /
                            (MediaQuery.sizeOf(context).width / 165),
                        decoration: BoxDecoration(
                          gradient: isCreator
                              ? const LinearGradient(
                                  colors: [AppColors.blue500, AppColors.blue],
                                )
                              : const LinearGradient(
                                  colors: [
                                    AppColors.blue200,
                                    AppColors.blue200
                                  ],
                                ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                        ),
                        child: Center(
                          child: Text(
                            'Creator',
                            style: TextStyle(
                              color: AppColors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: (MediaQuery.sizeOf(context).width /
                                  (MediaQuery.sizeOf(context).width / 16)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SpaceWidget(spaceHeight: 24),

                // Registration Form
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.sizeOf(context).width /
                          (MediaQuery.sizeOf(context).width / 24)),
                  child: Form(
                    key: isCreator ? creatorFormKey : userFormKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFieldWidget(
                          controller: isCreator
                              ? creatorNameController
                              : userNameController,
                          hintText: 'Name',
                          maxLines: 1,
                          validator: (value) =>
                              value!.isEmpty ? "Enter Name" : null,
                        ),
                        const SpaceWidget(spaceHeight: 12),
                        TextFieldWidget(
                          controller: isCreator
                              ? creatorEmailController
                              : userEmailController,
                          hintText: 'Email',
                          maxLines: 1,
                          validator: (value) {
                            bool emailValid =
                                RegExp(r"^[^\s@]+@[^\s@]+\.[^\s@]+$")
                                    .hasMatch(value!);
                            if (value.isEmpty) return "Enter Email";
                            if (!emailValid) return "Enter valid Email";
                            return null;
                          },
                        ),
                        const SpaceWidget(spaceHeight: 12),
                        TextFieldWidget(
                          controller: isCreator
                              ? creatorPasswordController
                              : userPasswordController,
                          hintText: 'Password',
                          maxLines: 1,
                          validator: (value) => value!.length < 6
                              ? "Password length should be more than 6 characters"
                              : null,
                          suffixIcon: Icons.visibility_off_outlined,
                        ),
                        const SpaceWidget(spaceHeight: 12),
                        TextFieldWidget(
                          controller: isCreator
                              ? creatorConfirmPasswordController
                              : userConfirmPasswordController,
                          hintText: 'Confirm Password',
                          maxLines: 1,
                          validator: (value) => value!.length < 6
                              ? "Password length should be more than 6 characters"
                              : null,
                          suffixIcon: Icons.visibility_off_outlined,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CheckboxWidget(
                              value:
                                  isCreator ? isCreatorChecked : isUserChecked,
                              onChanged: (value) {
                                if (isCreator) {
                                  toggleCreatorChecked(value ?? false);
                                } else {
                                  toggleUserChecked(value ?? false);
                                }
                              },
                              activeColor: isCreator
                                  ? AppColors.blue500
                                  : AppColors.blue500,
                              unselectedColor: Colors.grey,
                            ),
                            const SpaceWidget(spaceWidth: 8),
                            const TextWidget(
                              text: 'I agree with',
                              fontColor: AppColors.black400,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              maxLines: 2,
                            ),
                            TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: const Size(50, 30),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                alignment: Alignment.center,
                              ),
                              child: GradientTextWidget(
                                text: 'terms',
                                fontWeight: FontWeight.w400,
                                textSize: (MediaQuery.sizeOf(context).width /
                                    (MediaQuery.sizeOf(context).width / 14)),
                              ),
                            ),
                            const TextWidget(
                              text: 'of service and',
                              fontColor: AppColors.black400,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              maxLines: 2,
                            ),
                            TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: const Size(50, 30),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                alignment: Alignment.center,
                              ),
                              child: GradientTextWidget(
                                text: 'policy',
                                fontWeight: FontWeight.w400,
                                textSize: (MediaQuery.sizeOf(context).width /
                                    (MediaQuery.sizeOf(context).width / 14)),
                              ),
                            ),
                          ],
                        ),
                        const SpaceWidget(spaceHeight: 50),
                        ButtonWidget(
                          onPressed: submitForm,
                          label: 'Create Account',
                          buttonWidth: double.infinity,
                          buttonHeight: 56,
                        ),
                        const SpaceWidget(spaceHeight: 20),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const TextWidget(
                              text: 'Already have an account?',
                              fontColor: AppColors.grey900,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              maxLines: 2,
                            ),
                            const SpaceWidget(spaceWidth: 8),
                            TextButton(
                              onPressed: () {
                                Get.toNamed(AppRoutes.loginScreen);
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: const Size(50, 30),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                alignment: Alignment.center,
                              ),
                              child: GradientTextWidget(
                                text: 'Sign in',
                                fontWeight: FontWeight.w500,
                                textSize: (MediaQuery.sizeOf(context).width /
                                    (MediaQuery.sizeOf(context).width / 14)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SpaceWidget(spaceHeight: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
