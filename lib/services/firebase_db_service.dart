import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:worldsocialintegrationapp/models/chat_model.dart';

import '../models/firebase_user.dart';
import '../utils/firebase_db_node.dart';

class FirebaseDbService {
  static FirebaseDatabase database = FirebaseDatabase.instance;

  static Future<void> addFriendRequest(
      FirebaseUserModel friendReq, String otherUserId) async {
    DatabaseReference friendRequestRef = database.ref(
        '${FirebaseDbNode.friendRequestList}/$otherUserId/${friendReq.userId}');
    await friendRequestRef.set(friendReq.toMap());
  }

  static Future<void> acceptFriendRequest(
      FirebaseUserModel user, FirebaseUserModel friendRequest) async {
    DatabaseReference friendRef1 = database.ref(
        '${FirebaseDbNode.friendList}/${user.userId}/${friendRequest.userId}');
    await friendRef1.set(friendRequest.toMap());
    DatabaseReference friendRef2 = database.ref(
        '${FirebaseDbNode.friendList}/${friendRequest.userId}/${user.userId}');
    await friendRef2.set(user.toMap());
    DatabaseReference friendRequestRef = database.ref(
        '${FirebaseDbNode.friendRequestList}/${user.userId}/${friendRequest.userId}');
    await friendRequestRef.remove();
  }

  static Future<void> rejectFriendRequest(
      FirebaseUserModel user, FirebaseUserModel friendRequest) async {
    DatabaseReference friendRequestRef = database.ref(
        '${FirebaseDbNode.friendRequestList}/${user.userId}/${friendRequest.userId}');
    await friendRequestRef.remove();
  }

  static Future<void> unFriend(
      FirebaseUserModel user, FirebaseUserModel friendRequest) async {
    DatabaseReference friendRef1 = database.ref(
        '${FirebaseDbNode.friendList}/${user.userId}/${friendRequest.userId}');
    await friendRef1.remove();
    DatabaseReference friendRef2 = database.ref(
        '${FirebaseDbNode.friendList}/${friendRequest.userId}/${user.userId}');
    await friendRef2.remove();
  }

  static Future<bool> friendRequestExists(
      String userId, String otherUserId) async {
    DatabaseReference requestRef = database
        .ref('${FirebaseDbNode.friendRequestList}/$otherUserId/$userId');
    DataSnapshot snapshot = await requestRef.get();
    if (snapshot.exists) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> isMyFriend(String userId, String otherUserId) async {
    DatabaseReference userFriendsRef =
        database.ref('${FirebaseDbNode.friendList}/$userId/$otherUserId');
    DataSnapshot snapshot = await userFriendsRef.get();
    if (snapshot.exists) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> isFriendRequested(
      String userId, String otherUserId) async {
    DatabaseReference userFriendsRef = database
        .ref('${FirebaseDbNode.friendRequestList}/$otherUserId/$userId');
    DataSnapshot snapshot = await userFriendsRef.get();
    if (snapshot.exists) {
      return true;
    } else {
      return false;
    }
  }

  static Future<List<FirebaseUserModel>> getFriendRequestList(
      String userId) async {
    List<FirebaseUserModel> list = [];
    DatabaseReference userFriendsRef =
        database.ref('${FirebaseDbNode.friendRequestList}/$userId');
    DataSnapshot snapshot = await userFriendsRef.get();
    if (snapshot.exists) {
      Map<dynamic, dynamic> friendsMap =
          snapshot.value as Map<dynamic, dynamic>;

      friendsMap.forEach((key, value) {
        list.add(FirebaseUserModel.fromMap(Map<String, dynamic>.from(value)));
      });
    }
    return list;
  }

  static Future<List<FirebaseUserModel>> getFriendsList(String userId) async {
    List<FirebaseUserModel> list = [];
    DatabaseReference userFriendsRef =
        database.ref('${FirebaseDbNode.friendList}/$userId');
    DataSnapshot snapshot = await userFriendsRef.get();
    if (snapshot.exists) {
      Map<dynamic, dynamic> friendsMap =
          snapshot.value as Map<dynamic, dynamic>;

      friendsMap.forEach((key, value) {
        list.add(FirebaseUserModel.fromMap(Map<String, dynamic>.from(value)));
      });
    }
    return list;
  }

  static Future<void> sendChat(String chatWindowId, ChatModel chat) async {
    chat.timestamp = DateTime.now().millisecondsSinceEpoch;
    DatabaseReference messageRef =
        database.ref('${FirebaseDbNode.message}/$chatWindowId');
    DatabaseReference newMessageRef = messageRef.push();
    chat.id = newMessageRef.key;
    return await newMessageRef.set(chat.toMap());
  }

  static Future<void> updateChat(String chatWindowId, ChatModel chat) async {
    chat.timestamp = DateTime.now().millisecondsSinceEpoch;
    DatabaseReference messageRef =
        database.ref('${FirebaseDbNode.message}/$chatWindowId/${chat.id}');
    return await messageRef.update(chat.toMap());
  }
}
