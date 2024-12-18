import 'dart:convert';

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
  String? liveHideUnhideStatus;
  String? liveHideUnhideExpTime;
  String? totaltimePerLive;
  String? created;
  String? createdDate;
  String? createdTime;
  String? endTime;
  String? archivedDate;
  UserLive({
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
  });

  UserLive copyWith({
    String? id,
    String? hostType,
    String? userId,
    String? channelName,
    String? token,
    String? latitude,
    String? longitude,
    String? rtmToken,
    String? status,
    String? liveCount,
    String? password,
    String? liveimage,
    String? imageText,
    String? imageTitle,
    String? liveHideUnhideStatus,
    String? liveHideUnhideExpTime,
    String? totaltimePerLive,
    String? created,
    String? createdDate,
    String? createdTime,
    String? endTime,
    String? archivedDate,
  }) {
    return UserLive(
      id: id ?? this.id,
      hostType: hostType ?? this.hostType,
      userId: userId ?? this.userId,
      channelName: channelName ?? this.channelName,
      token: token ?? this.token,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      rtmToken: rtmToken ?? this.rtmToken,
      status: status ?? this.status,
      liveCount: liveCount ?? this.liveCount,
      password: password ?? this.password,
      liveimage: liveimage ?? this.liveimage,
      imageText: imageText ?? this.imageText,
      imageTitle: imageTitle ?? this.imageTitle,
      liveHideUnhideStatus: liveHideUnhideStatus ?? this.liveHideUnhideStatus,
      liveHideUnhideExpTime: liveHideUnhideExpTime ?? this.liveHideUnhideExpTime,
      totaltimePerLive: totaltimePerLive ?? this.totaltimePerLive,
      created: created ?? this.created,
      createdDate: createdDate ?? this.createdDate,
      createdTime: createdTime ?? this.createdTime,
      endTime: endTime ?? this.endTime,
      archivedDate: archivedDate ?? this.archivedDate,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(id != null){
      result.addAll({'id': id});
    }
    if(hostType != null){
      result.addAll({'hostType': hostType});
    }
    if(userId != null){
      result.addAll({'userId': userId});
    }
    if(channelName != null){
      result.addAll({'channelName': channelName});
    }
    if(token != null){
      result.addAll({'token': token});
    }
    if(latitude != null){
      result.addAll({'latitude': latitude});
    }
    if(longitude != null){
      result.addAll({'longitude': longitude});
    }
    if(rtmToken != null){
      result.addAll({'rtmToken': rtmToken});
    }
    if(status != null){
      result.addAll({'status': status});
    }
    if(liveCount != null){
      result.addAll({'liveCount': liveCount});
    }
    if(password != null){
      result.addAll({'password': password});
    }
    if(liveimage != null){
      result.addAll({'liveimage': liveimage});
    }
    if(imageText != null){
      result.addAll({'imageText': imageText});
    }
    if(imageTitle != null){
      result.addAll({'imageTitle': imageTitle});
    }
    if(liveHideUnhideStatus != null){
      result.addAll({'liveHideUnhideStatus': liveHideUnhideStatus});
    }
    if(liveHideUnhideExpTime != null){
      result.addAll({'liveHideUnhideExpTime': liveHideUnhideExpTime});
    }
    if(totaltimePerLive != null){
      result.addAll({'totaltimePerLive': totaltimePerLive});
    }
    if(created != null){
      result.addAll({'created': created});
    }
    if(createdDate != null){
      result.addAll({'createdDate': createdDate});
    }
    if(createdTime != null){
      result.addAll({'createdTime': createdTime});
    }
    if(endTime != null){
      result.addAll({'endTime': endTime});
    }
    if(archivedDate != null){
      result.addAll({'archivedDate': archivedDate});
    }
  
    return result;
  }

  factory UserLive.fromMap(Map<String, dynamic> map) {
    return UserLive(
      id: map['id'],
      hostType: map['hostType'],
      userId: map['userId'],
      channelName: map['channelName'],
      token: map['token'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      rtmToken: map['rtmToken'],
      status: map['status'],
      liveCount: map['liveCount'],
      password: map['password'],
      liveimage: map['liveimage'],
      imageText: map['imageText'],
      imageTitle: map['imageTitle'],
      liveHideUnhideStatus: map['liveHideUnhideStatus'],
      liveHideUnhideExpTime: map['liveHideUnhideExpTime'],
      totaltimePerLive: map['totaltimePerLive'],
      created: map['created'],
      createdDate: map['createdDate'],
      createdTime: map['createdTime'],
      endTime: map['endTime'],
      archivedDate: map['archivedDate'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserLive.fromJson(String source) => UserLive.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserLive(id: $id, hostType: $hostType, userId: $userId, channelName: $channelName, token: $token, latitude: $latitude, longitude: $longitude, rtmToken: $rtmToken, status: $status, liveCount: $liveCount, password: $password, liveimage: $liveimage, imageText: $imageText, imageTitle: $imageTitle, liveHideUnhideStatus: $liveHideUnhideStatus, liveHideUnhideExpTime: $liveHideUnhideExpTime, totaltimePerLive: $totaltimePerLive, created: $created, createdDate: $createdDate, createdTime: $createdTime, endTime: $endTime, archivedDate: $archivedDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is UserLive &&
      other.id == id &&
      other.hostType == hostType &&
      other.userId == userId &&
      other.channelName == channelName &&
      other.token == token &&
      other.latitude == latitude &&
      other.longitude == longitude &&
      other.rtmToken == rtmToken &&
      other.status == status &&
      other.liveCount == liveCount &&
      other.password == password &&
      other.liveimage == liveimage &&
      other.imageText == imageText &&
      other.imageTitle == imageTitle &&
      other.liveHideUnhideStatus == liveHideUnhideStatus &&
      other.liveHideUnhideExpTime == liveHideUnhideExpTime &&
      other.totaltimePerLive == totaltimePerLive &&
      other.created == created &&
      other.createdDate == createdDate &&
      other.createdTime == createdTime &&
      other.endTime == endTime &&
      other.archivedDate == archivedDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      hostType.hashCode ^
      userId.hashCode ^
      channelName.hashCode ^
      token.hashCode ^
      latitude.hashCode ^
      longitude.hashCode ^
      rtmToken.hashCode ^
      status.hashCode ^
      liveCount.hashCode ^
      password.hashCode ^
      liveimage.hashCode ^
      imageText.hashCode ^
      imageTitle.hashCode ^
      liveHideUnhideStatus.hashCode ^
      liveHideUnhideExpTime.hashCode ^
      totaltimePerLive.hashCode ^
      created.hashCode ^
      createdDate.hashCode ^
      createdTime.hashCode ^
      endTime.hashCode ^
      archivedDate.hashCode;
  }
}
