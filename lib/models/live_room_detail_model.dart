import 'dart:convert';

class LiveRoomDetailModel {
  String? channelName;
  String? token;
  String? mainId;
  LiveRoomDetailModel({
    this.channelName,
    this.token,
    this.mainId,
  });

  LiveRoomDetailModel copyWith({
    String? channelName,
    String? token,
    String? mainId,
  }) {
    return LiveRoomDetailModel(
      channelName: channelName ?? this.channelName,
      token: token ?? this.token,
      mainId: mainId ?? this.mainId,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (channelName != null) {
      result.addAll({'channelName': channelName});
    }
    if (token != null) {
      result.addAll({'token': token});
    }
    if (mainId != null) {
      result.addAll({'mainId': mainId});
    }

    return result;
  }

  factory LiveRoomDetailModel.fromMap(Map<String, dynamic> map) {
    return LiveRoomDetailModel(
      channelName: map['channelName'],
      token: map['token'],
      mainId: map['mainId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LiveRoomDetailModel.fromJson(String source) =>
      LiveRoomDetailModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'LiveRoomDetailModel(channelName: $channelName, token: $token, mainId: $mainId)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LiveRoomDetailModel &&
        other.channelName == channelName &&
        other.token == token &&
        other.mainId == mainId;
  }

  @override
  int get hashCode => channelName.hashCode ^ token.hashCode ^ mainId.hashCode;
}
