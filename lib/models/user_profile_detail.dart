class UserProfileDetail {
  String? id;
  String? name;
  String? username;
  String? familyId;
  String? phone;
  String? facebookUserName;
  String? email;
  String? hostStatus;
  String? socialId;
  String? fbSocialId;
  String? snapSocialId;
  String? myExp;
  String? myRecieveExperience;
  String? vipLevel;
  String? vipFrom;
  String? vipTo;
  String? myLevel;
  String? receivingLevel;
  String? myCoin;
  String? myDiamond;
  String? totalSendDiamond;
  String? myRecievedDiamond;
  String? dob;
  String? bio;
  String? country;
  String? continent;
  String? countryShowUnshow;
  String? myFrame;
  String? myGallery;
  String? myLuckyId;
  String? myTheme;
  String? myThemeType;
  String? emailVerifiedAt;
  String? password;
  String? salt;
  String? isAdmin;
  String? image;
  String? langId;
  String? age;
  String? gender;
  String? devId;
  String? regId;
  String? latitude;
  String? longitude;
  String? devType;
  String? rememberToken;
  String? loginOtp;
  String? loginType;
  String? registerType;
  String? createdAt;
  String? updatedAt;
  String? phoneUpOtp;
  String? eventId;
  String? isEventCreater;
  String? isEventSubscriber;
  String? isFamilyLeader;
  String? isFamilyMember;
  String? monthlyCoins;
  String? hoursLive;
  String? talentLevel;
  String? basicSalary;
  String? userBanStatus;
  String? idBannedFrom;
  String? idBannedTo;
  bool? liveStatus;
  String? liveimage;
  String? imageText;
  String? imageTitle;
  String? fixedValidDay;
  String? fixedMinutes;
  String? fixedCoins;
  String? friendsLimit;
  String? followingLimit;
  String? isVipOneEnable;
  String? isVipTwoEnable;
  String? isVipThreeEnable;
  String? isVipFourEnable;
  String? isVipFiveEnable;
  String? familyName;
  String? familyImage;
  String? followersCount;
  String? followingCount;
  bool? agencyCreater;
  bool? coinAgencyCreater;
  String? visitorsCount;
  String? friendsCount;
  bool? followStatus;
  bool? blockStatus;
  bool? vipStatus;
  UserLive? userLive;
  bool? hideStatus;
  bool? kickOutStatus;
  VipDetails? vipDetails;
  String? profileImage;
  bool? idBannedStatus;
  bool? familyJoinStatus;
  String? familyJoinId;
  String? familyJoinName;
  bool? agencyStatus;
  String? hostRequest;
  int? friendCount;
  String? archivedTime;
  LavelInfomation? lavelInfomation;
  String? myFrameImageLink;
  String? myEntryEffectImageLink;

  UserProfileDetail(
      {this.id,
      this.name,
      this.username,
      this.familyId,
      this.phone,
      this.facebookUserName,
      this.email,
      this.hostStatus,
      this.socialId,
      this.fbSocialId,
      this.snapSocialId,
      this.myExp,
      this.myRecieveExperience,
      this.vipLevel,
      this.vipFrom,
      this.vipTo,
      this.myLevel,
      this.receivingLevel,
      this.myCoin,
      this.myDiamond,
      this.totalSendDiamond,
      this.myRecievedDiamond,
      this.dob,
      this.bio,
      this.country,
      this.continent,
      this.countryShowUnshow,
      this.myFrame,
      this.myGallery,
      this.myLuckyId,
      this.myTheme,
      this.myThemeType,
      this.emailVerifiedAt,
      this.password,
      this.salt,
      this.isAdmin,
      this.image,
      this.langId,
      this.age,
      this.gender,
      this.devId,
      this.regId,
      this.latitude,
      this.longitude,
      this.devType,
      this.rememberToken,
      this.loginOtp,
      this.loginType,
      this.registerType,
      this.createdAt,
      this.updatedAt,
      this.phoneUpOtp,
      this.eventId,
      this.isEventCreater,
      this.isEventSubscriber,
      this.isFamilyLeader,
      this.isFamilyMember,
      this.monthlyCoins,
      this.hoursLive,
      this.talentLevel,
      this.basicSalary,
      this.userBanStatus,
      this.idBannedFrom,
      this.idBannedTo,
      this.liveStatus,
      this.liveimage,
      this.imageText,
      this.imageTitle,
      this.fixedValidDay,
      this.fixedMinutes,
      this.fixedCoins,
      this.friendsLimit,
      this.followingLimit,
      this.isVipOneEnable,
      this.isVipTwoEnable,
      this.isVipThreeEnable,
      this.isVipFourEnable,
      this.isVipFiveEnable,
      this.familyName,
      this.familyImage,
      this.followersCount,
      this.followingCount,
      this.agencyCreater,
      this.coinAgencyCreater,
      this.visitorsCount,
      this.friendsCount,
      this.followStatus,
      this.blockStatus,
      this.vipStatus,
      this.userLive,
      this.hideStatus,
      this.kickOutStatus,
      this.vipDetails,
      this.profileImage,
      this.idBannedStatus,
      this.familyJoinStatus,
      this.familyJoinId,
      this.familyJoinName,
      this.agencyStatus,
      this.hostRequest,
      this.friendCount,
      this.archivedTime,
      this.lavelInfomation,
      this.myFrameImageLink,
      this.myEntryEffectImageLink});

  UserProfileDetail.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    familyId = json['familyId'];
    phone = json['phone'];
    facebookUserName = json['facebookUserName'];
    email = json['email'];
    hostStatus = json['host_status'];
    socialId = json['social_id'];
    fbSocialId = json['fb_social_id'];
    snapSocialId = json['snap_social_id'];
    myExp = json['myExp'];
    myRecieveExperience = json['myRecieveExperience'];
    vipLevel = json['vipLevel'];
    vipFrom = json['vipFrom'];
    vipTo = json['vipTo'];
    myLevel = json['myLevel'];
    receivingLevel = json['receivingLevel'];
    myCoin = json['myCoin'];
    myDiamond = json['myDiamond'];
    totalSendDiamond = json['totalSendDiamond'];
    myRecievedDiamond = json['myRecievedDiamond'];
    dob = json['dob'];
    bio = json['bio'];
    country = json['Country'];
    continent = json['continent'];
    countryShowUnshow = json['country_showUnshow'];
    myFrame = json['myFrame'];
    myGallery = json['myGallery'];
    myLuckyId = json['myLuckyId'];
    myTheme = json['myTheme'];
    myThemeType = json['myTheme_type'];
    emailVerifiedAt = json['email_verified_at'];
    password = json['password'];
    salt = json['salt'];
    isAdmin = json['is_admin'];
    image = json['image'];
    langId = json['lang_id'];
    age = json['age'];
    gender = json['gender'];
    devId = json['dev_id'];
    regId = json['reg_id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    devType = json['dev_type'];
    rememberToken = json['remember_token'];
    loginOtp = json['loginOtp'];
    loginType = json['login_type'];
    registerType = json['registerType'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    phoneUpOtp = json['phoneUpOtp'];
    eventId = json['eventId'];
    isEventCreater = json['isEventCreater'];
    isEventSubscriber = json['isEventSubscriber'];
    isFamilyLeader = json['isFamilyLeader'];
    isFamilyMember = json['isFamilyMember'];
    monthlyCoins = json['monthlyCoins'];
    hoursLive = json['hoursLive'];
    talentLevel = json['talent_level'];
    basicSalary = json['basicSalary'];
    userBanStatus = json['userBanStatus'];
    idBannedFrom = json['idBannedFrom'];
    idBannedTo = json['idBannedTo'];
    liveStatus = json['liveStatus'];
    liveimage = json['Liveimage'];
    imageText = json['imageText'];
    imageTitle = json['imageTitle'];
    fixedValidDay = json['fixed_valid_day'];
    fixedMinutes = json['fixed_minutes'];
    fixedCoins = json['fixed_coins'];
    friendsLimit = json['friendsLimit'];
    followingLimit = json['followingLimit'];
    isVipOneEnable = json['isVipOneEnable'];
    isVipTwoEnable = json['isVipTwoEnable'];
    isVipThreeEnable = json['isVipThreeEnable'];
    isVipFourEnable = json['isVipFourEnable'];
    isVipFiveEnable = json['isVipFiveEnable'];
    familyName = json['familyName'];
    familyImage = json['familyImage'];
    followersCount = json['followersCount'];
    followingCount = json['followingCount'];
    agencyCreater = json['agencyCreater'];
    coinAgencyCreater = json['coinAgencyCreater'];
    visitorsCount = json['visitorsCount'];
    friendsCount = json['friendsCount'];
    followStatus = json['followStatus'];
    blockStatus = json['blockStatus'];
    vipStatus = json['vip_status'];
    userLive = json['userLive'] != null
        ? new UserLive.fromMap(json['userLive'])
        : null;
    hideStatus = json['hideStatus'];
    kickOutStatus = json['kickOutStatus'];
    vipDetails = json['vip_details'] != null
        ? new VipDetails.fromMap(json['vip_details'])
        : null;
    profileImage = json['profileImage'];
    idBannedStatus = json['idBannedStatus'];
    familyJoinStatus = json['familyJoinStatus'];
    familyJoinId = json['familyJoinId'];
    familyJoinName = json['familyJoinName'];
    agencyStatus = json['agency_status'];
    hostRequest = json['hostRequest'];
    friendCount = json['friendCount'];
    archivedTime = json['archivedTime'];
    lavelInfomation = json['lavelInfomation'] != null
        ? new LavelInfomation.fromMap(json['lavelInfomation'])
        : null;
    myFrameImageLink = json['myFrameImageLink'];
    myEntryEffectImageLink = json['myEntryEffectImageLink'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['username'] = this.username;
    data['familyId'] = this.familyId;
    data['phone'] = this.phone;
    data['facebookUserName'] = this.facebookUserName;
    data['email'] = this.email;
    data['host_status'] = this.hostStatus;
    data['social_id'] = this.socialId;
    data['fb_social_id'] = this.fbSocialId;
    data['snap_social_id'] = this.snapSocialId;
    data['myExp'] = this.myExp;
    data['myRecieveExperience'] = this.myRecieveExperience;
    data['vipLevel'] = this.vipLevel;
    data['vipFrom'] = this.vipFrom;
    data['vipTo'] = this.vipTo;
    data['myLevel'] = this.myLevel;
    data['receivingLevel'] = this.receivingLevel;
    data['myCoin'] = this.myCoin;
    data['myDiamond'] = this.myDiamond;
    data['totalSendDiamond'] = this.totalSendDiamond;
    data['myRecievedDiamond'] = this.myRecievedDiamond;
    data['dob'] = this.dob;
    data['bio'] = this.bio;
    data['Country'] = this.country;
    data['continent'] = this.continent;
    data['country_showUnshow'] = this.countryShowUnshow;
    data['myFrame'] = this.myFrame;
    data['myGallery'] = this.myGallery;
    data['myLuckyId'] = this.myLuckyId;
    data['myTheme'] = this.myTheme;
    data['myTheme_type'] = this.myThemeType;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['password'] = this.password;
    data['salt'] = this.salt;
    data['is_admin'] = this.isAdmin;
    data['image'] = this.image;
    data['lang_id'] = this.langId;
    data['age'] = this.age;
    data['gender'] = this.gender;
    data['dev_id'] = this.devId;
    data['reg_id'] = this.regId;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['dev_type'] = this.devType;
    data['remember_token'] = this.rememberToken;
    data['loginOtp'] = this.loginOtp;
    data['login_type'] = this.loginType;
    data['registerType'] = this.registerType;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['phoneUpOtp'] = this.phoneUpOtp;
    data['eventId'] = this.eventId;
    data['isEventCreater'] = this.isEventCreater;
    data['isEventSubscriber'] = this.isEventSubscriber;
    data['isFamilyLeader'] = this.isFamilyLeader;
    data['isFamilyMember'] = this.isFamilyMember;
    data['monthlyCoins'] = this.monthlyCoins;
    data['hoursLive'] = this.hoursLive;
    data['talent_level'] = this.talentLevel;
    data['basicSalary'] = this.basicSalary;
    data['userBanStatus'] = this.userBanStatus;
    data['idBannedFrom'] = this.idBannedFrom;
    data['idBannedTo'] = this.idBannedTo;
    data['liveStatus'] = this.liveStatus;
    data['Liveimage'] = this.liveimage;
    data['imageText'] = this.imageText;
    data['imageTitle'] = this.imageTitle;
    data['fixed_valid_day'] = this.fixedValidDay;
    data['fixed_minutes'] = this.fixedMinutes;
    data['fixed_coins'] = this.fixedCoins;
    data['friendsLimit'] = this.friendsLimit;
    data['followingLimit'] = this.followingLimit;
    data['isVipOneEnable'] = this.isVipOneEnable;
    data['isVipTwoEnable'] = this.isVipTwoEnable;
    data['isVipThreeEnable'] = this.isVipThreeEnable;
    data['isVipFourEnable'] = this.isVipFourEnable;
    data['isVipFiveEnable'] = this.isVipFiveEnable;
    data['familyName'] = this.familyName;
    data['familyImage'] = this.familyImage;
    data['followersCount'] = this.followersCount;
    data['followingCount'] = this.followingCount;
    data['agencyCreater'] = this.agencyCreater;
    data['coinAgencyCreater'] = this.coinAgencyCreater;
    data['visitorsCount'] = this.visitorsCount;
    data['friendsCount'] = this.friendsCount;
    data['followStatus'] = this.followStatus;
    data['blockStatus'] = this.blockStatus;
    data['vip_status'] = this.vipStatus;
    if (this.userLive != null) {
      data['userLive'] = this.userLive!.toMap();
    }
    data['hideStatus'] = this.hideStatus;
    data['kickOutStatus'] = this.kickOutStatus;
    if (this.vipDetails != null) {
      data['vip_details'] = this.vipDetails!.toMap();
    }
    data['profileImage'] = this.profileImage;
    data['idBannedStatus'] = this.idBannedStatus;
    data['familyJoinStatus'] = this.familyJoinStatus;
    data['familyJoinId'] = this.familyJoinId;
    data['familyJoinName'] = this.familyJoinName;
    data['agency_status'] = this.agencyStatus;
    data['hostRequest'] = this.hostRequest;
    data['friendCount'] = this.friendCount;
    data['archivedTime'] = this.archivedTime;
    if (this.lavelInfomation != null) {
      data['lavelInfomation'] = this.lavelInfomation!.toMap();
    }
    data['myFrameImageLink'] = this.myFrameImageLink;
    data['myEntryEffectImageLink'] = this.myEntryEffectImageLink;
    return data;
  }
}

class UserLive {
  String? id;
  String? hostType;
  String? userId;
  String? channelName;
  String? token;
  String? latitude;
  String? longitude;
  String? rtmToken;
  String? status;
  String? liveCount;
  String? password;
  String? liveimage;
  String? imageText;
  String? imageTitle;
  String? bool;
  String? liveHideUnhideStatus;
  String? liveHideUnhideExpTime;
  String? totaltimePerLive;
  String? created;
  String? createdDate;
  String? createdTime;
  String? endTime;
  String? archivedDate;

  UserLive(
      {this.id,
      this.hostType,
      this.userId,
      this.channelName,
      this.token,
      this.latitude,
      this.longitude,
      this.rtmToken,
      this.status,
      this.liveCount,
      this.password,
      this.liveimage,
      this.imageText,
      this.imageTitle,
      this.bool,
      this.liveHideUnhideStatus,
      this.liveHideUnhideExpTime,
      this.totaltimePerLive,
      this.created,
      this.createdDate,
      this.createdTime,
      this.endTime,
      this.archivedDate});

  UserLive.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    hostType = json['hostType'];
    userId = json['userId'];
    channelName = json['channelName'];
    token = json['token'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    rtmToken = json['rtmToken'];
    status = json['status'];
    liveCount = json['liveCount'];
    password = json['password'];
    liveimage = json['Liveimage'];
    imageText = json['imageText'];
    imageTitle = json['imageTitle'];
    bool = json['bool'];
    liveHideUnhideStatus = json['live_hideUnhideStatus'];
    liveHideUnhideExpTime = json['live_hideUnhideExpTime'];
    totaltimePerLive = json['totaltimePerLive'];
    created = json['created'];
    createdDate = json['createdDate'];
    createdTime = json['createdTime'];
    endTime = json['endTime'];
    archivedDate = json['archivedDate'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['hostType'] = this.hostType;
    data['userId'] = this.userId;
    data['channelName'] = this.channelName;
    data['token'] = this.token;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['rtmToken'] = this.rtmToken;
    data['status'] = this.status;
    data['liveCount'] = this.liveCount;
    data['password'] = this.password;
    data['Liveimage'] = this.liveimage;
    data['imageText'] = this.imageText;
    data['imageTitle'] = this.imageTitle;
    data['bool'] = this.bool;
    data['live_hideUnhideStatus'] = this.liveHideUnhideStatus;
    data['live_hideUnhideExpTime'] = this.liveHideUnhideExpTime;
    data['totaltimePerLive'] = this.totaltimePerLive;
    data['created'] = this.created;
    data['createdDate'] = this.createdDate;
    data['createdTime'] = this.createdTime;
    data['endTime'] = this.endTime;
    data['archivedDate'] = this.archivedDate;
    return data;
  }
}

class VipDetails {
  String? id;
  String? userId;
  String? receiverId;
  String? walletAmount;
  String? vipLevel;
  String? purchaseType;
  String? vipBatchImage;
  String? uniqueFrameImage;
  String? carsImage;
  String? colorFullMessageImage;
  String? flyingCommentImage;
  String? exclusiveGiftImage;
  String? vipFrom;
  String? vipTo;
  String? isApplied;

  VipDetails(
      {this.id,
      this.userId,
      this.receiverId,
      this.walletAmount,
      this.vipLevel,
      this.purchaseType,
      this.vipBatchImage,
      this.uniqueFrameImage,
      this.carsImage,
      this.colorFullMessageImage,
      this.flyingCommentImage,
      this.exclusiveGiftImage,
      this.vipFrom,
      this.vipTo,
      this.isApplied});

  VipDetails.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    receiverId = json['receiverId'];
    walletAmount = json['wallet_amount'];
    vipLevel = json['vipLevel'];
    purchaseType = json['purchaseType'];
    vipBatchImage = json['vipBatchImage'];
    uniqueFrameImage = json['uniqueFrameImage'];
    carsImage = json['carsImage'];
    colorFullMessageImage = json['colorFullMessageImage'];
    flyingCommentImage = json['flyingCommentImage'];
    exclusiveGiftImage = json['exclusiveGiftImage'];
    vipFrom = json['vipFrom'];
    vipTo = json['vipTo'];
    isApplied = json['isApplied'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['receiverId'] = this.receiverId;
    data['wallet_amount'] = this.walletAmount;
    data['vipLevel'] = this.vipLevel;
    data['purchaseType'] = this.purchaseType;
    data['vipBatchImage'] = this.vipBatchImage;
    data['uniqueFrameImage'] = this.uniqueFrameImage;
    data['carsImage'] = this.carsImage;
    data['colorFullMessageImage'] = this.colorFullMessageImage;
    data['flyingCommentImage'] = this.flyingCommentImage;
    data['exclusiveGiftImage'] = this.exclusiveGiftImage;
    data['vipFrom'] = this.vipFrom;
    data['vipTo'] = this.vipTo;
    data['isApplied'] = this.isApplied;
    return data;
  }
}

class LavelInfomation {
  String? sandColor;
  String? sandBgImage;
  String? sendLevel;
  String? sendExp;
  int? sendStart;
  int? sendEnd;
  String? reciveColor;
  String? reciveBgImage;
  String? reciveLevel;
  String? reciveExp;
  int? reciveStart;
  int? reciveEnd;

  LavelInfomation(
      {this.sandColor,
      this.sandBgImage,
      this.sendLevel,
      this.sendExp,
      this.sendStart,
      this.sendEnd,
      this.reciveColor,
      this.reciveBgImage,
      this.reciveLevel,
      this.reciveExp,
      this.reciveStart,
      this.reciveEnd});

  LavelInfomation.fromMap(Map<String, dynamic> json) {
    sandColor = json['sandColor'];
    sandBgImage = json['sandBgImage'];
    sendLevel = json['sendLevel'];
    sendExp = json['sendExp'];
    sendStart = json['sendStart'];
    sendEnd = json['sendEnd'];
    reciveColor = json['reciveColor'];
    reciveBgImage = json['reciveBgImage'];
    reciveLevel = json['reciveLevel'];
    reciveExp = json['reciveExp'];
    reciveStart = json['reciveStart'];
    reciveEnd = json['reciveEnd'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sandColor'] = this.sandColor;
    data['sandBgImage'] = this.sandBgImage;
    data['sendLevel'] = this.sendLevel;
    data['sendExp'] = this.sendExp;
    data['sendStart'] = this.sendStart;
    data['sendEnd'] = this.sendEnd;
    data['reciveColor'] = this.reciveColor;
    data['reciveBgImage'] = this.reciveBgImage;
    data['reciveLevel'] = this.reciveLevel;
    data['reciveExp'] = this.reciveExp;
    data['reciveStart'] = this.reciveStart;
    data['reciveEnd'] = this.reciveEnd;
    return data;
  }
}
