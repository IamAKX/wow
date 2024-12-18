import 'dart:convert';

class LiveRoomDetailModel {
  String? channelName;
  String? token;
  String? mainId;
  bool? isSelfCreated;
  String? roomCreatedBy;
  LiveRoomDetailModel({
    this.channelName,
    this.token,
    this.mainId,
    this.isSelfCreated,
    this.roomCreatedBy,
  });

  LiveRoomDetailModel copyWith({
    String? channelName,
    String? token,
    String? mainId,
    bool? isSelfCreated,
    String? roomCreatedBy,
  }) {
    return LiveRoomDetailModel(
      channelName: channelName ?? this.channelName,
      token: token ?? this.token,
      mainId: mainId ?? this.mainId,
      isSelfCreated: isSelfCreated ?? this.isSelfCreated,
      roomCreatedBy: roomCreatedBy ?? this.roomCreatedBy,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(channelName != null){
      result.addAll({'channelName': channelName});
    }
    if(token != null){
      result.addAll({'token': token});
    }
    if(mainId != null){
      result.addAll({'mainId': mainId});
    }
    if(isSelfCreated != null){
      result.addAll({'isSelfCreated': isSelfCreated});
    }
    if(roomCreatedBy != null){
      result.addAll({'roomCreatedBy': roomCreatedBy});
    }
  
    return result;
  }

  factory LiveRoomDetailModel.fromMap(Map<String, dynamic> map) {
    return LiveRoomDetailModel(
      channelName: map['channelName'],
      token: map['token'],
      mainId: map['mainId'],
      isSelfCreated: map['isSelfCreated'],
      roomCreatedBy: map['roomCreatedBy'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LiveRoomDetailModel.fromJson(String source) => LiveRoomDetailModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'LiveRoomDetailModel(channelName: $channelName, token: $token, mainId: $mainId, isSelfCreated: $isSelfCreated, roomCreatedBy: $roomCreatedBy)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is LiveRoomDetailModel &&
      other.channelName == channelName &&
      other.token == token &&
      other.mainId == mainId &&
      other.isSelfCreated == isSelfCreated &&
      other.roomCreatedBy == roomCreatedBy;
  }

  @override
  int get hashCode {
    return channelName.hashCode ^
      token.hashCode ^
      mainId.hashCode ^
      isSelfCreated.hashCode ^
      roomCreatedBy.hashCode;
  }
}
