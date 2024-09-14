class NewLiveUserModel {
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
  String? username;
  String? name;
  String? imageDp;

  NewLiveUserModel(
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
      this.archivedDate,
      this.username,
      this.name,
      this.imageDp});

  NewLiveUserModel.fromJson(Map<String, dynamic> json) {
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
    username = json['username'];
    name = json['name'];
    imageDp = json['imageDp'];
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
    data['bool'] = bool;
    data['live_hideUnhideStatus'] = liveHideUnhideStatus;
    data['live_hideUnhideExpTime'] = liveHideUnhideExpTime;
    data['totaltimePerLive'] = totaltimePerLive;
    data['created'] = created;
    data['createdDate'] = createdDate;
    data['createdTime'] = createdTime;
    data['endTime'] = endTime;
    data['archivedDate'] = archivedDate;
    data['username'] = username;
    data['name'] = name;
    data['imageDp'] = imageDp;
    return data;
  }
}
