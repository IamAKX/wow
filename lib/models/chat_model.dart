import 'dart:convert';

class ChatModel {
  String? senderId;
  String? message;
  String? msgType;
  String? url;
  String? videoThumbnaiil;
  int? timestamp;
  String? assetId;
  ChatModel({
    this.senderId,
    this.message,
    this.msgType,
    this.url,
    this.videoThumbnaiil,
    this.timestamp,
    this.assetId,
  });

  ChatModel copyWith({
    String? senderId,
    String? message,
    String? msgType,
    String? url,
    String? videoThumbnaiil,
    int? timestamp,
    String? assetId,
  }) {
    return ChatModel(
      senderId: senderId ?? this.senderId,
      message: message ?? this.message,
      msgType: msgType ?? this.msgType,
      url: url ?? this.url,
      videoThumbnaiil: videoThumbnaiil ?? this.videoThumbnaiil,
      timestamp: timestamp ?? this.timestamp,
      assetId: assetId ?? this.assetId,
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

    return result;
  }

  factory ChatModel.fromMap(Map<dynamic, dynamic> map) {
    return ChatModel(
      senderId: map['senderId'],
      message: map['message'],
      msgType: map['msgType'],
      url: map['url'],
      videoThumbnaiil: map['videoThumbnaiil'],
      timestamp: map['timestamp']?.toInt(),
      assetId: map['assetId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatModel.fromJson(String source) =>
      ChatModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ChatModel(senderId: $senderId, message: $message, msgType: $msgType, url: $url, videoThumbnaiil: $videoThumbnaiil, timestamp: $timestamp, assetId: $assetId)';
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
        other.assetId == assetId;
  }

  @override
  int get hashCode {
    return senderId.hashCode ^
        message.hashCode ^
        msgType.hashCode ^
        url.hashCode ^
        videoThumbnaiil.hashCode ^
        timestamp.hashCode ^
        assetId.hashCode;
  }
}
