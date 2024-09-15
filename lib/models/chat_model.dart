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
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatModel.fromJson(String source) =>
      ChatModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ChatModel(senderId: $senderId, message: $message, msgType: $msgType, url: $url, videoThumbnaiil: $videoThumbnaiil, timestamp: $timestamp, assetId: $assetId, assetTypeName: $assetTypeName, assetTypeId: $assetTypeId, isClaimed: $isClaimed, id: $id)';
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
        other.id == id;
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
        id.hashCode;
  }
}
