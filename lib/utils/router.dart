import 'package:flutter/material.dart';
import 'package:worldsocialintegrationapp/models/user_profile_detail.dart';
import 'package:worldsocialintegrationapp/screens/home_container/family/create_family.dart';
import 'package:worldsocialintegrationapp/screens/home_container/family/edit_family.dart';
import 'package:worldsocialintegrationapp/screens/home_container/family/family_leaderboard.dart';
import 'package:worldsocialintegrationapp/screens/home_container/family/family_member.dart';
import 'package:worldsocialintegrationapp/screens/home_container/family/family_screen.dart';
import 'package:worldsocialintegrationapp/screens/home_container/family/prompt_create_family.dart';
import 'package:worldsocialintegrationapp/screens/home_container/family/prompt_create_family_failed.dart';
import 'package:worldsocialintegrationapp/screens/home_container/friends/friend_fans_following.dart';
import 'package:worldsocialintegrationapp/screens/home_container/friends/visitor_screen.dart';
import 'package:worldsocialintegrationapp/screens/home_container/home_container.dart';
import 'package:worldsocialintegrationapp/screens/home_container/profile/add_moments.dart';
import 'package:worldsocialintegrationapp/screens/home_container/profile/edit_profile.dart';
import 'package:worldsocialintegrationapp/screens/home_container/profile/profile_detail_screen.dart';
import 'package:worldsocialintegrationapp/screens/home_container/settings/about_us.dart';
import 'package:worldsocialintegrationapp/screens/home_container/settings/blocked_user.dart';
import 'package:worldsocialintegrationapp/screens/home_container/settings/connected_account.dart';
import 'package:worldsocialintegrationapp/screens/home_container/settings/phone_verification.dart';
import 'package:worldsocialintegrationapp/screens/home_container/settings/privacy.dart';
import 'package:worldsocialintegrationapp/screens/home_container/settings/settings_screen.dart';
import 'package:worldsocialintegrationapp/screens/home_container/user_detail_screen.dart/user_detail_screen.dart';
import 'package:worldsocialintegrationapp/screens/onboarding/login.dart';
import 'package:worldsocialintegrationapp/screens/onboarding/models/phone_number.dart';
import 'package:worldsocialintegrationapp/screens/onboarding/phone.dart';
import 'package:worldsocialintegrationapp/screens/onboarding/reset_password.dart';
import 'package:worldsocialintegrationapp/screens/onboarding/signup.dart';
import 'package:worldsocialintegrationapp/screens/onboarding/splash.dart';
import 'package:worldsocialintegrationapp/screens/onboarding/verify_otp.dart';
import 'package:worldsocialintegrationapp/screens/onboarding/verify_phone.dart';
import 'package:worldsocialintegrationapp/widgets/media_preview.dart';
import 'package:worldsocialintegrationapp/widgets/media_preview_fullscreen.dart';
import 'package:worldsocialintegrationapp/widgets/network_image_preview_fullscreen.dart';

import '../screens/home_container/profile/comment.dart';

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

      case SignUpScreen.route:
        return MaterialPageRoute(
            builder: (_) => SignUpScreen(
                  phoneNumberModel: settings.arguments as PhoneNumberModel,
                ));

      case HomeContainer.route:
        return MaterialPageRoute(builder: (_) => const HomeContainer());
      case ProfileDeatilScreen.route:
        return MaterialPageRoute(builder: (_) => const ProfileDeatilScreen());
      case EditProfile.route:
        return MaterialPageRoute(builder: (_) => const EditProfile());
      case FriendFansFollowing.route:
        return MaterialPageRoute(
            builder: (_) => FriendFansFollowing(
                  index: settings.arguments as int,
                ));
      case VisitorScreen.route:
        return MaterialPageRoute(builder: (_) => const VisitorScreen());
      case UserDeatilScreen.route:
        return MaterialPageRoute(builder: (_) => const UserDeatilScreen());
      case SettingsScreen.route:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      case ConnectedAccountScreen.route:
        return MaterialPageRoute(
            builder: (_) => const ConnectedAccountScreen());
      case PhoneVerificationScreen.route:
        return MaterialPageRoute(
            builder: (_) => const PhoneVerificationScreen());
      case PrivacyScreen.route:
        return MaterialPageRoute(builder: (_) => const PrivacyScreen());
      case BlockedUserScreen.route:
        return MaterialPageRoute(builder: (_) => const BlockedUserScreen());
      case AboutUsScreen.route:
        return MaterialPageRoute(builder: (_) => const AboutUsScreen());
      case AddMoments.route:
        return MaterialPageRoute(builder: (_) => const AddMoments());
      case MediaPreview.route:
        return MaterialPageRoute(
            builder: (_) => MediaPreview(
                  filePathOrUrl: settings.arguments as String,
                ));
      case MediaPreviewFullScreen.route:
        return MaterialPageRoute(
            builder: (_) => MediaPreviewFullScreen(
                  filePathOrUrl: settings.arguments as String,
                ));
      case NetworkImagePreviewFullScreen.route:
        return MaterialPageRoute(
            builder: (_) => NetworkImagePreviewFullScreen(
                  filePathOrUrl: settings.arguments as String,
                ));
      case CommentScreen.route:
        return MaterialPageRoute(
            builder: (_) => CommentScreen(
                  feedId: settings.arguments as String,
                ));
      case CreateFamily.route:
        return MaterialPageRoute(builder: (_) => const CreateFamily());
      case EditFamily.route:
        return MaterialPageRoute(builder: (_) => const EditFamily());
      case FamilyLeaderboard.route:
        return MaterialPageRoute(builder: (_) => const FamilyLeaderboard());
      case FamilyMemberScreen.route:
        return MaterialPageRoute(builder: (_) => const FamilyMemberScreen());
      case FamilyScreen.route:
        return MaterialPageRoute(builder: (_) => const FamilyScreen());
      case PromptCreateFamily.route:
        return MaterialPageRoute(
            builder: (_) => PromptCreateFamily(
                  userProfileDetail: settings.arguments as UserProfileDetail,
                ));
      case PromptCreateFamilyFailed.route:
        return MaterialPageRoute(
            builder: (_) => const PromptCreateFamilyFailed());
      default:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
  }
}
