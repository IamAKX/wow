class JoinableLiveRoomModel {
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
  String? name;
  String? imageDp;
  String? hostStatus;
  String? username;
  String? dob;
  String? gender;
  bool? kickOutStatus;
  String? userGender;
  String? userDob;

  JoinableLiveRoomModel(
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
      this.liveHideUnhideStatus,
      this.liveHideUnhideExpTime,
      this.totaltimePerLive,
      this.created,
      this.createdDate,
      this.createdTime,
      this.endTime,
      this.archivedDate,
      this.name,
      this.imageDp,
      this.hostStatus,
      this.username,
      this.dob,
      this.gender,
      this.kickOutStatus,
      this.userGender,
      this.userDob});

  JoinableLiveRoomModel.fromJson(Map<String, dynamic> json) {
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
    name = json['name'];
    imageDp = json['imageDp'];
    hostStatus = json['host_status'];
    username = json['username'];
    dob = json['dob'];
    gender = json['gender'];
    kickOutStatus = json['kickOutStatus'];
    userGender = json['user_gender'];
    userDob = json['user_dob'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
    data['name'] = name;
    data['imageDp'] = imageDp;
    data['host_status'] = hostStatus;
    data['username'] = username;
    data['dob'] = dob;
    data['gender'] = gender;
    data['kickOutStatus'] = kickOutStatus;
    data['user_gender'] = userGender;
    data['user_dob'] = userDob;
    return data;
  }
}
