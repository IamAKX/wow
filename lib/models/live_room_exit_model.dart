import 'dart:convert';

class LiveRoomExitModel {
  int? totalGift;
  LiveRoomExitModel({
    this.totalGift,
  });

  LiveRoomExitModel copyWith({
    int? totalGift,
  }) {
    return LiveRoomExitModel(
      totalGift: totalGift ?? this.totalGift,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (totalGift != null) {
      result.addAll({'totalGift': totalGift});
    }

    return result;
  }

  factory LiveRoomExitModel.fromMap(Map<String, dynamic> map) {
    return LiveRoomExitModel(
      totalGift: map['totalGift']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory LiveRoomExitModel.fromJson(String source) =>
      LiveRoomExitModel.fromMap(json.decode(source));

  @override
  String toString() => 'LiveRoomExitModel(totalGift: $totalGift)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LiveRoomExitModel && other.totalGift == totalGift;
  }

  @override
  int get hashCode => totalGift.hashCode;
}
