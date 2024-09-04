import 'package:flutter/material.dart';
import 'package:worldsocialintegrationapp/models/comment_data.dart';
import 'package:worldsocialintegrationapp/models/create_event.dart';
import 'package:worldsocialintegrationapp/models/family_id_model.dart';
import 'package:worldsocialintegrationapp/models/lucky_model.dart';
import 'package:worldsocialintegrationapp/models/report_model.dart';
import 'package:worldsocialintegrationapp/models/user_profile_detail.dart';
import 'package:worldsocialintegrationapp/screens/home_container/event/create_event_two.dart';
import 'package:worldsocialintegrationapp/screens/home_container/event/event_detail.dart';
import 'package:worldsocialintegrationapp/screens/home_container/event/event_screen.dart';
import 'package:worldsocialintegrationapp/screens/home_container/event/share_event.dart';
import 'package:worldsocialintegrationapp/screens/home_container/family/create_family.dart';
import 'package:worldsocialintegrationapp/screens/home_container/family/edit_family.dart';
import 'package:worldsocialintegrationapp/screens/home_container/family/family_leaderboard.dart';
import 'package:worldsocialintegrationapp/screens/home_container/family/family_medal.dart';
import 'package:worldsocialintegrationapp/screens/home_container/family/family_member.dart';
import 'package:worldsocialintegrationapp/screens/home_container/family/family_rule.dart';
import 'package:worldsocialintegrationapp/screens/home_container/family/family_screen.dart';
import 'package:worldsocialintegrationapp/screens/home_container/family/invitation_request.dart';
import 'package:worldsocialintegrationapp/screens/home_container/family/invite_family_member.dart';
import 'package:worldsocialintegrationapp/screens/home_container/family/prompt_create_family.dart';
import 'package:worldsocialintegrationapp/screens/home_container/family/prompt_create_family_failed.dart';
import 'package:worldsocialintegrationapp/screens/home_container/friends/friend_fans_following.dart';
import 'package:worldsocialintegrationapp/screens/home_container/friends/visitor_screen.dart';
import 'package:worldsocialintegrationapp/screens/home_container/home/search_member.dart';
import 'package:worldsocialintegrationapp/screens/home_container/home_container.dart';
import 'package:worldsocialintegrationapp/screens/home_container/mall/mall.dart';
import 'package:worldsocialintegrationapp/screens/home_container/mall/send_friend.dart';
import 'package:worldsocialintegrationapp/screens/home_container/profile/add_moments.dart';
import 'package:worldsocialintegrationapp/screens/home_container/profile/edit_profile.dart';
import 'package:worldsocialintegrationapp/screens/home_container/profile/profile_detail_screen.dart';
import 'package:worldsocialintegrationapp/screens/home_container/related/moments_screen.dart';
import 'package:worldsocialintegrationapp/screens/home_container/settings/about_us.dart';
import 'package:worldsocialintegrationapp/screens/home_container/settings/blocked_user.dart';
import 'package:worldsocialintegrationapp/screens/home_container/settings/connected_account.dart';
import 'package:worldsocialintegrationapp/screens/home_container/settings/phone_verification.dart';
import 'package:worldsocialintegrationapp/screens/home_container/settings/privacy.dart';
import 'package:worldsocialintegrationapp/screens/home_container/settings/settings_screen.dart';
import 'package:worldsocialintegrationapp/screens/home_container/user_detail_screen.dart/other_user_detail_screen.dart';
import 'package:worldsocialintegrationapp/screens/home_container/user_detail_screen.dart/report_category.dart';
import 'package:worldsocialintegrationapp/screens/home_container/user_detail_screen.dart/report_description.dart';
import 'package:worldsocialintegrationapp/screens/home_container/user_detail_screen.dart/report_subcategory.dart';
import 'package:worldsocialintegrationapp/screens/home_container/user_level/how_to_level_up.dart';
import 'package:worldsocialintegrationapp/screens/home_container/user_level/user_level.dart';
import 'package:worldsocialintegrationapp/screens/home_container/user_level/user_level_cars.dart';
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

import '../models/event_subscriber.dart';
import '../models/family_details.dart';
import '../models/send_friend_model.dart';
import '../models/whats_on_model.dart';
import '../screens/home_container/event/create_event_one.dart';
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
      case OtherUserDeatilScreen.route:
        return MaterialPageRoute(
            builder: (_) => OtherUserDeatilScreen(
                  otherUserId: settings.arguments as String,
                ));
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
                  commentData: settings.arguments as CommentData,
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
        return MaterialPageRoute(
            builder: (_) => FamilyScreen(
                  familyIdModel: settings.arguments as FamilyIdModel,
                ));
      case PromptCreateFamily.route:
        return MaterialPageRoute(
            builder: (_) => PromptCreateFamily(
                  userProfileDetail: settings.arguments as UserProfileDetail,
                ));
      case PromptCreateFamilyFailed.route:
        return MaterialPageRoute(
            builder: (_) => const PromptCreateFamilyFailed());
      case MallScreen.route:
        return MaterialPageRoute(builder: (_) => const MallScreen());
      case SendFriendScreen.route:
        return MaterialPageRoute(
            builder: (_) => SendFriendScreen(
                  sendFriendModel: settings.arguments as SendFriendModel,
                ));
      case UserLevelScreen.route:
        return MaterialPageRoute(builder: (_) => const UserLevelScreen());
      case UserLevelCars.route:
        return MaterialPageRoute(builder: (_) => const UserLevelCars());
      case HowToLevelUp.route:
        return MaterialPageRoute(builder: (_) => const HowToLevelUp());
      case InviteFamilyMember.route:
        return MaterialPageRoute(
          builder: (_) => InviteFamilyMember(
            userProfileDetail: settings.arguments as UserProfileDetail,
          ),
        );
      case FamilyMedalScreen.route:
        return MaterialPageRoute(builder: (_) => const FamilyMedalScreen());
      case FamilyRule.route:
        return MaterialPageRoute(builder: (_) => const FamilyRule());
      case InvitationRequestScreen.route:
        return MaterialPageRoute(
            builder: (_) => InvitationRequestScreen(
                  familyDetails:
                      (settings.arguments ?? FamilyDetails()) as FamilyDetails,
                ));
      case ReportCategory.route:
        return MaterialPageRoute(
          builder: (_) => ReportCategory(
            reportModel: settings.arguments as ReportModel,
          ),
        );
      case ReportSubCategory.route:
        return MaterialPageRoute(
          builder: (_) => ReportSubCategory(
            reportModel: settings.arguments as ReportModel,
          ),
        );
      case ReportDescription.route:
        return MaterialPageRoute(
          builder: (_) => ReportDescription(
            reportModel: settings.arguments as ReportModel,
          ),
        );
      case EventScreen.route:
        return MaterialPageRoute(builder: (_) => const EventScreen());
      case EventDetail.route:
        return MaterialPageRoute(
            builder: (_) => EventDetail(
                  whatsonModel: settings.arguments as WhatsonModel,
                ));
      case ShareEvent.route:
        return MaterialPageRoute(
            builder: (_) => ShareEvent(
                  event: settings.arguments as String,
                ));
      case CreateEventOne.route:
        return MaterialPageRoute(builder: (_) => const CreateEventOne());
      case CreateEventTwo.route:
        return MaterialPageRoute(
            builder: (_) => CreateEventTwo(
                  createEvent: settings.arguments as CreateEvent,
                ));
      case SearchMember.route:
        return MaterialPageRoute(builder: (_) => const SearchMember());
      case MomentsScreen.route:
        return MaterialPageRoute(builder: (_) => const MomentsScreen());
      default:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
  }
}
