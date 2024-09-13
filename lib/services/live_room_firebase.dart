import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:worldsocialintegrationapp/models/joinable_live_room_model.dart';
import 'package:worldsocialintegrationapp/models/liveroom_chat.dart';
import 'package:worldsocialintegrationapp/utils/firebase_db_node.dart';

class LiveRoomFirebase {
  static FirebaseDatabase database = FirebaseDatabase.instance;

  static Future<void> updateLiveRoomInfo(
      JoinableLiveRoomModel roomDetails) async {
    DatabaseReference liveRoomRef =
        database.ref('${FirebaseDbNode.liveRoom}/${roomDetails.id}');
    log('updating : ${roomDetails.password}');
    await liveRoomRef.update(roomDetails.toJson());
  }

  static Future<JoinableLiveRoomModel?> getLiveRoomInfo(String id) async {
    DatabaseReference liveRoomRef =
        database.ref('${FirebaseDbNode.liveRoom}/$id');
    JoinableLiveRoomModel? roomDeatil;
    DataSnapshot snapshot = await liveRoomRef.get();
    if (snapshot.exists) {
      roomDeatil = JoinableLiveRoomModel.fromJson(
          snapshot.value as Map<String, dynamic>);
    }
    return roomDeatil;
  }

  static Future<void> toggleUserInRoomArray(
      String roomId, String userId) async {
    try {
      DataSnapshot snapshot = await database
          .ref(FirebaseDbNode.liveRoomParticipants)
          .child(roomId)
          .get();

      if (snapshot.exists) {
        List<dynamic> userList = List.from(snapshot.value as List);

        if (userList.contains(userId)) {
          userList.remove(userId);
          log('User $userId removed from room $roomId');
        } else {
          userList.add(userId);
          log('User $userId added to room $roomId');
        }

        // Update the database with the modified list
        await database
            .ref(FirebaseDbNode.liveRoomParticipants)
            .child(roomId)
            .set(userList);
      } else {
        // If the room doesn't exist, create it with the userId
        await database
            .ref(FirebaseDbNode.liveRoomParticipants)
            .child(roomId)
            .set([userId]);
        log('Room $roomId created with user $userId');
      }
    } catch (e) {
      log('Failed to toggle user: $e');
    }
  }

  static Future<void> updateLiveRoomAnnoucement(
      String roomId, String message) async {
    DatabaseReference liveRoomRef =
        database.ref('${FirebaseDbNode.liveRoomAnnouncement}/$roomId');
    await liveRoomRef.set(message);
  }

  static Future<void> sendChat(String chatWindowId, LiveroomChat chat) async {
    DatabaseReference messageRef =
        database.ref('${FirebaseDbNode.liveRoomChat}/$chatWindowId');
    DatabaseReference newMessageRef = messageRef.push();
    return await newMessageRef.set(chat.toMap());
  }

  static Future<void> clearChat(String chatWindowId, LiveroomChat chat) async {
    DatabaseReference messageRef =
        database.ref('${FirebaseDbNode.liveRoomChat}/$chatWindowId');
    await messageRef.remove();
    sendChat(chatWindowId, chat);
  }
}
