import 'package:get/get.dart';
import 'package:itzel/screens/user/user_saved_events_screen/user_saved_events_screen.dart';
import 'package:itzel/screens/user/user_saved_jobs_screen/user_saved_jobs_screen.dart';

import '../screens/auth_screens/create_new_password_screen/create_new_password_screen.dart';
import '../screens/auth_screens/forgot_password_screen/forgot_password_screen.dart';
import '../screens/auth_screens/login_screen/login_screen.dart';
import '../screens/auth_screens/registration_screen/registration_screen.dart';
import '../screens/auth_screens/registration_verify_email_screen/registration_verify_email_screen.dart';
import '../screens/auth_screens/verify_account_screen/verify_account_screen.dart';
import '../screens/bottom_nav_screen/bottom_nav_screen.dart';
import '../screens/creator/creator_account_screen/creator_account_screen.dart';
import '../screens/creator/creator_all_chat_screen/creator_all_chat_screen.dart';
import '../screens/creator/creator_all_event_status_screen/creator_all_event_status_screen.dart';
import '../screens/creator/creator_all_job_application_screen/creator_all_job_application_screen.dart';
import '../screens/creator/creator_analytics_screen/creator_analytics_screen.dart';
import '../screens/creator/creator_business_information_screen/creator_business_information_screen.dart';
import '../screens/creator/creator_change_password_screen/creator_change_password_screen.dart';
import '../screens/creator/creator_chat_receiver_info_screen/creator_chat_receiver_info_screen.dart';
import '../screens/creator/creator_chat_screen/creator_chat_screen.dart';
import '../screens/creator/creator_dashboard_screen/creator_dashboard_screen.dart';
import '../screens/creator/creator_delete_account_screen/creator_delete_account_screen.dart';
import '../screens/creator/creator_drawer_screen/creator_drawer_screen.dart';
import '../screens/creator/creator_event_create_screen/creator_event_create_screen.dart';
import '../screens/creator/creator_faq_screen/creator_faq_screen.dart';
import '../screens/creator/creator_job_publish_screen/creator_job_publish_screen.dart';
import '../screens/creator/creator_notification_screen/creator_notification_screen.dart';
import '../screens/creator/creator_payment_method_screen/creator_payment_method_screen.dart';
import '../screens/creator/creator_post_screen/creator_post_screen.dart';
import '../screens/creator/creator_profile_screen/creator_profile_screen.dart';
import '../screens/creator/creator_subscriptions_screen/creator_subscriptions_screen.dart';
import '../screens/creator/creator_terms_condition_screen/creator_terms_condition_screen.dart';
import '../screens/error_screen/error_screen.dart';
import '../screens/splash_screen/splash_screen.dart';
import '../screens/user/user_account_screen/user_account_screen.dart';
import '../screens/user/user_all_category_screen/user_all_category_screen.dart';
import '../screens/user/user_all_chat_screen/user_all_chat_screen.dart';
import '../screens/user/user_calender_screen/user_calender_screen.dart';
import '../screens/user/user_change_password_screen/user_change_password_screen.dart';
import '../screens/user/user_chat_gpt_screen/user_chat_gpt_screen.dart';
import '../screens/user/user_chat_receiver_info_screen/user_chat_receiver_info_screen.dart';
import '../screens/user/user_chat_screen/user_chat_screen.dart';
import '../screens/user/user_delete_account_screen/user_delete_account_screen.dart';
import '../screens/user/user_drawer_screen/user_drawer_screen.dart';
import '../screens/user/user_event_screen/user_event_screen.dart';
import '../screens/user/user_faq_screen/user_faq_screen.dart';
import '../screens/user/user_give_reviews_screen/user_give_reviews_screen.dart';
import '../screens/user/user_home_details_screen/user_home_details_screen.dart';
import '../screens/user/user_home_screen/user_home_screen.dart';
import '../screens/user/user_job_applying_screen/user_job_applying_screen.dart';
import '../screens/user/user_map_screen/user_map_screen.dart';
import '../screens/user/user_notification_screen/user_notification_screen.dart';
import '../screens/user/user_profile_screen/user_profile_screen.dart';
import '../screens/user/user_review_screen/user_review_screen.dart';
import '../screens/user/user_search_screen/user_search_screen.dart';
import '../screens/user/user_terms_condition_screen/user_terms_condition_screen.dart';
import 'app_routes.dart';
import 'bindings/auth_bindings.dart';
import 'bindings/general_bindings.dart';
import 'bindings/user_bindings.dart';

class RouteManager {
  static const initial = AppRoutes.splashScreen;

  static List<GetPage> getPages() {
    return [
      GetPage(
        name: AppRoutes.splashScreen,
        page: () => SplashScreen(),
        binding: GeneralBindings(),
      ),
      GetPage(
        name: AppRoutes.registrationScreen,
        page: () => const RegistrationScreen(),
        binding: AuthBindings(),
      ),
      GetPage(
        name: AppRoutes.registrationVerifyEmailScreen,
        page: () => const RegistrationVerifyEmailScreen(),
        binding: AuthBindings(),
      ),
      GetPage(
        name: AppRoutes.loginScreen,
        page: () => const LoginScreen(),
        binding: AuthBindings(),
      ),
      GetPage(
        name: AppRoutes.forgotPasswordScreen,
        page: () => const ForgotPasswordScreen(),
        binding: AuthBindings(),
      ),
      GetPage(
        name: AppRoutes.verifyAccountScreen,
        page: () => const VerifyAccountScreen(),
        binding: AuthBindings(),
      ),
      GetPage(
        name: AppRoutes.createNewPasswordScreen,
        page: () => CreateNewPasswordScreen(),
        binding: AuthBindings(),
      ),
      GetPage(
        name: AppRoutes.bottomNavScreen,
        page: () => const BottomNavScreen(),
        // binding: BottomNavBinding(),
      ),
      GetPage(
        name: AppRoutes.chatGptScreen,
        page: () => const ChatGptScreen(),
        // binding: BottomNavBinding(),
      ),
      GetPage(
        name: AppRoutes.errorScreen,
        page: () => const ErrorScreen(),
        // binding: BottomNavBinding(),
      ),

      //User Section
      GetPage(
        name: AppRoutes.userHomeScreen,
        page: () => UserHomeScreen(),
        binding: UserBindings(),
      ),
      GetPage(
        name: AppRoutes.userHomeDetailsScreen,
        page: () => UserHomeDetailsScreen(),
        binding: GeneralBindings(),
      ),
      GetPage(
        name: AppRoutes.userSearchScreen,
        page: () => UserSearchScreen(),
        // binding: UserBindings(),
      ),
      GetPage(
        name: AppRoutes.userJobApplyingScreen,
        page: () => UserJobApplyingScreen(),
        //binding: UserBindings(),
      ),
      GetPage(
        name: AppRoutes.userAllChatScreen,
        page: () => const UserAllChatScreen(),
        binding: UserBindings(),
      ),
      GetPage(
        name: AppRoutes.userSavedEventsScreen,
        page: () => UserSavedEventsScreen(),
        //binding: UserBindings(),
      ),
      GetPage(
        name: AppRoutes.userSavedJobsScreen,
        page: () => UserSavedJobsScreen(),
        //binding: UserBindings(),
      ),
      GetPage(
        name: AppRoutes.userChatScreen,
        page: () => UserChatScreen(),
        // binding: UserBindings(),
      ),
      GetPage(
        name: AppRoutes.userChatReceiverInfoScreen,
        page: () => UserChatReceiverInfoScreen(),
        //  binding: UserBindings(),
      ),
      GetPage(
        name: AppRoutes.userEventScreen,
        page: () => const UserEventScreen(),
        binding: UserBindings(),
      ),
      GetPage(
        name: AppRoutes.userDrawerScreen,
        page: () => UserDrawerScreen(),
        // binding: UserBindings(),
      ),
      GetPage(
        name: AppRoutes.userAccountScreen,
        page: () => UserAccountScreen(),
        //binding: UserBindings(),
      ),
      GetPage(
        name: AppRoutes.userNotificationScreen,
        page: () => UserNotificationScreen(),
        // binding: UserBindings(),
      ),
      GetPage(
        name: AppRoutes.userProfileScreen,
        page: () => UserProfileScreen(),
        // binding: UserBindings(),
      ),
      GetPage(
        name: AppRoutes.userFaqScreen,
        page: () => const UserFaqScreen(),
        binding: UserBindings(),
      ),
      GetPage(
        name: AppRoutes.userTermsConditionScreen,
        page: () => const UserTermsConditionScreen(),
        //binding: UserBindings(),
      ),
      GetPage(
        name: AppRoutes.userChangePasswordScreen,
        page: () => const UserChangePasswordScreen(),
        // binding: UserBindings(),
      ),
      GetPage(
        name: AppRoutes.userDeleteAccountScreen,
        page: () => UserDeleteAccountScreen(),
        // binding: UserBindings(),
      ),
      GetPage(
        name: AppRoutes.userAllCategoryScreen,
        page: () => UserAllCategoryScreen(),
        // binding: UserBindings(),
      ),
      GetPage(
        name: AppRoutes.userReviewScreen,
        page: () => UserReviewScreen(categoryTitle: ''),
        // binding: UserBindings(),
      ),
      GetPage(
        name: AppRoutes.userMapScreen,
        page: () => UserMapScreen(),
        // binding: UserBindings(),
      ),
      GetPage(
        name: AppRoutes.userCalenderScreen,
        page: () => UserCalenderScreen(),
        // binding: UserBindings(),
      ),
      GetPage(
        name: AppRoutes.userGiveReviewsScreen,
        page: () => UserGiveReviewsScreen(),
        // binding: UserBindings(),
      ),

      //Creator Section
      GetPage(
        name: AppRoutes.creatorDashboardScreen,
        page: () => const CreatorDashboardScreen(),
        // binding: CreatorBindings(),
      ),
      GetPage(
        name: AppRoutes.creatorAllEventStatusScreen,
        page: () => CreatorAllEventStatusScreen(),
        // binding: CreatorBindings(),
      ),
      GetPage(
        name: AppRoutes.creatorAllJobApplicationScreen,
        page: () => CreatorAllJobApplicationScreen(),
        // binding: CreatorBindings(),
      ),
      GetPage(
        name: AppRoutes.creatorAllChatScreen,
        page: () => const CreatorAllChatScreen(),
        //binding: CreatorBindings(),
      ),
      GetPage(
        name: AppRoutes.creatorChatScreen,
        page: () => const CreatorChatScreen(),
        //binding: CreatorBindings(),
      ),
      GetPage(
        name: AppRoutes.creatorChatReceiverInfoScreen,
        page: () => CreatorChatReceiverInfoScreen(),
        //binding: CreatorBindings(),
      ),
      GetPage(
        name: AppRoutes.creatorAccountScreen,
        page: () => CreatorAccountScreen(),
        // binding: CreatorBindings(),
      ),
      GetPage(
        name: AppRoutes.creatorDrawerScreen,
        page: () => const CreatorDrawerScreen(),
        // binding: CreatorBindings(),
      ),
      GetPage(
        name: AppRoutes.creatorNotificationScreen,
        page: () => CreatorNotificationScreen(),
        // binding: CreatorBindings(),
      ),
      GetPage(
        name: AppRoutes.creatorProfileScreen,
        page: () => const CreatorProfileScreen(),
        // binding: CreatorBindings(),
      ),
      GetPage(
        name: AppRoutes.creatorFaqScreen,
        page: () => const CreatorFaqScreen(),
        // binding: CreatorBindings(),
      ),
      GetPage(
        name: AppRoutes.creatorTermsConditionScreen,
        page: () => const CreatorTermsConditionScreen(),
        // binding: CreatorBindings(),
      ),
      GetPage(
        name: AppRoutes.creatorChangePasswordScreen,
        page: () => const CreatorChangePasswordScreen(),
        // binding: CreatorBindings(),
      ),
      GetPage(
        name: AppRoutes.creatorDeleteAccountScreen,
        page: () => CreatorDeleteAccountScreen(),
        // binding: CreatorBindings(),
      ),
      GetPage(
        name: AppRoutes.creatorPostScreen,
        page: () => const CreatorPostScreen(),
        //  binding: CreatorBindings(),
      ),
      GetPage(
        name: AppRoutes.creatorEventCreateScreen,
        page: () => const CreatorEventCreateScreen(),
        //  binding: CreatorBindings(),
      ),
      GetPage(
        name: AppRoutes.creatorJobPublishScreen,
        page: () => const CreatorJobPublishScreen(),
        // binding: CreatorBindings(),
      ),
      GetPage(
        name: AppRoutes.creatorAnalyticsScreen,
        page: () => const CreatorAnalyticsScreen(),
        // binding: CreatorBindings(),
      ),
      GetPage(
        name: AppRoutes.creatorBusinessInformationScreen,
        page: () => const CreatorBusinessInformationScreen(),
        // binding: CreatorBindings(),
      ),
      GetPage(
        name: AppRoutes.creatorSubscriptionsScreen,
        page: () => const CreatorSubscriptionsScreen(),
        // binding: CreatorBindings(),
      ),
      GetPage(
        name: AppRoutes.creatorPaymentMethodScreen,
        page: () => const CreatorPaymentMethodScreen(),
        // binding: CreatorBindings(),
      ),
    ];
  }
}
