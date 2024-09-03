import 'package:firebase_database/firebase_database.dart';

class FirebaseDbService {
  static FirebaseDatabase database = FirebaseDatabase.instance;
  static const String friendList = 'friendList';

  static Future<void> addRemoveFriend(String userId, String otherUserId) async {
    DatabaseReference userFriendsRef = database.ref('$friendList/$userId');
    DataSnapshot snapshot = await userFriendsRef.get();
    List<String> friends = snapshot.value != null
        ? List<String>.from((snapshot.value as List<dynamic>?) ?? [])
        : [];
    if (await isMyFriend(userId, otherUserId)) {
      friends.remove(otherUserId);
      await userFriendsRef.set(friends);
    } else {
      friends.add(otherUserId);
      await userFriendsRef.set(friends);
    }
  }

  static Future<bool> isMyFriend(String userId, String otherUserId) async {
    DatabaseReference userFriendsRef = database.ref('$friendList/$userId');
    DataSnapshot snapshot = await userFriendsRef.get();
    List<String> friends = snapshot.value != null
        ? List<String>.from((snapshot.value as List<dynamic>?) ?? [])
        : [];

    return friends.contains(otherUserId);
  }
}
