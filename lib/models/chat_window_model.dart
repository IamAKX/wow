import 'dart:convert';

import 'package:worldsocialintegrationapp/models/user_profile_detail.dart';
import 'package:worldsocialintegrationapp/models/visitor_model.dart';

class ChatWindowModel {
  String? chatWindowId;
  UserProfileDetail? currentUser;
  VisitorModel? friendUser;
  ChatWindowModel({
    this.chatWindowId,
    this.currentUser,
    this.friendUser,
  });

  ChatWindowModel copyWith({
    String? chatWindowId,
    UserProfileDetail? currentUser,
    VisitorModel? friendUser,
  }) {
    return ChatWindowModel(
      chatWindowId: chatWindowId ?? this.chatWindowId,
      currentUser: currentUser ?? this.currentUser,
      friendUser: friendUser ?? this.friendUser,
    );
  }

  factory ChatWindowModel.fromMap(Map<String, dynamic> map) {
    return ChatWindowModel(
      chatWindowId: map['chatWindowId'],
      currentUser: map['currentUser'] != null
          ? UserProfileDetail.fromMap(map['currentUser'])
          : null,
      friendUser: map['friendUser'] != null
          ? VisitorModel.fromMap(map['friendUser'])
          : null,
    );
  }

  factory ChatWindowModel.fromJson(String source) =>
      ChatWindowModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'ChatWindowModel(chatWindowId: $chatWindowId, currentUser: $currentUser, friendUser: $friendUser)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChatWindowModel &&
        other.chatWindowId == chatWindowId &&
        other.currentUser == currentUser &&
        other.friendUser == friendUser;
  }

  @override
  int get hashCode =>
      chatWindowId.hashCode ^ currentUser.hashCode ^ friendUser.hashCode;
}
