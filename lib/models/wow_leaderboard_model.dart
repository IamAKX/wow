class WowLeaderboardModel {
  String? diamond;
  String? senderId;
  UserDetails? userDetails;

  WowLeaderboardModel({this.diamond, this.senderId, this.userDetails});

  WowLeaderboardModel.fromJson(Map<String, dynamic> json) {
    diamond = json['diamond'];
    senderId = json['senderId'];
    userDetails = json['userDetails'] != null
        ? new UserDetails.fromJson(json['userDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['diamond'] = diamond;
    data['senderId'] = senderId;
    if (userDetails != null) {
      data['userDetails'] = userDetails!.toJson();
    }
    return data;
  }
}

class UserDetails {
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
  String? liveStatus;
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
  ProfileImage? profileImage;

  UserDetails(
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
      this.profileImage});

  UserDetails.fromJson(Map<String, dynamic> json) {
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
    profileImage = json['profileImage'] != null
        ? new ProfileImage.fromJson(json['profileImage'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['username'] = username;
    data['familyId'] = familyId;
    data['phone'] = phone;
    data['facebookUserName'] = facebookUserName;
    data['email'] = email;
    data['host_status'] = hostStatus;
    data['social_id'] = socialId;
    data['fb_social_id'] = fbSocialId;
    data['snap_social_id'] = snapSocialId;
    data['myExp'] = myExp;
    data['myRecieveExperience'] = myRecieveExperience;
    data['vipLevel'] = vipLevel;
    data['vipFrom'] = vipFrom;
    data['vipTo'] = vipTo;
    data['myLevel'] = myLevel;
    data['receivingLevel'] = receivingLevel;
    data['myCoin'] = myCoin;
    data['myDiamond'] = myDiamond;
    data['totalSendDiamond'] = totalSendDiamond;
    data['myRecievedDiamond'] = myRecievedDiamond;
    data['dob'] = dob;
    data['bio'] = bio;
    data['Country'] = country;
    data['continent'] = continent;
    data['country_showUnshow'] = countryShowUnshow;
    data['myFrame'] = myFrame;
    data['myGallery'] = myGallery;
    data['myLuckyId'] = myLuckyId;
    data['myTheme'] = myTheme;
    data['myTheme_type'] = myThemeType;
    data['email_verified_at'] = emailVerifiedAt;
    data['password'] = password;
    data['salt'] = salt;
    data['is_admin'] = isAdmin;
    data['image'] = image;
    data['lang_id'] = langId;
    data['age'] = age;
    data['gender'] = gender;
    data['dev_id'] = devId;
    data['reg_id'] = regId;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['dev_type'] = devType;
    data['remember_token'] = rememberToken;
    data['loginOtp'] = loginOtp;
    data['login_type'] = loginType;
    data['registerType'] = registerType;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['phoneUpOtp'] = phoneUpOtp;
    data['eventId'] = eventId;
    data['isEventCreater'] = isEventCreater;
    data['isEventSubscriber'] = isEventSubscriber;
    data['isFamilyLeader'] = isFamilyLeader;
    data['isFamilyMember'] = isFamilyMember;
    data['monthlyCoins'] = monthlyCoins;
    data['hoursLive'] = hoursLive;
    data['talent_level'] = talentLevel;
    data['basicSalary'] = basicSalary;
    data['userBanStatus'] = userBanStatus;
    data['idBannedFrom'] = idBannedFrom;
    data['idBannedTo'] = idBannedTo;
    data['liveStatus'] = liveStatus;
    data['Liveimage'] = liveimage;
    data['imageText'] = imageText;
    data['imageTitle'] = imageTitle;
    data['fixed_valid_day'] = fixedValidDay;
    data['fixed_minutes'] = fixedMinutes;
    data['fixed_coins'] = fixedCoins;
    data['friendsLimit'] = friendsLimit;
    data['followingLimit'] = followingLimit;
    data['isVipOneEnable'] = isVipOneEnable;
    data['isVipTwoEnable'] = isVipTwoEnable;
    data['isVipThreeEnable'] = isVipThreeEnable;
    data['isVipFourEnable'] = isVipFourEnable;
    data['isVipFiveEnable'] = isVipFiveEnable;
    if (profileImage != null) {
      data['profileImage'] = profileImage!.toJson();
    }
    return data;
  }
}

class ProfileImage {
  String? image;

  ProfileImage({this.image});

  ProfileImage.fromJson(Map<String, dynamic> json) {
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    return data;
  }
}
