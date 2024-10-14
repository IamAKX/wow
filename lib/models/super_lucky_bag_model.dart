class SuperLuckyBagModel {
  String? superLuckyBagDetailsId;
  String? amount;
  String? bagCreaterId;
  String? liveId;
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
  String? liveHideUnhideStatus;
  String? liveHideUnhideExpTime;
  String? totaltimePerLive;
  String? created;
  String? createdDate;
  String? createdTime;
  String? endTime;
  String? archivedDate;
  String? hostName;
  String? hostUsername;
  String? hostDob;
  String? hostGender;
  Null? name;
  Null? username;
  Null? dob;
  Null? gender;
  String? hostImageDp;
  String? userImageDp;
  String? userDob;
  String? userGender;
  bool? createStatus;

  SuperLuckyBagModel(
      {this.superLuckyBagDetailsId,
      this.amount,
      this.bagCreaterId,
      this.liveId,
      this.id,
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
      this.liveHideUnhideStatus,
      this.liveHideUnhideExpTime,
      this.totaltimePerLive,
      this.created,
      this.createdDate,
      this.createdTime,
      this.endTime,
      this.archivedDate,
      this.hostName,
      this.hostUsername,
      this.hostDob,
      this.hostGender,
      this.name,
      this.username,
      this.dob,
      this.gender,
      this.hostImageDp,
      this.userImageDp,
      this.userDob,
      this.userGender,
      this.createStatus});

  SuperLuckyBagModel.fromJson(Map<String, dynamic> json) {
    superLuckyBagDetailsId = json['superLuckyBagDetailsId'];
    amount = json['amount'];
    bagCreaterId = json['bagCreaterId'];
    liveId = json['liveId'];
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
    liveHideUnhideStatus = json['live_hideUnhideStatus'];
    liveHideUnhideExpTime = json['live_hideUnhideExpTime'];
    totaltimePerLive = json['totaltimePerLive'];
    created = json['created'];
    createdDate = json['createdDate'];
    createdTime = json['createdTime'];
    endTime = json['endTime'];
    archivedDate = json['archivedDate'];
    hostName = json['host_name'];
    hostUsername = json['host_username'];
    hostDob = json['host_dob'];
    hostGender = json['host_gender'];
    name = json['name'];
    username = json['username'];
    dob = json['dob'];
    gender = json['gender'];
    hostImageDp = json['host_imageDp'];
    userImageDp = json['user_imageDp'];
    userDob = json['user_dob'];
    userGender = json['user_gender'];
    createStatus = json['create_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['superLuckyBagDetailsId'] = superLuckyBagDetailsId;
    data['amount'] = amount;
    data['bagCreaterId'] = bagCreaterId;
    data['liveId'] = liveId;
    data['id'] = id;
    data['hostType'] = hostType;
    data['userId'] = userId;
    data['channelName'] = channelName;
    data['token'] = token;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['rtmToken'] = rtmToken;
    data['status'] = status;
    data['liveCount'] = liveCount;
    data['password'] = password;
    data['Liveimage'] = liveimage;
    data['imageText'] = imageText;
    data['imageTitle'] = imageTitle;
    data['live_hideUnhideStatus'] = liveHideUnhideStatus;
    data['live_hideUnhideExpTime'] = liveHideUnhideExpTime;
    data['totaltimePerLive'] = totaltimePerLive;
    data['created'] = created;
    data['createdDate'] = createdDate;
    data['createdTime'] = createdTime;
    data['endTime'] = endTime;
    data['archivedDate'] = archivedDate;
    data['host_name'] = hostName;
    data['host_username'] = hostUsername;
    data['host_dob'] = hostDob;
    data['host_gender'] = hostGender;
    data['name'] = name;
    data['username'] = username;
    data['dob'] = dob;
    data['gender'] = gender;
    data['host_imageDp'] = hostImageDp;
    data['user_imageDp'] = userImageDp;
    data['user_dob'] = userDob;
    data['user_gender'] = userGender;
    data['create_status'] = createStatus;
    return data;
  }
}
