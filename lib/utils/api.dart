class API {
  static const String privacyPolicy = 'https://wows.co.in/Privacy-policy.html';
  static const String termsOfService =
      'https://wows.co.in/Terms-and-Condition.html';

  // static const String baseUrl = 'https://api.wows.co.in';
  static const String baseUrl = 'https://apiwows.xrdsimulators.tech';
  static const String generateToken = '$baseUrl/generateToken';
  static const String socialLogin = '$baseUrl/socialLogin';
  static const String addSocialIds = '$baseUrl/addSocialIds';
  static const String removeSocialIds = '$baseUrl/removeSocialIds';
  static const String checkNumber = '$baseUrl/checkNumber';
  static const String registration = '$baseUrl/registration';
  static const String mobileLogin = '$baseUrl/mobileLogin';
  static const String getUserDataById = '$baseUrl/getUserDetails';
  static const String updateUserProfile = '$baseUrl/updateUserProfile';
  static const String updatePhoneNumber = '$baseUrl/updatePhoneNumber';
  static const String userPostAndVideo = '$baseUrl/userPostAndVideo';
  static const String feedDetails = '$baseUrl/feedDetails';
  static const String likeDislike = '$baseUrl/likeDislike';
  static const String resetPassword = '$baseUrl/resetPassword';
  static const String getComments = '$baseUrl/getComments';
  static const String addComment = '$baseUrl/addComment';
  static const String deleteComment = '$baseUrl/deleteComment';
  static const String removeUserPost = '$baseUrl/removeUserPost';
  static const String getFamiliesDetails = '$baseUrl/getFamiliesDetails';
  static const String getLiveJoiners = '$baseUrl/getLiveJoiners';
  static const String getFamilyLevelDetail = '$baseUrl/getFamilyLevelDetail';
  static const String createFamily = '$baseUrl/createFamily';
  static const String editFamily = '$baseUrl/editFamily';
  static const String getTopGifter = '$baseUrl/getTopGifter';
  static const String getSingleFamilyDetails =
      '$baseUrl/get_single_family_details';
  static const String searchUsers = '$baseUrl/searchUsers';
  static const String sendJoinRequest = '$baseUrl/sendJoinRequest';
  static const String sendInvitation = '$baseUrl/sendInvitation';
  static const String leavefamilyGroup = '$baseUrl/leavefamilyGroup';
  static const String familyAdminRemove = '$baseUrl/family_admin_remove';
  static const String getJoinRequest = '$baseUrl/getJoinRequest';
  static const String getInvitations = '$baseUrl/getInvitations';
  static const String responseJoinRequest = '$baseUrl/responseJoinRequest';
  static const String responseInvitation = '$baseUrl/responseInvitation';
  static const String getLevelList = '$baseUrl/getLevelList';
  static const String getCarsByLevel = '$baseUrl/getCarsByLevel';
  static const String getLuckyId = '$baseUrl/getLuckyId';
  static const String purchaseLuckyId = '$baseUrl/purchaseLuckyId';
  static const String getFriendsDetails = '$baseUrl/getFriendsDetails';
  static const String sendLuckyId = '$baseUrl/sendLuckyId';
  static const String getFrames = '$baseUrl/getFrames';
  static const String purchaseFrames = '$baseUrl/purchaseFrames';
  static const String sendFrames = '$baseUrl/sendFrames';
  static const String getUserReportTypeCategories =
      '$baseUrl/getUserReportTypeCategories';
  static const String getUserReportTypeSubCategories =
      '$baseUrl/getUserReportTypeSubCategories';
  static const String setVisitor = '$baseUrl/setVisitor';
  static const String blockUnblock = '$baseUrl/blockUnblock';
  static const String followUnfollow = '$baseUrl/followUnfollow';
  static const String getSetVisitor = '$baseUrl/getSetVisitor';
  static const String acceptFriendRequest = '$baseUrl/acceptFriendRequest';
  static const String getFollowingDetails = '$baseUrl/getFollowingDetails';
  static const String getFollowersDetails = '$baseUrl/getFollowersDetails';
  static const String userReport = '$baseUrl/userReport';
  static const String getAllEvents = '$baseUrl/getAllEvents';
  static const String subscribeUnSubscribeEvent =
      '$baseUrl/subscribeUnSubscribeEvent';
  static const String eventSubscriberDetails =
      '$baseUrl/eventSubscriberDetails';
  static const String sendEventInvitation = '$baseUrl/sendEventInvitation';
  static const String createEvent = '$baseUrl/createEvent';
  static const String getAllUserPost = '$baseUrl/getAllUserPost';
  static const String getFriendsPosts = '$baseUrl/getFriendsPosts';
  static const String getPurchaseLuckyId = '$baseUrl/getPurchaseLuckyId';
  static const String getPurchaseFrame = '$baseUrl/getPurchaseFrame';
  static const String getPurchaseThemes = '$baseUrl/getPurchaseThemes';
  static const String getVipImages = '$baseUrl/getVipImages';
  static const String applyLuckyId = '$baseUrl/applyLuckyId';
  static const String applyFrame = '$baseUrl/applyFrame';
  static const String applyTheme = '$baseUrl/applyTheme';
  static const String applyVip = '$baseUrl/applyVip';
  static const String getTopGiftReceiver = '$baseUrl/getTopGiftReceiver';
  static const String getSenderReceiverGifting =
      '$baseUrl/getSenderReceiverGifting';
  static const String hideUnHideCountry = '$baseUrl/hideUnHideCountry';
  static const String getBlockUsers = '$baseUrl/getBlockUsers';
  static const String agoraToken = '$baseUrl/agoraToken';
  static const String getPopularUserLive = '$baseUrl/getPopularUserLive';
  static const String setLiveImage = '$baseUrl/setLiveImage';
  static const String lockUserLive = '$baseUrl/lockUserLive';
  static const String getSpinWheelDetails = '$baseUrl/getSpinWheelDetails';
  static const String hitSpinWheel = '$baseUrl/hitSpinWheel';
  static const String checkSpinWheel = '$baseUrl/checkSpinWheel';
  static const String getNewLiveUsers = '$baseUrl/getNewLiveUsers';
  static const String getGamesBanner = '$baseUrl/getGamesBanner';
  static const String getLeaderBoard = '$baseUrl/getLeaderBoard';
  static const String get_agencies = '$baseUrl/get_agencies';
  static const String hostApi = '$baseUrl/hostApi';
  static const String getHost = '$baseUrl/getHost';
  static const String claim_garage = '$baseUrl/claim_garage';
  static const String getAppliedFrame = '$baseUrl/getAppliedFrame';
  static const String getThemes = '$baseUrl/getThemes';
  static const String getImages = '$baseUrl/getImages';
  static const String purchaseThemes = '$baseUrl/purchaseThemes';
  static const String getGallery = '$baseUrl/getGallery';
  static const String purchaseGallery = '$baseUrl/purchaseGallery';
  static const String sendThemes = '$baseUrl/sendThemes';
  static const String sendGallery = '$baseUrl/sendGallery';
  static const String hideUnHideLiveUser = '$baseUrl/hideUnHideLiveUser';
  static const String getEmoji = '$baseUrl/getEmoji';
  static const String getPrimeGift = '$baseUrl/getPrimeGift';
  static const String userActivityDaily = '$baseUrl/userActivityDaily';
  static const String addLiveExp = '$baseUrl/addLiveExp';
  static const String sendGift = '$baseUrl/sendGift';
  static const String kickOutLiveUser = '$baseUrl/kickOutLiveUser';
  static const String getLiveGifting = '$baseUrl/getLiveGifting';
  static const String getTotalLiveGifting = '$baseUrl/getTotalLiveGifting';
  static const String getReceiverGiftHistory =
      '$baseUrl/getReceiverGiftHistory';
  static const String nearByUsers = '$baseUrl/nearByUsers';
  static const String archieveLive = '$baseUrl/archieveLive';
  static const String listGameSectionDetails =
      '$baseUrl/listGameSectionDetails';
  static const String addBankAccountDetails = '$baseUrl/addBankAccountDetails';
  static const String getUserBankDetails = '$baseUrl/getUserBankDetails';
  static const String checkWithdrawal = '$baseUrl/checkWithdrawal';
  static const String generateWithdrawalRequest =
      '$baseUrl/generateWithdrawalRequest';
  static const String getWalletDetails = '$baseUrl/getWalletDetails';
  static const String exchangeCoins = '$baseUrl/exchangeCoins';
  static const String get_user_live_details_by_dates =
      '$baseUrl/get_user_live_details_by_dates';
  static const String getCoinValue = '$baseUrl/getCoinValue';
  static const String purchaseSilverCoin = '$baseUrl/purchaseSilverCoin';
  static const String getUserWallet = '$baseUrl/getUserWallet';
  static const String orderIdGenerate = '$baseUrl/orderIdGenerate';
  static const String getTotalSilverCoins = '$baseUrl/getTotalSilverCoins';
  static const String getSilverCoinValue = '$baseUrl/getSilverCoinValue';
}
