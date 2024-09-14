import 'dart:convert';

class AgencyModel {
  String? agencyCode;
  String? username;
  String? image;
  AgencyModel({
    this.agencyCode,
    this.username,
    this.image,
  });

  AgencyModel copyWith({
    String? agencyCode,
    String? username,
    String? image,
  }) {
    return AgencyModel(
      agencyCode: agencyCode ?? this.agencyCode,
      username: username ?? this.username,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (agencyCode != null) {
      result.addAll({'agencyCode': agencyCode});
    }
    if (username != null) {
      result.addAll({'username': username});
    }
    if (image != null) {
      result.addAll({'image': image});
    }

    return result;
  }

  factory AgencyModel.fromMap(Map<String, dynamic> map) {
    return AgencyModel(
      agencyCode: map['agencyCode'],
      username: map['username'],
      image: map['image'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AgencyModel.fromJson(String source) =>
      AgencyModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'AgencyModel(agencyCode: $agencyCode, username: $username, image: $image)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AgencyModel &&
        other.agencyCode == agencyCode &&
        other.username == username &&
        other.image == image;
  }

  @override
  int get hashCode => agencyCode.hashCode ^ username.hashCode ^ image.hashCode;
}
