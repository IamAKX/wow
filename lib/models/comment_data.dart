import 'dart:convert';

class CommentData {
  String? feedId;
  String? senderId;
  String? senderImage;
  String? feedSenderId;
  CommentData({
    this.feedId,
    this.senderId,
    this.senderImage,
    this.feedSenderId,
  });

  CommentData copyWith({
    String? feedId,
    String? senderId,
    String? senderImage,
    String? feedSenderId,
  }) {
    return CommentData(
      feedId: feedId ?? this.feedId,
      senderId: senderId ?? this.senderId,
      senderImage: senderImage ?? this.senderImage,
      feedSenderId: feedSenderId ?? this.feedSenderId,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(feedId != null){
      result.addAll({'feedId': feedId});
    }
    if(senderId != null){
      result.addAll({'senderId': senderId});
    }
    if(senderImage != null){
      result.addAll({'senderImage': senderImage});
    }
    if(feedSenderId != null){
      result.addAll({'feedSenderId': feedSenderId});
    }
  
    return result;
  }

  factory CommentData.fromMap(Map<String, dynamic> map) {
    return CommentData(
      feedId: map['feedId'],
      senderId: map['senderId'],
      senderImage: map['senderImage'],
      feedSenderId: map['feedSenderId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CommentData.fromJson(String source) => CommentData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CommentData(feedId: $feedId, senderId: $senderId, senderImage: $senderImage, feedSenderId: $feedSenderId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is CommentData &&
      other.feedId == feedId &&
      other.senderId == senderId &&
      other.senderImage == senderImage &&
      other.feedSenderId == feedSenderId;
  }

  @override
  int get hashCode {
    return feedId.hashCode ^
      senderId.hashCode ^
      senderImage.hashCode ^
      feedSenderId.hashCode;
  }
}
