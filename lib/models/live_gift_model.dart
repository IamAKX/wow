import 'dart:convert';

class LiveGiftModel {
  String? url;
  String? senderId;
  String? receiverId;
  int? position;
  LiveGiftModel({
    this.url,
    this.senderId,
    this.receiverId,
    this.position,
  });

  LiveGiftModel copyWith({
    String? url,
    String? senderId,
    String? receiverId,
    int? position,
  }) {
    return LiveGiftModel(
      url: url ?? this.url,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      position: position ?? this.position,
    );
  }

  Map toMap() {
    final result = <dynamic, dynamic>{};

    if (url != null) {
      result.addAll({'url': url});
    }
    if (senderId != null) {
      result.addAll({'senderId': senderId});
    }
    if (receiverId != null) {
      result.addAll({'receiverId': receiverId});
    }
    if (position != null) {
      result.addAll({'position': position});
    }

    return result;
  }

  factory LiveGiftModel.fromMap(Map map) {
    return LiveGiftModel(
      url: map['url'],
      senderId: map['senderId'],
      receiverId: map['receiverId'],
      position: map['position']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory LiveGiftModel.fromJson(String source) =>
      LiveGiftModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'LiveGiftModel(url: $url, senderId: $senderId, receiverId: $receiverId, position: $position)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LiveGiftModel &&
        other.url == url &&
        other.senderId == senderId &&
        other.receiverId == receiverId &&
        other.position == position;
  }

  @override
  int get hashCode {
    return url.hashCode ^
        senderId.hashCode ^
        receiverId.hashCode ^
        position.hashCode;
  }
}
