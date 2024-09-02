import 'dart:convert';

class CommentData {
  String? feedId;
  String? senderId;
  String? senderImage;
  CommentData({
    this.feedId,
    this.senderId,
    this.senderImage,
  });

  CommentData copyWith({
    String? feedId,
    String? senderId,
    String? senderImage,
  }) {
    return CommentData(
      feedId: feedId ?? this.feedId,
      senderId: senderId ?? this.senderId,
      senderImage: senderImage ?? this.senderImage,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (feedId != null) {
      result.addAll({'feedId': feedId});
    }
    if (senderId != null) {
      result.addAll({'senderId': senderId});
    }
    if (senderImage != null) {
      result.addAll({'senderImage': senderImage});
    }

    return result;
  }

  factory CommentData.fromMap(Map<String, dynamic> map) {
    return CommentData(
      feedId: map['feedId'],
      senderId: map['senderId'],
      senderImage: map['senderImage'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CommentData.fromJson(String source) =>
      CommentData.fromMap(json.decode(source));

  @override
  String toString() =>
      'CommentData(feedId: $feedId, senderId: $senderId, senderImage: $senderImage)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CommentData &&
        other.feedId == feedId &&
        other.senderId == senderId &&
        other.senderImage == senderImage;
  }

  @override
  int get hashCode =>
      feedId.hashCode ^ senderId.hashCode ^ senderImage.hashCode;
}
