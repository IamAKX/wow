import 'package:flutter/material.dart';
import 'package:worldsocialintegrationapp/screens/home_container/home_container.dart';
import 'package:worldsocialintegrationapp/screens/onboarding/login.dart';
import 'package:worldsocialintegrationapp/screens/onboarding/models/phone_number.dart';
import 'package:worldsocialintegrationapp/screens/onboarding/phone.dart';
import 'package:worldsocialintegrationapp/screens/onboarding/reset_password.dart';
import 'package:worldsocialintegrationapp/screens/onboarding/splash.dart';
import 'package:worldsocialintegrationapp/screens/onboarding/verify_otp.dart';
import 'package:worldsocialintegrationapp/screens/onboarding/verify_phone.dart';

class NavRoute {
  static MaterialPageRoute<dynamic> generatedRoute(RouteSettings settings) {
    switch (settings.name) {
      case SplashScreen.route:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case PhoneScreen.route:
        return MaterialPageRoute(builder: (_) => const PhoneScreen());
      case VerifyPhoneScreen.route:
        return MaterialPageRoute(
            builder: (_) => VerifyPhoneScreen(
                  phoneNumberModel: settings.arguments as PhoneNumberModel,
                ));
      case VerifyOtpScreen.route:
        return MaterialPageRoute(
            builder: (_) => VerifyOtpScreen(
                  phoneNumberModel: settings.arguments as PhoneNumberModel,
                ));
      case LoginScreen.route:
        return MaterialPageRoute(
            builder: (_) => LoginScreen(
                  phoneNumberModel: settings.arguments as PhoneNumberModel,
                ));
      case ResetPasswordScreen.route:
        return MaterialPageRoute(
            builder: (_) => ResetPasswordScreen(
                  phoneNumberModel: settings.arguments as PhoneNumberModel,
                ));
      case HomeContainer.route:
        return MaterialPageRoute(builder: (_) => const HomeContainer());
      default:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
  }
}
