import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_images_path.dart';
import '../../../constants/app_strings.dart';
import '../../../widgets/space_widget/space_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';
import '../user_review_screen/user_review_screen.dart';
import '../user_search_screen/widgets/search_text_field_widget.dart';

class UserAllCategoryScreen extends StatelessWidget {
  final searchController = TextEditingController();

  final List<String> allCategoryImages = [
    AppImagesPath.educationImage,
    AppImagesPath.healthImage,
    AppImagesPath.spaImage,
    AppImagesPath.travelImage,
    AppImagesPath.eventImage,
    AppImagesPath.shoppingImage,
    AppImagesPath.technologyImage,
    AppImagesPath.communityImage,
    AppImagesPath.sportsImage,
    AppImagesPath.familyImage,
  ];
  final List<String> allCategoryTitles = [
    AppStrings.education,
    AppStrings.health,
    AppStrings.spa,
    AppStrings.travel,
    AppStrings.event,
    AppStrings.shopping,
    AppStrings.technology,
    AppStrings.community,
    AppStrings.sports,
    AppStrings.family,
  ];

  UserAllCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: AppColors.whiteBg,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SpaceWidget(spaceHeight: 24),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width / (size.width / 20)),
                child: SearchTextFieldWidget(
                  hintText: 'Search',
                  controller: searchController,
                  maxLines: 1,
                ),
              ),
              const SpaceWidget(spaceHeight: 16),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width / (size.width / 20)),
                child: const TextWidget(
                  text: AppStrings.allCategories,
                  fontColor: AppColors.black500,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SpaceWidget(spaceHeight: 24),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 8.0,
                crossAxisCount: 3,
                childAspectRatio: 2 / 3,
                // Generate 100 widgets that display their index in the List.
                children: List.generate(allCategoryImages.length, (index) {
                  return InkWell(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserReviewScreen(
                            categoryTitle: allCategoryTitles[index],
                          ),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset(
                            allCategoryImages[index],
                            height: size.width / (size.width / 103),
                            width: size.width / (size.width / 103),
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SpaceWidget(spaceHeight: 8),
                        TextWidget(
                          text: allCategoryTitles[index],
                          fontColor: AppColors.black500,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
