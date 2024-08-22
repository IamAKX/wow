class FamilyDetails {
  String? id;
  String? uniqueId;
  String? familyName;
  int? familyLevel;
  String? description;
  String? leaderId;
  String? members;
  String? image;
  String? status;
  String? editStatus;
  String? createdAt;
  String? familyOwnerName;
  bool? admin;
  bool? familyCreateStatus;
  String? leaderImage;
  int? totalContribution;
  int? requestCount;
  List<Joiner>? joiner;
  List<AllMembers>? allMembers;
  Family? family;
  int? totalExp;

  FamilyDetails(
      {this.id,
      this.uniqueId,
      this.familyName,
      this.familyLevel,
      this.description,
      this.leaderId,
      this.members,
      this.image,
      this.status,
      this.editStatus,
      this.createdAt,
      this.familyOwnerName,
      this.admin,
      this.familyCreateStatus,
      this.leaderImage,
      this.totalContribution,
      this.requestCount,
      this.joiner,
      this.allMembers,
      this.family,
      this.totalExp});

  FamilyDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uniqueId = json['uniqueId'];
    familyName = json['familyName'];
    familyLevel = json['familyLevel'];
    description = json['description'];
    leaderId = json['leaderId'];
    members = json['members'];
    image = json['image'];
    status = json['status'];
    editStatus = json['edit_status'];
    createdAt = json['created_at'];
    familyOwnerName = json['family_OwnerName'];
    admin = json['admin'];
    familyCreateStatus = json['family_create_status'];
    leaderImage = json['leaderImage'];
    totalContribution = json['totalContribution'];
    requestCount = json['request_count'];
    if (json['joiner'] != null) {
      joiner = <Joiner>[];
      json['joiner'].forEach((v) {
        joiner!.add(Joiner.fromJson(v));
      });
    }
    if (json['allMembers'] != null) {
      allMembers = <AllMembers>[];
      json['allMembers'].forEach((v) {
        allMembers!.add(AllMembers.fromJson(v));
      });
    }
    family = json['family'] != null ? Family.fromJson(json['family']) : null;
    totalExp = json['totalExp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['uniqueId'] = uniqueId;
    data['familyName'] = familyName;
    data['familyLevel'] = familyLevel;
    data['description'] = description;
    data['leaderId'] = leaderId;
    data['members'] = members;
    data['image'] = image;
    data['status'] = status;
    data['edit_status'] = editStatus;
    data['created_at'] = createdAt;
    data['family_OwnerName'] = familyOwnerName;
    data['admin'] = admin;
    data['family_create_status'] = familyCreateStatus;
    data['leaderImage'] = leaderImage;
    data['totalContribution'] = totalContribution;
    data['request_count'] = requestCount;
    if (joiner != null) {
      data['joiner'] = joiner!.map((v) => v.toJson()).toList();
    }
    if (allMembers != null) {
      data['allMembers'] = allMembers!.map((v) => v.toJson()).toList();
    }
    if (family != null) {
      data['family'] = family!.toJson();
    }
    data['totalExp'] = totalExp;
    return data;
  }
}

class Joiner {
  String? familyMemberId;
  String? familyId;
  String? userId;
  String? type;
  String? status;
  String? name;
  String? isAdmin;
  String? userProfileImage;
  String? contribution;
  bool? showStatus;

  Joiner(
      {this.familyMemberId,
      this.familyId,
      this.userId,
      this.type,
      this.status,
      this.name,
      this.isAdmin,
      this.userProfileImage,
      this.contribution,
      this.showStatus});

  Joiner.fromJson(Map<String, dynamic> json) {
    familyMemberId = json['familyMemberId'];
    familyId = json['familyId'];
    userId = json['userId'];
    type = json['type'];
    status = json['status'];
    name = json['name'];
    isAdmin = json['is_admin'];
    userProfileImage = json['UserProfileImage'];
    contribution = json['contribution'];
    showStatus = json['show_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['familyMemberId'] = familyMemberId;
    data['familyId'] = familyId;
    data['userId'] = userId;
    data['type'] = type;
    data['status'] = status;
    data['name'] = name;
    data['is_admin'] = isAdmin;
    data['UserProfileImage'] = userProfileImage;
    data['contribution'] = contribution;
    data['show_status'] = showStatus;
    return data;
  }
}

class AllMembers {
  String? familyMemberId;
  String? familyId;
  String? userId;
  String? type;
  String? status;
  String? id;
  String? name;
  String? username;
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
  String? isLeader;
  String? userProfileImage;
  String? membersContribution;
  String? contribution;
  bool? showStatus;
  String? sandColor;
  String? sandBgImage;
  String? sendLevel;
  String? reciveColor;
  String? reciveBgImage;
  String? reciveLevel;

  AllMembers(
      {this.familyMemberId,
      this.familyId,
      this.userId,
      this.type,
      this.status,
      this.id,
      this.name,
      this.username,
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
      this.isLeader,
      this.userProfileImage,
      this.membersContribution,
      this.contribution,
      this.showStatus,
      this.sandColor,
      this.sandBgImage,
      this.sendLevel,
      this.reciveColor,
      this.reciveBgImage,
      this.reciveLevel});

  AllMembers.fromJson(Map<String, dynamic> json) {
    familyMemberId = json['familyMemberId'];
    familyId = json['familyId'];
    userId = json['userId'];
    type = json['type'];
    status = json['status'];
    id = json['id'];
    name = json['name'];
    username = json['username'];
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
    isLeader = json['is_leader'];
    userProfileImage = json['UserProfileImage'];
    membersContribution = json['membersContribution'];
    contribution = json['contribution'];
    showStatus = json['show_status'];
    sandColor = json['sandColor'];
    sandBgImage = json['sandBgImage'];
    sendLevel = json['sendLevel'];
    reciveColor = json['reciveColor'];
    reciveBgImage = json['reciveBgImage'];
    reciveLevel = json['reciveLevel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['familyMemberId'] = familyMemberId;
    data['familyId'] = familyId;
    data['userId'] = userId;
    data['type'] = type;
    data['status'] = status;
    data['id'] = id;
    data['name'] = name;
    data['username'] = username;
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
    data['is_leader'] = isLeader;
    data['UserProfileImage'] = userProfileImage;
    data['membersContribution'] = membersContribution;
    data['contribution'] = contribution;
    data['show_status'] = showStatus;
    data['sandColor'] = sandColor;
    data['sandBgImage'] = sandBgImage;
    data['sendLevel'] = sendLevel;
    data['reciveColor'] = reciveColor;
    data['reciveBgImage'] = reciveBgImage;
    data['reciveLevel'] = reciveLevel;
    return data;
  }
}

class Family {
  String? id;
  String? uniqueId;
  String? familyName;
  String? familyLevel;
  String? description;
  String? leaderId;
  String? members;
  String? image;
  String? status;
  String? editStatus;
  String? createdAt;
  String? familyOwnerName;
  String? ldrImage;

  Family(
      {this.id,
      this.uniqueId,
      this.familyName,
      this.familyLevel,
      this.description,
      this.leaderId,
      this.members,
      this.image,
      this.status,
      this.editStatus,
      this.createdAt,
      this.familyOwnerName,
      this.ldrImage});

  Family.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uniqueId = json['uniqueId'];
    familyName = json['familyName'];
    familyLevel = json['familyLevel'];
    description = json['description'];
    leaderId = json['leaderId'];
    members = json['members'];
    image = json['image'];
    status = json['status'];
    editStatus = json['edit_status'];
    createdAt = json['created_at'];
    familyOwnerName = json['family_OwnerName'];
    ldrImage = json['ldrImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['uniqueId'] = uniqueId;
    data['familyName'] = familyName;
    data['familyLevel'] = familyLevel;
    data['description'] = description;
    data['leaderId'] = leaderId;
    data['members'] = members;
    data['image'] = image;
    data['status'] = status;
    data['edit_status'] = editStatus;
    data['created_at'] = createdAt;
    data['family_OwnerName'] = familyOwnerName;
    data['ldrImage'] = ldrImage;
    return data;
  }
}
