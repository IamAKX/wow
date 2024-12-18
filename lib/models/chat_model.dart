import 'dart:convert';

class ChatModel {
  String? senderId;
  String? message;
  String? msgType;
  String? url;
  String? videoThumbnaiil;
  int? timestamp;
  String? assetId;
  String? assetTypeName;
  String? assetTypeId;
  bool? isClaimed;
  String? id;
  String? extra1;
  String? extra2;
  String? extra3;
  String? extra4;
  String? extra5;
  String? extra6;
  String? extra7;
  String? extra8;
  String? extra9;
  ChatModel({
    this.senderId,
    this.message,
    this.msgType,
    this.url,
    this.videoThumbnaiil,
    this.timestamp,
    this.assetId,
    this.assetTypeName,
    this.assetTypeId,
    this.isClaimed,
    this.id,
    this.extra1,
    this.extra2,
    this.extra3,
    this.extra4,
    this.extra5,
    this.extra6,
    this.extra7,
    this.extra8,
    this.extra9,
  });

  ChatModel copyWith({
    String? senderId,
    String? message,
    String? msgType,
    String? url,
    String? videoThumbnaiil,
    int? timestamp,
    String? assetId,
    String? assetTypeName,
    String? assetTypeId,
    bool? isClaimed,
    String? id,
    String? extra1,
    String? extra2,
    String? extra3,
    String? extra4,
    String? extra5,
    String? extra6,
    String? extra7,
    String? extra8,
    String? extra9,
  }) {
    return ChatModel(
      senderId: senderId ?? this.senderId,
      message: message ?? this.message,
      msgType: msgType ?? this.msgType,
      url: url ?? this.url,
      videoThumbnaiil: videoThumbnaiil ?? this.videoThumbnaiil,
      timestamp: timestamp ?? this.timestamp,
      assetId: assetId ?? this.assetId,
      assetTypeName: assetTypeName ?? this.assetTypeName,
      assetTypeId: assetTypeId ?? this.assetTypeId,
      isClaimed: isClaimed ?? this.isClaimed,
      id: id ?? this.id,
      extra1: extra1 ?? this.extra1,
      extra2: extra2 ?? this.extra2,
      extra3: extra3 ?? this.extra3,
      extra4: extra4 ?? this.extra4,
      extra5: extra5 ?? this.extra5,
      extra6: extra6 ?? this.extra6,
      extra7: extra7 ?? this.extra7,
      extra8: extra8 ?? this.extra8,
      extra9: extra9 ?? this.extra9,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (senderId != null) {
      result.addAll({'senderId': senderId});
    }
    if (message != null) {
      result.addAll({'message': message});
    }
    if (msgType != null) {
      result.addAll({'msgType': msgType});
    }
    if (url != null) {
      result.addAll({'url': url});
    }
    if (videoThumbnaiil != null) {
      result.addAll({'videoThumbnaiil': videoThumbnaiil});
    }
    if (timestamp != null) {
      result.addAll({'timestamp': timestamp});
    }
    if (assetId != null) {
      result.addAll({'assetId': assetId});
    }
    if (assetTypeName != null) {
      result.addAll({'assetTypeName': assetTypeName});
    }
    if (assetTypeId != null) {
      result.addAll({'assetTypeId': assetTypeId});
    }
    if (isClaimed != null) {
      result.addAll({'isClaimed': isClaimed});
    }
    if (id != null) {
      result.addAll({'id': id});
    }
    if (extra1 != null) {
      result.addAll({'extra1': extra1});
    }
    if (extra2 != null) {
      result.addAll({'extra2': extra2});
    }
    if (extra3 != null) {
      result.addAll({'extra3': extra3});
    }
    if (extra4 != null) {
      result.addAll({'extra4': extra4});
    }
    if (extra5 != null) {
      result.addAll({'extra5': extra5});
    }
    if (extra6 != null) {
      result.addAll({'extra6': extra6});
    }
    if (extra7 != null) {
      result.addAll({'extra7': extra7});
    }
    if (extra8 != null) {
      result.addAll({'extra8': extra8});
    }
    if (extra9 != null) {
      result.addAll({'extra9': extra9});
    }

    return result;
  }

  factory ChatModel.fromMap(Map map) {
    return ChatModel(
      senderId: map['senderId'],
      message: map['message'],
      msgType: map['msgType'],
      url: map['url'],
      videoThumbnaiil: map['videoThumbnaiil'],
      timestamp: map['timestamp']?.toInt(),
      assetId: map['assetId'],
      assetTypeName: map['assetTypeName'],
      assetTypeId: map['assetTypeId'],
      isClaimed: map['isClaimed'],
      id: map['id'],
      extra1: map['extra1'],
      extra2: map['extra2'],
      extra3: map['extra3'],
      extra4: map['extra4'],
      extra5: map['extra5'],
      extra6: map['extra6'],
      extra7: map['extra7'],
      extra8: map['extra8'],
      extra9: map['extra9'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatModel.fromJson(String source) =>
      ChatModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ChatModel(senderId: $senderId, message: $message, msgType: $msgType, url: $url, videoThumbnaiil: $videoThumbnaiil, timestamp: $timestamp, assetId: $assetId, assetTypeName: $assetTypeName, assetTypeId: $assetTypeId, isClaimed: $isClaimed, id: $id, extra1: $extra1, extra2: $extra2, extra3: $extra3, extra4: $extra4, extra5: $extra5, extra6: $extra6, extra7: $extra7, extra8: $extra8, extra9: $extra9)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChatModel &&
        other.senderId == senderId &&
        other.message == message &&
        other.msgType == msgType &&
        other.url == url &&
        other.videoThumbnaiil == videoThumbnaiil &&
        other.timestamp == timestamp &&
        other.assetId == assetId &&
        other.assetTypeName == assetTypeName &&
        other.assetTypeId == assetTypeId &&
        other.isClaimed == isClaimed &&
        other.id == id &&
        other.extra1 == extra1 &&
        other.extra2 == extra2 &&
        other.extra3 == extra3 &&
        other.extra4 == extra4 &&
        other.extra5 == extra5 &&
        other.extra6 == extra6 &&
        other.extra7 == extra7 &&
        other.extra8 == extra8 &&
        other.extra9 == extra9;
  }

  @override
  int get hashCode {
    return senderId.hashCode ^
        message.hashCode ^
        msgType.hashCode ^
        url.hashCode ^
        videoThumbnaiil.hashCode ^
        timestamp.hashCode ^
        assetId.hashCode ^
        assetTypeName.hashCode ^
        assetTypeId.hashCode ^
        isClaimed.hashCode ^
        id.hashCode ^
        extra1.hashCode ^
        extra2.hashCode ^
        extra3.hashCode ^
        extra4.hashCode ^
        extra5.hashCode ^
        extra6.hashCode ^
        extra7.hashCode ^
        extra8.hashCode ^
        extra9.hashCode;
  }
}
