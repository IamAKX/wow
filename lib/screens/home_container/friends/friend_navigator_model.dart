import 'dart:convert';

class FriendNavigatorModel {
  int index;
  String userId;
  FriendNavigatorModel({
    required this.index,
    required this.userId,
  });

  FriendNavigatorModel copyWith({
    int? index,
    String? userId,
  }) {
    return FriendNavigatorModel(
      index: index ?? this.index,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'index': index});
    result.addAll({'userId': userId});

    return result;
  }

  factory FriendNavigatorModel.fromMap(Map<String, dynamic> map) {
    return FriendNavigatorModel(
      index: map['index']?.toInt() ?? 0,
      userId: map['userId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory FriendNavigatorModel.fromJson(String source) =>
      FriendNavigatorModel.fromMap(json.decode(source));

  @override
  String toString() => 'FriendNavigatorModel(index: $index, userId: $userId)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FriendNavigatorModel &&
        other.index == index &&
        other.userId == userId;
  }

  @override
  int get hashCode => index.hashCode ^ userId.hashCode;
}
