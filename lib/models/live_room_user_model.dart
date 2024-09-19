import 'dart:convert';

class LiveRoomUserModel {
  String? id;
  String? username;
  String? familyId;
  String? phone;
  String? image;
  String? country;
  String? age;
  String? gender;
  String? sandColor;
  String? sandBgImage;
  String? sendLevel;
  String? sendExp;
  int? sendStart;
  int? sendEnd;
  String? reciveColor;
  String? reciveBgImage;
  String? reciveLevel;
  String? reciveExp;
  int? reciveStart;
  int? reciveEnd;
  LiveRoomUserModel({
    this.id,
    this.username,
    this.familyId,
    this.phone,
    this.image,
    this.country,
    this.age,
    this.gender,
    this.sandColor,
    this.sandBgImage,
    this.sendLevel,
    this.sendExp,
    this.sendStart,
    this.sendEnd,
    this.reciveColor,
    this.reciveBgImage,
    this.reciveLevel,
    this.reciveExp,
    this.reciveStart,
    this.reciveEnd,
  });

  LiveRoomUserModel copyWith({
    String? id,
    String? username,
    String? familyId,
    String? phone,
    String? image,
    String? country,
    String? age,
    String? gender,
    String? sandColor,
    String? sandBgImage,
    String? sendLevel,
    String? sendExp,
    int? sendStart,
    int? sendEnd,
    String? reciveColor,
    String? reciveBgImage,
    String? reciveLevel,
    String? reciveExp,
    int? reciveStart,
    int? reciveEnd,
  }) {
    return LiveRoomUserModel(
      id: id ?? this.id,
      username: username ?? this.username,
      familyId: familyId ?? this.familyId,
      phone: phone ?? this.phone,
      image: image ?? this.image,
      country: country ?? this.country,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      sandColor: sandColor ?? this.sandColor,
      sandBgImage: sandBgImage ?? this.sandBgImage,
      sendLevel: sendLevel ?? this.sendLevel,
      sendExp: sendExp ?? this.sendExp,
      sendStart: sendStart ?? this.sendStart,
      sendEnd: sendEnd ?? this.sendEnd,
      reciveColor: reciveColor ?? this.reciveColor,
      reciveBgImage: reciveBgImage ?? this.reciveBgImage,
      reciveLevel: reciveLevel ?? this.reciveLevel,
      reciveExp: reciveExp ?? this.reciveExp,
      reciveStart: reciveStart ?? this.reciveStart,
      reciveEnd: reciveEnd ?? this.reciveEnd,
    );
  }

  Map<dynamic, dynamic> toMap() {
    final result = <dynamic, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (username != null) {
      result.addAll({'username': username});
    }
    if (familyId != null) {
      result.addAll({'familyId': familyId});
    }
    if (phone != null) {
      result.addAll({'phone': phone});
    }
    if (image != null) {
      result.addAll({'image': image});
    }
    if (country != null) {
      result.addAll({'country': country});
    }
    if (age != null) {
      result.addAll({'age': age});
    }
    if (gender != null) {
      result.addAll({'gender': gender});
    }
    if (sandColor != null) {
      result.addAll({'sandColor': sandColor});
    }
    if (sandBgImage != null) {
      result.addAll({'sandBgImage': sandBgImage});
    }
    if (sendLevel != null) {
      result.addAll({'sendLevel': sendLevel});
    }
    if (sendExp != null) {
      result.addAll({'sendExp': sendExp});
    }
    if (sendStart != null) {
      result.addAll({'sendStart': sendStart});
    }
    if (sendEnd != null) {
      result.addAll({'sendEnd': sendEnd});
    }
    if (reciveColor != null) {
      result.addAll({'reciveColor': reciveColor});
    }
    if (reciveBgImage != null) {
      result.addAll({'reciveBgImage': reciveBgImage});
    }
    if (reciveLevel != null) {
      result.addAll({'reciveLevel': reciveLevel});
    }
    if (reciveExp != null) {
      result.addAll({'reciveExp': reciveExp});
    }
    if (reciveStart != null) {
      result.addAll({'reciveStart': reciveStart});
    }
    if (reciveEnd != null) {
      result.addAll({'reciveEnd': reciveEnd});
    }

    return result;
  }

  factory LiveRoomUserModel.fromMap(Map<dynamic, dynamic> map) {
    return LiveRoomUserModel(
      id: map['id'],
      username: map['username'],
      familyId: map['familyId'],
      phone: map['phone'],
      image: map['image'],
      country: map['country'],
      age: map['age'],
      gender: map['gender'],
      sandColor: map['sandColor'],
      sandBgImage: map['sandBgImage'],
      sendLevel: map['sendLevel'],
      sendExp: map['sendExp'],
      sendStart: map['sendStart']?.toInt(),
      sendEnd: map['sendEnd']?.toInt(),
      reciveColor: map['reciveColor'],
      reciveBgImage: map['reciveBgImage'],
      reciveLevel: map['reciveLevel'],
      reciveExp: map['reciveExp'],
      reciveStart: map['reciveStart']?.toInt(),
      reciveEnd: map['reciveEnd']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory LiveRoomUserModel.fromJson(String source) =>
      LiveRoomUserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'LiveRoomUserModel(id: $id, username: $username, familyId: $familyId, phone: $phone, image: $image, country: $country, age: $age, gender: $gender, sandColor: $sandColor, sandBgImage: $sandBgImage, sendLevel: $sendLevel, sendExp: $sendExp, sendStart: $sendStart, sendEnd: $sendEnd, reciveColor: $reciveColor, reciveBgImage: $reciveBgImage, reciveLevel: $reciveLevel, reciveExp: $reciveExp, reciveStart: $reciveStart, reciveEnd: $reciveEnd)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LiveRoomUserModel &&
        other.id == id &&
        other.username == username &&
        other.familyId == familyId &&
        other.phone == phone &&
        other.image == image &&
        other.country == country &&
        other.age == age &&
        other.gender == gender &&
        other.sandColor == sandColor &&
        other.sandBgImage == sandBgImage &&
        other.sendLevel == sendLevel &&
        other.sendExp == sendExp &&
        other.sendStart == sendStart &&
        other.sendEnd == sendEnd &&
        other.reciveColor == reciveColor &&
        other.reciveBgImage == reciveBgImage &&
        other.reciveLevel == reciveLevel &&
        other.reciveExp == reciveExp &&
        other.reciveStart == reciveStart &&
        other.reciveEnd == reciveEnd;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        username.hashCode ^
        familyId.hashCode ^
        phone.hashCode ^
        image.hashCode ^
        country.hashCode ^
        age.hashCode ^
        gender.hashCode ^
        sandColor.hashCode ^
        sandBgImage.hashCode ^
        sendLevel.hashCode ^
        sendExp.hashCode ^
        sendStart.hashCode ^
        sendEnd.hashCode ^
        reciveColor.hashCode ^
        reciveBgImage.hashCode ^
        reciveLevel.hashCode ^
        reciveExp.hashCode ^
        reciveStart.hashCode ^
        reciveEnd.hashCode;
  }
}
