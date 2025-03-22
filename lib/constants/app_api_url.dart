import 'package:flutter/foundation.dart';

import '../utils/app_all_log/error_log.dart';

String _getDomain() {
  String serverDomain = "http://139.59.0.25:3005"; //////////// live server
  String localDomain = "http://139.59.0.25:3005"; ///////// local server
  try {
    if (kReleaseMode) {
      return serverDomain;
    } else {
      return localDomain;
    }
  } catch (e) {
    errorLog("_getDomain", e);
    return serverDomain;
  }
}

class AppApiUrl {
  AppApiUrl._();

  //////////////////////////////////////  base
  static const String localDomain =
      "http://139.59.0.25:3005"; ///////// local server
  static const String serverDomain =
      "http://139.59.0.25:3005"; //////////// live server
  static final String domain = _getDomain();

  // Auth
  static final String baseUrl = "$domain/api/v1";
  static const String createUser = "/user";
  static const String createCreator = "/user";
  static const String registrationVerifyEmail = "/auth/verify-email";
  static const String verifyEmail = "/auth/verify-email";
  static const String resentOtp = "/auth/resend-verify-email";
  static const String forgotPassword = "/auth/forget-password";
  static const String resetPassword = "/auth/reset-password";
  static const String changePassword = "/auth/change-password";
  static const String login = "/auth/login";

  static const String faq = "/faq";
  static const String termsCondition = "/termsandconditions";
  static const String notification = "/notification";
  static const String unreadNotification = "/notification/count";

  // User
  static const String allEvent = "/event";
  static const String profile = "/user/profile";
  static const String updateProfile = "/user";
  static const String allCategory = "/category";
  static const String allJob = "/job";
  static const String jobApply = "/applicant/create";
  static const String myGroup = "/group/my";
  static const String createPaymentIntent = "/group/join/paymentIntent";
  static const String eventSchedule = "/user/events";
  static const String allMessage = "/message";
  static const String createMessage = "/message/create";

  // Creator
  static const String createEvent = "/event/create";
  static const String getEventStatus = "/event/status";
  static const String getAllEventStatus = "/event/status/all";
  static const String createJob = "/job/create";
  static const String getJobStatus = "/job/status";
  static const String getAllJobStatus = "/job/status/all";
  static const String getCreatorStatus = "/user/status";
  static const String subscription = "/package";
  static const String paymentAccountSetup = "/user/payment-account-setup";
  static const String creatorAnalyticsStatus = "/user/status";
  static const String creatorEarningStatus = "/user/earnings";
}
