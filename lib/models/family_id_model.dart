import 'dart:convert';

class FamilyIdModel {
  String? familyId;
  String? userId;
  FamilyIdModel({
    this.familyId,
    this.userId,
  });

  FamilyIdModel copyWith({
    String? familyId,
    String? userId,
  }) {
    return FamilyIdModel(
      familyId: familyId ?? this.familyId,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (familyId != null) {
      result.addAll({'familyId': familyId});
    }
    if (userId != null) {
      result.addAll({'userId': userId});
    }

    return result;
  }

  factory FamilyIdModel.fromMap(Map<String, dynamic> map) {
    return FamilyIdModel(
      familyId: map['familyId'],
      userId: map['userId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory FamilyIdModel.fromJson(String source) =>
      FamilyIdModel.fromMap(json.decode(source));

  @override
  String toString() => 'FamilyIdModel(familyId: $familyId, userId: $userId)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FamilyIdModel &&
        other.familyId == familyId &&
        other.userId == userId;
  }

  @override
  int get hashCode => familyId.hashCode ^ userId.hashCode;
}
