import 'package:flutter/foundation.dart';

import '../utils/app_all_log/error_log.dart';

String _getDomain() {
  String serverDomain = "http://10.0.70.127:8001"; //////////// live server
  String localDomain = "http://10.0.70.127:8001"; ///////// local server
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
      "http://10.0.70.127:8001"; ///////// local server
  static const String serverDomain =
      "http://10.0.70.127:8001"; //////////// live server
  static final String domain = _getDomain();

  // static final String domain = serverDomain;
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

  static const String allEvent = "/event";
  static const String profile = "/user/profile";
  static const String updateProfile = "/user";
  static const String allCategory = "/category";
  static const String allJob = "/job";
  static const String jobApply = "/applicant/create";
  static const String myGroup = "/group/my";
  static const String createPaymentIntent = "/group/join/paymentIntent";

  // Creator
  static const String createEvent = "/event/create";
  static const String getEventStatus = "/event/status";
  static const String getAllEventStatus = "/event/status/all";
  static const String createJob = "/job/create";
}
