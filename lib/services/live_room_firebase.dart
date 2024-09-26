import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:worldsocialintegrationapp/models/admin_live_room_controls.dart';
import 'package:worldsocialintegrationapp/models/joinable_live_room_model.dart';
import 'package:worldsocialintegrationapp/models/live_room_music.dart';
import 'package:worldsocialintegrationapp/models/live_room_user_model.dart';
import 'package:worldsocialintegrationapp/models/liveroom_chat.dart';
import 'package:worldsocialintegrationapp/models/user_profile_detail.dart';
import 'package:worldsocialintegrationapp/utils/firebase_db_node.dart';
import 'package:worldsocialintegrationapp/utils/helpers.dart';

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
      String roomId, UserProfileDetail? user, bool isEnter) async {
    try {
      // DataSnapshot snapshot = await database
      //     .ref(FirebaseDbNode.liveRoomParticipants)
      //     .child(roomId)
      //     .child(user?.id ?? '')
      //     .get();
      LiveRoomUserModel? liveRoomUserModel = convertUserToLiveUser(user);
      if (!isEnter) {
        await database
            .ref(FirebaseDbNode.liveRoomParticipants)
            .child(roomId)
            .child(user?.id ?? '')
            .remove();
      } else {
        // If the room doesn't exist, create it with the userId

        await database
            .ref(FirebaseDbNode.liveRoomParticipants)
            .child(roomId)
            .child(user?.id ?? '')
            .set(liveRoomUserModel.toMap());
        log('Room $roomId created with user ${liveRoomUserModel.id}');
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

  static Future<void> updateLiveRoomTheme(
      String roomId, String themeUrl) async {
    DatabaseReference liveRoomRef =
        database.ref('${FirebaseDbNode.liveRoomTheme}/$roomId');
    await liveRoomRef.set(themeUrl);
  }

  static Future<void> sendChat(String chatWindowId, LiveroomChat chat) async {
    DatabaseReference messageRef =
        database.ref('${FirebaseDbNode.liveRoomChat}/$chatWindowId');
    DatabaseReference newMessageRef = messageRef.push();
    return await newMessageRef.set(chat.toMap());
  }

  static Future<void> clearChat(String chatWindowId, LiveroomChat chat,
      {bool? sendMessage}) async {
    DatabaseReference messageRef =
        database.ref('${FirebaseDbNode.liveRoomChat}/$chatWindowId');
    await messageRef.remove();
    if (sendMessage ?? true) {
      sendChat(chatWindowId, chat);
    }
  }

  static Future<void> addLiveRoomHotSeat(
      String chatWindowId, int spot, LiveRoomUserModel liveRoom) async {
    DatabaseReference liveRoomRef =
        database.ref('${FirebaseDbNode.liveRoomHotSeat}/$chatWindowId/$spot');
    log('updating : ${liveRoom.id}');
    await liveRoomRef.set(liveRoom.toMap());
  }

  static Future<void> removeLiveRoomHotSeat(
      String chatWindowId, int spot) async {
    DatabaseReference liveRoomRef =
        database.ref('${FirebaseDbNode.liveRoomHotSeat}/$chatWindowId/$spot');
    log('Removing $spot');
    await liveRoomRef.remove();
  }

  static Future<void> removeLiveRoomAllHotSeat(String chatWindowId) async {
    DatabaseReference liveRoomRef =
        database.ref('${FirebaseDbNode.liveRoomHotSeat}/$chatWindowId');
    log('Removing all hotseat');
    await liveRoomRef.remove();
  }

  static Future<void> addLiveRoomAdminSettings(String chatWindowId,
      String userId, AdminLiveRoomControls adminLiveRoomControls) async {
    DatabaseReference liveRoomRef = database
        .ref('${FirebaseDbNode.liveRoomAdminControl}/$chatWindowId/$userId');
    log('updating liveRoomAdminControl : $userId');
    await liveRoomRef.set(adminLiveRoomControls.toMap());
  }

  static Future<void> removeLiveRoomAdminSettings(
    String chatWindowId,
  ) async {
    DatabaseReference liveRoomRef =
        database.ref('${FirebaseDbNode.liveRoomAdminControl}/$chatWindowId');
    log('removing all liveRoomAdminControl : $chatWindowId');
    await liveRoomRef.remove();
  }

  static Future<void> updateLiveRoomAdminSettings(
      String chatWindowId, String userId, String key, dynamic value) async {
    DatabaseReference liveRoomRef = database
        .ref('${FirebaseDbNode.liveRoomAdminControl}/$chatWindowId/$userId');
    log('updating liveRoomAdminControl : $userId');
    Map<String, Object?> map = {};
    map[key] = value;

    await liveRoomRef.update(map);
  }

  static Future<AdminLiveRoomControls?> getLiveRoomAdminSettings(
      String chatWindowId, String userId) async {
    DatabaseReference liveRoomRef =
        database.ref(FirebaseDbNode.liveRoomAdminControl).child(chatWindowId);
    AdminLiveRoomControls? settings;
    DataSnapshot snapshot = await liveRoomRef.get();
    if (snapshot.exists) {
      Map map = snapshot.value as Map<dynamic, dynamic>;
      settings = AdminLiveRoomControls.fromMap(map[userId]);
    }
    return settings;
  }

  static Future<List<LiveRoomUserModel>> getLiveRoomParticipants(
      String roomId) async {
    DatabaseReference liveRoomRef =
        database.ref('${FirebaseDbNode.liveRoomParticipants}/$roomId');
    List<LiveRoomUserModel> participants = [];
    DataSnapshot snapshot = await liveRoomRef.get();
    if (snapshot.exists) {
      List p = [];
      if (snapshot.value is List) {
        List l = (snapshot.value as List);
        for (int i = 0; i < l.length; i++) {
          if (l.elementAt(i) != null) {
            p.add(l.elementAt(i));
          }
        }
      } else {
        (snapshot.value as Map).values.forEach((item) => p.add(item));
      }
      participants.clear();
      p.forEach(
        (element) {
          participants.add(LiveRoomUserModel.fromMap(element));
        },
      );
    }
    return participants;
  }

  static Future<void> sendEmoji(
      String chatWindowId, String position, String emojiUrl) async {
    DatabaseReference messageRef =
        database.ref('${FirebaseDbNode.liveRoomEmoji}/$chatWindowId');
    log('${FirebaseDbNode.liveRoomEmoji}/$chatWindowId');
    Map map = {};
    map[position] = emojiUrl;
    log('map = $map');
    return await messageRef.set(map);
  }

  static Future<void> sendAudioSignal(
      String chatWindowId, String userId, int volume) async {
    DatabaseReference messageRef =
        database.ref('${FirebaseDbNode.currentSpeaker}/$chatWindowId');

    Map map = {};
    map[userId] = volume;

    return await messageRef.set(map);
  }

  // static Future<void> updateLiveRoomMusic(
  //     String roomId, String musicUrl) async {
  //   DatabaseReference liveRoomRef =
  //       database.ref('${FirebaseDbNode.liveRoomMusic}/$roomId');
  //   await liveRoomRef.set(musicUrl);
  // }

  static Future<void> addMusicSettings(
      String chatWindowId, LiveRoomMusic music) async {
    DatabaseReference liveRoomRef =
        database.ref('${FirebaseDbNode.liveRoomMusic}/$chatWindowId');
    log('updating liveRoomMusic : $chatWindowId');
    await liveRoomRef.set(music.toMap());
  }

  static Future<void> removeMusicSettings(
    String chatWindowId,
  ) async {
    DatabaseReference liveRoomRef =
        database.ref('${FirebaseDbNode.liveRoomMusic}/$chatWindowId');
    log('removing all liveRoomMusic : $chatWindowId');
    await liveRoomRef.remove();
  }

  static Future<void> updateMusicSettings(
      String chatWindowId, String key, dynamic value) async {
    DatabaseReference liveRoomRef =
        database.ref('${FirebaseDbNode.liveRoomMusic}/$chatWindowId');
    log('updating liveRoomMusic : $chatWindowId');
    Map<String, Object?> map = {};
    map[key] = value;

    await liveRoomRef.update(map);
  }

  static Future<LiveRoomMusic?> getMusicSettings(String chatWindowId) async {
    DatabaseReference liveRoomRef =
        database.ref(FirebaseDbNode.liveRoomMusic).child(chatWindowId);
    LiveRoomMusic? settings;
    DataSnapshot snapshot = await liveRoomRef.get();
    if (snapshot.exists) {
      Map map = snapshot.value as Map<dynamic, dynamic>;
      settings = LiveRoomMusic.fromMap(map);
    }
    return settings;
  }
}
