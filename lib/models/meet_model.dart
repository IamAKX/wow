class MeetModel {
  String? diamond;
  String? receiverId;
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
  String? imageDp;

  MeetModel(
      {this.diamond,
      this.receiverId,
      this.id,
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
      this.imageDp});

  MeetModel.fromJson(Map<String, dynamic> json) {
    diamond = json['diamond'];
    receiverId = json['receiverId'];
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
    imageDp = json['imageDp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['diamond'] = this.diamond;
    data['receiverId'] = this.receiverId;
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
    data['imageDp'] = this.imageDp;
    return data;
  }
}
