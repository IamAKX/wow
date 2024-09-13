import 'dart:convert';

class LiveroomChat {
  String? message;
  String? userImage;
  String? userId;
  String? userName;
  int? timeStamp;
  LiveroomChat({
    this.message,
    this.userImage,
    this.userId,
    this.userName,
    this.timeStamp,
  });

  LiveroomChat copyWith({
    String? message,
    String? userImage,
    String? userId,
    String? userName,
    int? timeStamp,
  }) {
    return LiveroomChat(
      message: message ?? this.message,
      userImage: userImage ?? this.userImage,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      timeStamp: timeStamp ?? this.timeStamp,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (message != null) {
      result.addAll({'message': message});
    }
    if (userImage != null) {
      result.addAll({'userImage': userImage});
    }
    if (userId != null) {
      result.addAll({'userId': userId});
    }
    if (userName != null) {
      result.addAll({'userName': userName});
    }
    if (timeStamp != null) {
      result.addAll({'timeStamp': timeStamp});
    }

    return result;
  }

  factory LiveroomChat.fromMap(Map<dynamic, dynamic> map) {
    return LiveroomChat(
      message: map['message'],
      userImage: map['userImage'],
      userId: map['userId'],
      userName: map['userName'],
      timeStamp: map['timeStamp']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory LiveroomChat.fromJson(String source) =>
      LiveroomChat.fromMap(json.decode(source));

  @override
  String toString() {
    return 'LiveroomChat(message: $message, userImage: $userImage, userId: $userId, userName: $userName, timeStamp: $timeStamp)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LiveroomChat &&
        other.message == message &&
        other.userImage == userImage &&
        other.userId == userId &&
        other.userName == userName &&
        other.timeStamp == timeStamp;
  }

  @override
  int get hashCode {
    return message.hashCode ^
        userImage.hashCode ^
        userId.hashCode ^
        userName.hashCode ^
        timeStamp.hashCode;
  }
}
