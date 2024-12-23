import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:itzel/utils/app_size.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_strings.dart';
import '../../widgets/container_widget/container_widget.dart';
import 'controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return GetBuilder<SplashController>(
      init: SplashController(),
      builder: (controller) {
        return AnnotatedRegion(
          value: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.light,
          ),
          child: Scaffold(
            body: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.blue500,
                    AppColors.blue,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: ContainerWidget(
                  containerHeight: 116,
                  containerWidth: 271,
                  borderRadius: BorderRadius.circular(16),
                  containerColor: AppColors.white,
                  padding: EdgeInsets.all(AppSize.width(value: 16)),
                  child: Center(
                    child: GradientText(
                      AppStrings.appName,
                      style: TextStyle(
                        fontSize: size.width / (size.width / 50),
                        fontWeight: FontWeight.w600,
                      ),
                      colors: const [
                        AppColors.blue500,
                        AppColors.blue,
                      ],
                      gradientType: GradientType.linear,
                      gradientDirection: GradientDirection.ttb,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
