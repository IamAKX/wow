import 'dart:convert';

class LiveUser {
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
  String? userLiveId;
  String? userId;
  String? hostType;
  String? channelName;
  String? token;
  String? rtmToken;
  String? status;
  String? archivedDate;
  String? endTime;
  String? liveCount;
  String? userLivePassword;
  String? liveHideUnhideStatus;
  String? distance;
  String? userProfileImage;
  bool? followStatus;
  bool? kickOutStatus;
  String? userGender;
  String? userDob;
  LiveUser({
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
    this.userLiveId,
    this.userId,
    this.hostType,
    this.channelName,
    this.token,
    this.rtmToken,
    this.status,
    this.archivedDate,
    this.endTime,
    this.liveCount,
    this.userLivePassword,
    this.liveHideUnhideStatus,
    this.distance,
    this.userProfileImage,
    this.followStatus,
    this.kickOutStatus,
    this.userGender,
    this.userDob,
  });

  LiveUser copyWith({
    String? id,
    String? name,
    String? username,
    String? familyId,
    String? phone,
    String? facebookUserName,
    String? email,
    String? hostStatus,
    String? socialId,
    String? fbSocialId,
    String? snapSocialId,
    String? myExp,
    String? myRecieveExperience,
    String? vipLevel,
    String? vipFrom,
    String? vipTo,
    String? myLevel,
    String? receivingLevel,
    String? myCoin,
    String? myDiamond,
    String? totalSendDiamond,
    String? myRecievedDiamond,
    String? dob,
    String? bio,
    String? country,
    String? continent,
    String? countryShowUnshow,
    String? myFrame,
    String? myGallery,
    String? myLuckyId,
    String? myTheme,
    String? myThemeType,
    String? emailVerifiedAt,
    String? password,
    String? salt,
    String? isAdmin,
    String? image,
    String? langId,
    String? age,
    String? gender,
    String? devId,
    String? regId,
    String? latitude,
    String? longitude,
    String? devType,
    String? rememberToken,
    String? loginOtp,
    String? loginType,
    String? registerType,
    String? createdAt,
    String? updatedAt,
    String? phoneUpOtp,
    String? eventId,
    String? isEventCreater,
    String? isEventSubscriber,
    String? isFamilyLeader,
    String? isFamilyMember,
    String? monthlyCoins,
    String? hoursLive,
    String? talentLevel,
    String? basicSalary,
    String? userBanStatus,
    String? idBannedFrom,
    String? idBannedTo,
    String? liveStatus,
    String? liveimage,
    String? imageText,
    String? imageTitle,
    String? fixedValidDay,
    String? fixedMinutes,
    String? fixedCoins,
    String? friendsLimit,
    String? followingLimit,
    String? isVipOneEnable,
    String? isVipTwoEnable,
    String? isVipThreeEnable,
    String? isVipFourEnable,
    String? isVipFiveEnable,
    String? userLiveId,
    String? userId,
    String? hostType,
    String? channelName,
    String? token,
    String? rtmToken,
    String? status,
    String? archivedDate,
    String? endTime,
    String? liveCount,
    String? userLivePassword,
    String? liveHideUnhideStatus,
    String? distance,
    String? userProfileImage,
    bool? followStatus,
    bool? kickOutStatus,
    String? userGender,
    String? userDob,
  }) {
    return LiveUser(
      id: id ?? this.id,
      name: name ?? this.name,
      username: username ?? this.username,
      familyId: familyId ?? this.familyId,
      phone: phone ?? this.phone,
      facebookUserName: facebookUserName ?? this.facebookUserName,
      email: email ?? this.email,
      hostStatus: hostStatus ?? this.hostStatus,
      socialId: socialId ?? this.socialId,
      fbSocialId: fbSocialId ?? this.fbSocialId,
      snapSocialId: snapSocialId ?? this.snapSocialId,
      myExp: myExp ?? this.myExp,
      myRecieveExperience: myRecieveExperience ?? this.myRecieveExperience,
      vipLevel: vipLevel ?? this.vipLevel,
      vipFrom: vipFrom ?? this.vipFrom,
      vipTo: vipTo ?? this.vipTo,
      myLevel: myLevel ?? this.myLevel,
      receivingLevel: receivingLevel ?? this.receivingLevel,
      myCoin: myCoin ?? this.myCoin,
      myDiamond: myDiamond ?? this.myDiamond,
      totalSendDiamond: totalSendDiamond ?? this.totalSendDiamond,
      myRecievedDiamond: myRecievedDiamond ?? this.myRecievedDiamond,
      dob: dob ?? this.dob,
      bio: bio ?? this.bio,
      country: country ?? this.country,
      continent: continent ?? this.continent,
      countryShowUnshow: countryShowUnshow ?? this.countryShowUnshow,
      myFrame: myFrame ?? this.myFrame,
      myGallery: myGallery ?? this.myGallery,
      myLuckyId: myLuckyId ?? this.myLuckyId,
      myTheme: myTheme ?? this.myTheme,
      myThemeType: myThemeType ?? this.myThemeType,
      emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
      password: password ?? this.password,
      salt: salt ?? this.salt,
      isAdmin: isAdmin ?? this.isAdmin,
      image: image ?? this.image,
      langId: langId ?? this.langId,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      devId: devId ?? this.devId,
      regId: regId ?? this.regId,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      devType: devType ?? this.devType,
      rememberToken: rememberToken ?? this.rememberToken,
      loginOtp: loginOtp ?? this.loginOtp,
      loginType: loginType ?? this.loginType,
      registerType: registerType ?? this.registerType,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      phoneUpOtp: phoneUpOtp ?? this.phoneUpOtp,
      eventId: eventId ?? this.eventId,
      isEventCreater: isEventCreater ?? this.isEventCreater,
      isEventSubscriber: isEventSubscriber ?? this.isEventSubscriber,
      isFamilyLeader: isFamilyLeader ?? this.isFamilyLeader,
      isFamilyMember: isFamilyMember ?? this.isFamilyMember,
      monthlyCoins: monthlyCoins ?? this.monthlyCoins,
      hoursLive: hoursLive ?? this.hoursLive,
      talentLevel: talentLevel ?? this.talentLevel,
      basicSalary: basicSalary ?? this.basicSalary,
      userBanStatus: userBanStatus ?? this.userBanStatus,
      idBannedFrom: idBannedFrom ?? this.idBannedFrom,
      idBannedTo: idBannedTo ?? this.idBannedTo,
      liveStatus: liveStatus ?? this.liveStatus,
      liveimage: liveimage ?? this.liveimage,
      imageText: imageText ?? this.imageText,
      imageTitle: imageTitle ?? this.imageTitle,
      fixedValidDay: fixedValidDay ?? this.fixedValidDay,
      fixedMinutes: fixedMinutes ?? this.fixedMinutes,
      fixedCoins: fixedCoins ?? this.fixedCoins,
      friendsLimit: friendsLimit ?? this.friendsLimit,
      followingLimit: followingLimit ?? this.followingLimit,
      isVipOneEnable: isVipOneEnable ?? this.isVipOneEnable,
      isVipTwoEnable: isVipTwoEnable ?? this.isVipTwoEnable,
      isVipThreeEnable: isVipThreeEnable ?? this.isVipThreeEnable,
      isVipFourEnable: isVipFourEnable ?? this.isVipFourEnable,
      isVipFiveEnable: isVipFiveEnable ?? this.isVipFiveEnable,
      userLiveId: userLiveId ?? this.userLiveId,
      userId: userId ?? this.userId,
      hostType: hostType ?? this.hostType,
      channelName: channelName ?? this.channelName,
      token: token ?? this.token,
      rtmToken: rtmToken ?? this.rtmToken,
      status: status ?? this.status,
      archivedDate: archivedDate ?? this.archivedDate,
      endTime: endTime ?? this.endTime,
      liveCount: liveCount ?? this.liveCount,
      userLivePassword: userLivePassword ?? this.userLivePassword,
      liveHideUnhideStatus: liveHideUnhideStatus ?? this.liveHideUnhideStatus,
      distance: distance ?? this.distance,
      userProfileImage: userProfileImage ?? this.userProfileImage,
      followStatus: followStatus ?? this.followStatus,
      kickOutStatus: kickOutStatus ?? this.kickOutStatus,
      userGender: userGender ?? this.userGender,
      userDob: userDob ?? this.userDob,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (name != null) {
      result.addAll({'name': name});
    }
    if (username != null) {
      result.addAll({'username': username});
    }
    if (familyId != null) {
      result.addAll({'familyId': familyId});
    }
    if (phone != null) {
      result.addAll({'phone': phone});
    }
    if (facebookUserName != null) {
      result.addAll({'facebookUserName': facebookUserName});
    }
    if (email != null) {
      result.addAll({'email': email});
    }
    if (hostStatus != null) {
      result.addAll({'hostStatus': hostStatus});
    }
    if (socialId != null) {
      result.addAll({'socialId': socialId});
    }
    if (fbSocialId != null) {
      result.addAll({'fbSocialId': fbSocialId});
    }
    if (snapSocialId != null) {
      result.addAll({'snapSocialId': snapSocialId});
    }
    if (myExp != null) {
      result.addAll({'myExp': myExp});
    }
    if (myRecieveExperience != null) {
      result.addAll({'myRecieveExperience': myRecieveExperience});
    }
    if (vipLevel != null) {
      result.addAll({'vipLevel': vipLevel});
    }
    if (vipFrom != null) {
      result.addAll({'vipFrom': vipFrom});
    }
    if (vipTo != null) {
      result.addAll({'vipTo': vipTo});
    }
    if (myLevel != null) {
      result.addAll({'myLevel': myLevel});
    }
    if (receivingLevel != null) {
      result.addAll({'receivingLevel': receivingLevel});
    }
    if (myCoin != null) {
      result.addAll({'myCoin': myCoin});
    }
    if (myDiamond != null) {
      result.addAll({'myDiamond': myDiamond});
    }
    if (totalSendDiamond != null) {
      result.addAll({'totalSendDiamond': totalSendDiamond});
    }
    if (myRecievedDiamond != null) {
      result.addAll({'myRecievedDiamond': myRecievedDiamond});
    }
    if (dob != null) {
      result.addAll({'dob': dob});
    }
    if (bio != null) {
      result.addAll({'bio': bio});
    }
    if (country != null) {
      result.addAll({'country': country});
    }
    if (continent != null) {
      result.addAll({'continent': continent});
    }
    if (countryShowUnshow != null) {
      result.addAll({'countryShowUnshow': countryShowUnshow});
    }
    if (myFrame != null) {
      result.addAll({'myFrame': myFrame});
    }
    if (myGallery != null) {
      result.addAll({'myGallery': myGallery});
    }
    if (myLuckyId != null) {
      result.addAll({'myLuckyId': myLuckyId});
    }
    if (myTheme != null) {
      result.addAll({'myTheme': myTheme});
    }
    if (myThemeType != null) {
      result.addAll({'myThemeType': myThemeType});
    }
    if (emailVerifiedAt != null) {
      result.addAll({'emailVerifiedAt': emailVerifiedAt});
    }
    if (password != null) {
      result.addAll({'password': password});
    }
    if (salt != null) {
      result.addAll({'salt': salt});
    }
    if (isAdmin != null) {
      result.addAll({'isAdmin': isAdmin});
    }
    if (image != null) {
      result.addAll({'image': image});
    }
    if (langId != null) {
      result.addAll({'langId': langId});
    }
    if (age != null) {
      result.addAll({'age': age});
    }
    if (gender != null) {
      result.addAll({'gender': gender});
    }
    if (devId != null) {
      result.addAll({'devId': devId});
    }
    if (regId != null) {
      result.addAll({'regId': regId});
    }
    if (latitude != null) {
      result.addAll({'latitude': latitude});
    }
    if (longitude != null) {
      result.addAll({'longitude': longitude});
    }
    if (devType != null) {
      result.addAll({'devType': devType});
    }
    if (rememberToken != null) {
      result.addAll({'rememberToken': rememberToken});
    }
    if (loginOtp != null) {
      result.addAll({'loginOtp': loginOtp});
    }
    if (loginType != null) {
      result.addAll({'loginType': loginType});
    }
    if (registerType != null) {
      result.addAll({'registerType': registerType});
    }
    if (createdAt != null) {
      result.addAll({'createdAt': createdAt});
    }
    if (updatedAt != null) {
      result.addAll({'updatedAt': updatedAt});
    }
    if (phoneUpOtp != null) {
      result.addAll({'phoneUpOtp': phoneUpOtp});
    }
    if (eventId != null) {
      result.addAll({'eventId': eventId});
    }
    if (isEventCreater != null) {
      result.addAll({'isEventCreater': isEventCreater});
    }
    if (isEventSubscriber != null) {
      result.addAll({'isEventSubscriber': isEventSubscriber});
    }
    if (isFamilyLeader != null) {
      result.addAll({'isFamilyLeader': isFamilyLeader});
    }
    if (isFamilyMember != null) {
      result.addAll({'isFamilyMember': isFamilyMember});
    }
    if (monthlyCoins != null) {
      result.addAll({'monthlyCoins': monthlyCoins});
    }
    if (hoursLive != null) {
      result.addAll({'hoursLive': hoursLive});
    }
    if (talentLevel != null) {
      result.addAll({'talentLevel': talentLevel});
    }
    if (basicSalary != null) {
      result.addAll({'basicSalary': basicSalary});
    }
    if (userBanStatus != null) {
      result.addAll({'userBanStatus': userBanStatus});
    }
    if (idBannedFrom != null) {
      result.addAll({'idBannedFrom': idBannedFrom});
    }
    if (idBannedTo != null) {
      result.addAll({'idBannedTo': idBannedTo});
    }
    if (liveStatus != null) {
      result.addAll({'liveStatus': liveStatus});
    }
    if (liveimage != null) {
      result.addAll({'liveimage': liveimage});
    }
    if (imageText != null) {
      result.addAll({'imageText': imageText});
    }
    if (imageTitle != null) {
      result.addAll({'imageTitle': imageTitle});
    }
    if (fixedValidDay != null) {
      result.addAll({'fixedValidDay': fixedValidDay});
    }
    if (fixedMinutes != null) {
      result.addAll({'fixedMinutes': fixedMinutes});
    }
    if (fixedCoins != null) {
      result.addAll({'fixedCoins': fixedCoins});
    }
    if (friendsLimit != null) {
      result.addAll({'friendsLimit': friendsLimit});
    }
    if (followingLimit != null) {
      result.addAll({'followingLimit': followingLimit});
    }
    if (isVipOneEnable != null) {
      result.addAll({'isVipOneEnable': isVipOneEnable});
    }
    if (isVipTwoEnable != null) {
      result.addAll({'isVipTwoEnable': isVipTwoEnable});
    }
    if (isVipThreeEnable != null) {
      result.addAll({'isVipThreeEnable': isVipThreeEnable});
    }
    if (isVipFourEnable != null) {
      result.addAll({'isVipFourEnable': isVipFourEnable});
    }
    if (isVipFiveEnable != null) {
      result.addAll({'isVipFiveEnable': isVipFiveEnable});
    }
    if (userLiveId != null) {
      result.addAll({'userLiveId': userLiveId});
    }
    if (userId != null) {
      result.addAll({'userId': userId});
    }
    if (hostType != null) {
      result.addAll({'hostType': hostType});
    }
    if (channelName != null) {
      result.addAll({'channelName': channelName});
    }
    if (token != null) {
      result.addAll({'token': token});
    }
    if (rtmToken != null) {
      result.addAll({'rtmToken': rtmToken});
    }
    if (status != null) {
      result.addAll({'status': status});
    }
    if (archivedDate != null) {
      result.addAll({'archivedDate': archivedDate});
    }
    if (endTime != null) {
      result.addAll({'endTime': endTime});
    }
    if (liveCount != null) {
      result.addAll({'liveCount': liveCount});
    }
    if (userLivePassword != null) {
      result.addAll({'userLivePassword': userLivePassword});
    }
    if (liveHideUnhideStatus != null) {
      result.addAll({'liveHideUnhideStatus': liveHideUnhideStatus});
    }
    if (distance != null) {
      result.addAll({'distance': distance});
    }
    if (userProfileImage != null) {
      result.addAll({'userProfileImage': userProfileImage});
    }
    if (followStatus != null) {
      result.addAll({'followStatus': followStatus});
    }
    if (kickOutStatus != null) {
      result.addAll({'kickOutStatus': kickOutStatus});
    }
    if (userGender != null) {
      result.addAll({'userGender': userGender});
    }
    if (userDob != null) {
      result.addAll({'userDob': userDob});
    }

    return result;
  }

  factory LiveUser.fromMap(Map<String, dynamic> map) {
    return LiveUser(
      id: map['id'],
      name: map['name'],
      username: map['username'],
      familyId: map['familyId'],
      phone: map['phone'],
      facebookUserName: map['facebookUserName'],
      email: map['email'],
      hostStatus: map['hostStatus'],
      socialId: map['socialId'],
      fbSocialId: map['fbSocialId'],
      snapSocialId: map['snapSocialId'],
      myExp: map['myExp'],
      myRecieveExperience: map['myRecieveExperience'],
      vipLevel: map['vipLevel'],
      vipFrom: map['vipFrom'],
      vipTo: map['vipTo'],
      myLevel: map['myLevel'],
      receivingLevel: map['receivingLevel'],
      myCoin: map['myCoin'],
      myDiamond: map['myDiamond'],
      totalSendDiamond: map['totalSendDiamond'],
      myRecievedDiamond: map['myRecievedDiamond'],
      dob: map['dob'],
      bio: map['bio'],
      country: map['country'],
      continent: map['continent'],
      countryShowUnshow: map['countryShowUnshow'],
      myFrame: map['myFrame'],
      myGallery: map['myGallery'],
      myLuckyId: map['myLuckyId'],
      myTheme: map['myTheme'],
      myThemeType: map['myThemeType'],
      emailVerifiedAt: map['emailVerifiedAt'],
      password: map['password'],
      salt: map['salt'],
      isAdmin: map['isAdmin'],
      image: map['image'],
      langId: map['langId'],
      age: map['age'],
      gender: map['gender'],
      devId: map['devId'],
      regId: map['regId'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      devType: map['devType'],
      rememberToken: map['rememberToken'],
      loginOtp: map['loginOtp'],
      loginType: map['loginType'],
      registerType: map['registerType'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
      phoneUpOtp: map['phoneUpOtp'],
      eventId: map['eventId'],
      isEventCreater: map['isEventCreater'],
      isEventSubscriber: map['isEventSubscriber'],
      isFamilyLeader: map['isFamilyLeader'],
      isFamilyMember: map['isFamilyMember'],
      monthlyCoins: map['monthlyCoins'],
      hoursLive: map['hoursLive'],
      talentLevel: map['talentLevel'],
      basicSalary: map['basicSalary'],
      userBanStatus: map['userBanStatus'],
      idBannedFrom: map['idBannedFrom'],
      idBannedTo: map['idBannedTo'],
      liveStatus: map['liveStatus'],
      liveimage: map['liveimage'],
      imageText: map['imageText'],
      imageTitle: map['imageTitle'],
      fixedValidDay: map['fixedValidDay'],
      fixedMinutes: map['fixedMinutes'],
      fixedCoins: map['fixedCoins'],
      friendsLimit: map['friendsLimit'],
      followingLimit: map['followingLimit'],
      isVipOneEnable: map['isVipOneEnable'],
      isVipTwoEnable: map['isVipTwoEnable'],
      isVipThreeEnable: map['isVipThreeEnable'],
      isVipFourEnable: map['isVipFourEnable'],
      isVipFiveEnable: map['isVipFiveEnable'],
      userLiveId: map['userLiveId'],
      userId: map['userId'],
      hostType: map['hostType'],
      channelName: map['channelName'],
      token: map['token'],
      rtmToken: map['rtmToken'],
      status: map['status'],
      archivedDate: map['archivedDate'],
      endTime: map['endTime'],
      liveCount: map['liveCount'],
      userLivePassword: map['userLivePassword'],
      liveHideUnhideStatus: map['liveHideUnhideStatus'],
      distance: map['distance'],
      userProfileImage: map['userProfileImage'],
      followStatus: map['followStatus'],
      kickOutStatus: map['kickOutStatus'],
      userGender: map['userGender'],
      userDob: map['userDob'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LiveUser.fromJson(String source) =>
      LiveUser.fromMap(json.decode(source));

  @override
  String toString() {
    return 'LiveUser(id: $id, name: $name, username: $username, familyId: $familyId, phone: $phone, facebookUserName: $facebookUserName, email: $email, hostStatus: $hostStatus, socialId: $socialId, fbSocialId: $fbSocialId, snapSocialId: $snapSocialId, myExp: $myExp, myRecieveExperience: $myRecieveExperience, vipLevel: $vipLevel, vipFrom: $vipFrom, vipTo: $vipTo, myLevel: $myLevel, receivingLevel: $receivingLevel, myCoin: $myCoin, myDiamond: $myDiamond, totalSendDiamond: $totalSendDiamond, myRecievedDiamond: $myRecievedDiamond, dob: $dob, bio: $bio, country: $country, continent: $continent, countryShowUnshow: $countryShowUnshow, myFrame: $myFrame, myGallery: $myGallery, myLuckyId: $myLuckyId, myTheme: $myTheme, myThemeType: $myThemeType, emailVerifiedAt: $emailVerifiedAt, password: $password, salt: $salt, isAdmin: $isAdmin, image: $image, langId: $langId, age: $age, gender: $gender, devId: $devId, regId: $regId, latitude: $latitude, longitude: $longitude, devType: $devType, rememberToken: $rememberToken, loginOtp: $loginOtp, loginType: $loginType, registerType: $registerType, createdAt: $createdAt, updatedAt: $updatedAt, phoneUpOtp: $phoneUpOtp, eventId: $eventId, isEventCreater: $isEventCreater, isEventSubscriber: $isEventSubscriber, isFamilyLeader: $isFamilyLeader, isFamilyMember: $isFamilyMember, monthlyCoins: $monthlyCoins, hoursLive: $hoursLive, talentLevel: $talentLevel, basicSalary: $basicSalary, userBanStatus: $userBanStatus, idBannedFrom: $idBannedFrom, idBannedTo: $idBannedTo, liveStatus: $liveStatus, liveimage: $liveimage, imageText: $imageText, imageTitle: $imageTitle, fixedValidDay: $fixedValidDay, fixedMinutes: $fixedMinutes, fixedCoins: $fixedCoins, friendsLimit: $friendsLimit, followingLimit: $followingLimit, isVipOneEnable: $isVipOneEnable, isVipTwoEnable: $isVipTwoEnable, isVipThreeEnable: $isVipThreeEnable, isVipFourEnable: $isVipFourEnable, isVipFiveEnable: $isVipFiveEnable, userLiveId: $userLiveId, userId: $userId, hostType: $hostType, channelName: $channelName, token: $token, rtmToken: $rtmToken, status: $status, archivedDate: $archivedDate, endTime: $endTime, liveCount: $liveCount, userLivePassword: $userLivePassword, liveHideUnhideStatus: $liveHideUnhideStatus, distance: $distance, userProfileImage: $userProfileImage, followStatus: $followStatus, kickOutStatus: $kickOutStatus, userGender: $userGender, userDob: $userDob)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LiveUser &&
        other.id == id &&
        other.name == name &&
        other.username == username &&
        other.familyId == familyId &&
        other.phone == phone &&
        other.facebookUserName == facebookUserName &&
        other.email == email &&
        other.hostStatus == hostStatus &&
        other.socialId == socialId &&
        other.fbSocialId == fbSocialId &&
        other.snapSocialId == snapSocialId &&
        other.myExp == myExp &&
        other.myRecieveExperience == myRecieveExperience &&
        other.vipLevel == vipLevel &&
        other.vipFrom == vipFrom &&
        other.vipTo == vipTo &&
        other.myLevel == myLevel &&
        other.receivingLevel == receivingLevel &&
        other.myCoin == myCoin &&
        other.myDiamond == myDiamond &&
        other.totalSendDiamond == totalSendDiamond &&
        other.myRecievedDiamond == myRecievedDiamond &&
        other.dob == dob &&
        other.bio == bio &&
        other.country == country &&
        other.continent == continent &&
        other.countryShowUnshow == countryShowUnshow &&
        other.myFrame == myFrame &&
        other.myGallery == myGallery &&
        other.myLuckyId == myLuckyId &&
        other.myTheme == myTheme &&
        other.myThemeType == myThemeType &&
        other.emailVerifiedAt == emailVerifiedAt &&
        other.password == password &&
        other.salt == salt &&
        other.isAdmin == isAdmin &&
        other.image == image &&
        other.langId == langId &&
        other.age == age &&
        other.gender == gender &&
        other.devId == devId &&
        other.regId == regId &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        other.devType == devType &&
        other.rememberToken == rememberToken &&
        other.loginOtp == loginOtp &&
        other.loginType == loginType &&
        other.registerType == registerType &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.phoneUpOtp == phoneUpOtp &&
        other.eventId == eventId &&
        other.isEventCreater == isEventCreater &&
        other.isEventSubscriber == isEventSubscriber &&
        other.isFamilyLeader == isFamilyLeader &&
        other.isFamilyMember == isFamilyMember &&
        other.monthlyCoins == monthlyCoins &&
        other.hoursLive == hoursLive &&
        other.talentLevel == talentLevel &&
        other.basicSalary == basicSalary &&
        other.userBanStatus == userBanStatus &&
        other.idBannedFrom == idBannedFrom &&
        other.idBannedTo == idBannedTo &&
        other.liveStatus == liveStatus &&
        other.liveimage == liveimage &&
        other.imageText == imageText &&
        other.imageTitle == imageTitle &&
        other.fixedValidDay == fixedValidDay &&
        other.fixedMinutes == fixedMinutes &&
        other.fixedCoins == fixedCoins &&
        other.friendsLimit == friendsLimit &&
        other.followingLimit == followingLimit &&
        other.isVipOneEnable == isVipOneEnable &&
        other.isVipTwoEnable == isVipTwoEnable &&
        other.isVipThreeEnable == isVipThreeEnable &&
        other.isVipFourEnable == isVipFourEnable &&
        other.isVipFiveEnable == isVipFiveEnable &&
        other.userLiveId == userLiveId &&
        other.userId == userId &&
        other.hostType == hostType &&
        other.channelName == channelName &&
        other.token == token &&
        other.rtmToken == rtmToken &&
        other.status == status &&
        other.archivedDate == archivedDate &&
        other.endTime == endTime &&
        other.liveCount == liveCount &&
        other.userLivePassword == userLivePassword &&
        other.liveHideUnhideStatus == liveHideUnhideStatus &&
        other.distance == distance &&
        other.userProfileImage == userProfileImage &&
        other.followStatus == followStatus &&
        other.kickOutStatus == kickOutStatus &&
        other.userGender == userGender &&
        other.userDob == userDob;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        username.hashCode ^
        familyId.hashCode ^
        phone.hashCode ^
        facebookUserName.hashCode ^
        email.hashCode ^
        hostStatus.hashCode ^
        socialId.hashCode ^
        fbSocialId.hashCode ^
        snapSocialId.hashCode ^
        myExp.hashCode ^
        myRecieveExperience.hashCode ^
        vipLevel.hashCode ^
        vipFrom.hashCode ^
        vipTo.hashCode ^
        myLevel.hashCode ^
        receivingLevel.hashCode ^
        myCoin.hashCode ^
        myDiamond.hashCode ^
        totalSendDiamond.hashCode ^
        myRecievedDiamond.hashCode ^
        dob.hashCode ^
        bio.hashCode ^
        country.hashCode ^
        continent.hashCode ^
        countryShowUnshow.hashCode ^
        myFrame.hashCode ^
        myGallery.hashCode ^
        myLuckyId.hashCode ^
        myTheme.hashCode ^
        myThemeType.hashCode ^
        emailVerifiedAt.hashCode ^
        password.hashCode ^
        salt.hashCode ^
        isAdmin.hashCode ^
        image.hashCode ^
        langId.hashCode ^
        age.hashCode ^
        gender.hashCode ^
        devId.hashCode ^
        regId.hashCode ^
        latitude.hashCode ^
        longitude.hashCode ^
        devType.hashCode ^
        rememberToken.hashCode ^
        loginOtp.hashCode ^
        loginType.hashCode ^
        registerType.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        phoneUpOtp.hashCode ^
        eventId.hashCode ^
        isEventCreater.hashCode ^
        isEventSubscriber.hashCode ^
        isFamilyLeader.hashCode ^
        isFamilyMember.hashCode ^
        monthlyCoins.hashCode ^
        hoursLive.hashCode ^
        talentLevel.hashCode ^
        basicSalary.hashCode ^
        userBanStatus.hashCode ^
        idBannedFrom.hashCode ^
        idBannedTo.hashCode ^
        liveStatus.hashCode ^
        liveimage.hashCode ^
        imageText.hashCode ^
        imageTitle.hashCode ^
        fixedValidDay.hashCode ^
        fixedMinutes.hashCode ^
        fixedCoins.hashCode ^
        friendsLimit.hashCode ^
        followingLimit.hashCode ^
        isVipOneEnable.hashCode ^
        isVipTwoEnable.hashCode ^
        isVipThreeEnable.hashCode ^
        isVipFourEnable.hashCode ^
        isVipFiveEnable.hashCode ^
        userLiveId.hashCode ^
        userId.hashCode ^
        hostType.hashCode ^
        channelName.hashCode ^
        token.hashCode ^
        rtmToken.hashCode ^
        status.hashCode ^
        archivedDate.hashCode ^
        endTime.hashCode ^
        liveCount.hashCode ^
        userLivePassword.hashCode ^
        liveHideUnhideStatus.hashCode ^
        distance.hashCode ^
        userProfileImage.hashCode ^
        followStatus.hashCode ^
        kickOutStatus.hashCode ^
        userGender.hashCode ^
        userDob.hashCode;
  }
}