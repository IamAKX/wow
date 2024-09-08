import 'dart:convert';

class FirebaseUserModel {
  String? userId;
  String? userName;
  String? name;
  String? image;
  String? lastMessage;
  FirebaseUserModel({
    this.userId,
    this.userName,
    this.name,
    this.image,
    this.lastMessage,
  });

  FirebaseUserModel copyWith({
    String? userId,
    String? userName,
    String? name,
    String? image,
    String? lastMessage,
  }) {
    return FirebaseUserModel(
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      name: name ?? this.name,
      image: image ?? this.image,
      lastMessage: lastMessage ?? this.lastMessage,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (userId != null) {
      result.addAll({'userId': userId});
    }
    if (userName != null) {
      result.addAll({'userName': userName});
    }
    if (name != null) {
      result.addAll({'name': name});
    }
    if (image != null) {
      result.addAll({'image': image});
    }
    if (lastMessage != null) {
      result.addAll({'lastMessage': lastMessage});
    }

    return result;
  }

  factory FirebaseUserModel.fromMap(Map<String, dynamic> map) {
    return FirebaseUserModel(
      userId: map['userId'],
      userName: map['userName'],
      name: map['name'],
      image: map['image'],
      lastMessage: map['lastMessage'],
    );
  }

  String toJson() => json.encode(toMap());

  factory FirebaseUserModel.fromJson(String source) =>
      FirebaseUserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FirebaseUserModel(userId: $userId, userName: $userName, name: $name, image: $image, lastMessage: $lastMessage)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FirebaseUserModel &&
        other.userId == userId &&
        other.userName == userName &&
        other.name == name &&
        other.image == image &&
        other.lastMessage == lastMessage;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        userName.hashCode ^
        name.hashCode ^
        image.hashCode ^
        lastMessage.hashCode;
  }
}
