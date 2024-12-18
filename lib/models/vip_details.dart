import 'dart:convert';

class VipDetails {
  String? id;
  String? coins;
  String? batch;
  String? vipicon;
  String? uniqueframes;
  String? entranceeffect;
  String? getthiscar;
  String? friends;
  String? following;
  String? coinsPerDay;
  String? colorfullMessage;
  String? flyingComment;
  String? hdeCountryAndOnlineTime;
  String? exclusiveGifts;
  String? preventFromBeingKicked;
  String? antiBan;
  String? valid;
  String? vipIconImage;
  String? uniqueFrameImage;
  String? entranceEffectImage;
  String? getThisCarImage;
  String? friendsImage;
  String? followingFriends;
  String? coinsImage;
  String? mainImage;
  String? colorMessageImage;
  String? flyingCommentImage;
  String? exclusiveGiftImage;
  VipDetails({
    this.id,
    this.coins,
    this.batch,
    this.vipicon,
    this.uniqueframes,
    this.entranceeffect,
    this.getthiscar,
    this.friends,
    this.following,
    this.coinsPerDay,
    this.colorfullMessage,
    this.flyingComment,
    this.hdeCountryAndOnlineTime,
    this.exclusiveGifts,
    this.preventFromBeingKicked,
    this.antiBan,
    this.valid,
    this.vipIconImage,
    this.uniqueFrameImage,
    this.entranceEffectImage,
    this.getThisCarImage,
    this.friendsImage,
    this.followingFriends,
    this.coinsImage,
    this.mainImage,
    this.colorMessageImage,
    this.flyingCommentImage,
    this.exclusiveGiftImage,
  });

  VipDetails copyWith({
    String? id,
    String? coins,
    String? batch,
    String? vipicon,
    String? uniqueframes,
    String? entranceeffect,
    String? getthiscar,
    String? friends,
    String? following,
    String? coinsPerDay,
    String? colorfullMessage,
    String? flyingComment,
    String? hdeCountryAndOnlineTime,
    String? exclusiveGifts,
    String? preventFromBeingKicked,
    String? antiBan,
    String? valid,
    String? vipIconImage,
    String? uniqueFrameImage,
    String? entranceEffectImage,
    String? getThisCarImage,
    String? friendsImage,
    String? followingFriends,
    String? coinsImage,
    String? mainImage,
    String? colorMessageImage,
    String? flyingCommentImage,
    String? exclusiveGiftImage,
  }) {
    return VipDetails(
      id: id ?? this.id,
      coins: coins ?? this.coins,
      batch: batch ?? this.batch,
      vipicon: vipicon ?? this.vipicon,
      uniqueframes: uniqueframes ?? this.uniqueframes,
      entranceeffect: entranceeffect ?? this.entranceeffect,
      getthiscar: getthiscar ?? this.getthiscar,
      friends: friends ?? this.friends,
      following: following ?? this.following,
      coinsPerDay: coinsPerDay ?? this.coinsPerDay,
      colorfullMessage: colorfullMessage ?? this.colorfullMessage,
      flyingComment: flyingComment ?? this.flyingComment,
      hdeCountryAndOnlineTime:
          hdeCountryAndOnlineTime ?? this.hdeCountryAndOnlineTime,
      exclusiveGifts: exclusiveGifts ?? this.exclusiveGifts,
      preventFromBeingKicked:
          preventFromBeingKicked ?? this.preventFromBeingKicked,
      antiBan: antiBan ?? this.antiBan,
      valid: valid ?? this.valid,
      vipIconImage: vipIconImage ?? this.vipIconImage,
      uniqueFrameImage: uniqueFrameImage ?? this.uniqueFrameImage,
      entranceEffectImage: entranceEffectImage ?? this.entranceEffectImage,
      getThisCarImage: getThisCarImage ?? this.getThisCarImage,
      friendsImage: friendsImage ?? this.friendsImage,
      followingFriends: followingFriends ?? this.followingFriends,
      coinsImage: coinsImage ?? this.coinsImage,
      mainImage: mainImage ?? this.mainImage,
      colorMessageImage: colorMessageImage ?? this.colorMessageImage,
      flyingCommentImage: flyingCommentImage ?? this.flyingCommentImage,
      exclusiveGiftImage: exclusiveGiftImage ?? this.exclusiveGiftImage,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (coins != null) {
      result.addAll({'coins': coins});
    }
    if (batch != null) {
      result.addAll({'batch': batch});
    }
    if (vipicon != null) {
      result.addAll({'vipicon': vipicon});
    }
    if (uniqueframes != null) {
      result.addAll({'uniqueframes': uniqueframes});
    }
    if (entranceeffect != null) {
      result.addAll({'entranceeffect': entranceeffect});
    }
    if (getthiscar != null) {
      result.addAll({'getthiscar': getthiscar});
    }
    if (friends != null) {
      result.addAll({'friends': friends});
    }
    if (following != null) {
      result.addAll({'following': following});
    }
    if (coinsPerDay != null) {
      result.addAll({'coinsPerDay': coinsPerDay});
    }
    if (colorfullMessage != null) {
      result.addAll({'colorfullMessage': colorfullMessage});
    }
    if (flyingComment != null) {
      result.addAll({'flyingComment': flyingComment});
    }
    if (hdeCountryAndOnlineTime != null) {
      result.addAll({'hdeCountryAndOnlineTime': hdeCountryAndOnlineTime});
    }
    if (exclusiveGifts != null) {
      result.addAll({'exclusiveGifts': exclusiveGifts});
    }
    if (preventFromBeingKicked != null) {
      result.addAll({'preventFromBeingKicked': preventFromBeingKicked});
    }
    if (antiBan != null) {
      result.addAll({'antiBan': antiBan});
    }
    if (valid != null) {
      result.addAll({'valid': valid});
    }
    if (vipIconImage != null) {
      result.addAll({'vipIconImage': vipIconImage});
    }
    if (uniqueFrameImage != null) {
      result.addAll({'uniqueFrameImage': uniqueFrameImage});
    }
    if (entranceEffectImage != null) {
      result.addAll({'entranceEffectImage': entranceEffectImage});
    }
    if (getThisCarImage != null) {
      result.addAll({'getThisCarImage': getThisCarImage});
    }
    if (friendsImage != null) {
      result.addAll({'friendsImage': friendsImage});
    }
    if (followingFriends != null) {
      result.addAll({'followingFriends': followingFriends});
    }
    if (coinsImage != null) {
      result.addAll({'coinsImage': coinsImage});
    }
    if (mainImage != null) {
      result.addAll({'mainImage': mainImage});
    }
    if (colorMessageImage != null) {
      result.addAll({'colorMessageImage': colorMessageImage});
    }
    if (flyingCommentImage != null) {
      result.addAll({'flyingCommentImage': flyingCommentImage});
    }
    if (exclusiveGiftImage != null) {
      result.addAll({'exclusiveGiftImage': exclusiveGiftImage});
    }

    return result;
  }

  factory VipDetails.fromMap(Map<String, dynamic> map) {
    return VipDetails(
      id: map['id'],
      coins: map['coins'],
      batch: map['batch'],
      vipicon: map['vipicon'],
      uniqueframes: map['uniqueframes'],
      entranceeffect: map['entranceeffect'],
      getthiscar: map['getthiscar'],
      friends: map['friends'],
      following: map['following'],
      coinsPerDay: map['coinsPerDay'],
      colorfullMessage: map['colorfullMessage'],
      flyingComment: map['flyingComment'],
      hdeCountryAndOnlineTime: map['hdeCountryAndOnlineTime'],
      exclusiveGifts: map['exclusiveGifts'],
      preventFromBeingKicked: map['preventFromBeingKicked'],
      antiBan: map['antiBan'],
      valid: map['valid'],
      vipIconImage: map['vipIconImage'],
      uniqueFrameImage: map['uniqueFrameImage'],
      entranceEffectImage: map['entranceEffectImage'],
      getThisCarImage: map['getThisCarImage'],
      friendsImage: map['friendsImage'],
      followingFriends: map['followingFriends'],
      coinsImage: map['coinsImage'],
      mainImage: map['mainImage'],
      colorMessageImage: map['colorMessageImage'],
      flyingCommentImage: map['flyingCommentImage'],
      exclusiveGiftImage: map['exclusiveGiftImage'],
    );
  }

  String toJson() => json.encode(toMap());

  factory VipDetails.fromJson(String source) =>
      VipDetails.fromMap(json.decode(source));

  @override
  String toString() {
    return 'VipDetails(id: $id, coins: $coins, batch: $batch, vipicon: $vipicon, uniqueframes: $uniqueframes, entranceeffect: $entranceeffect, getthiscar: $getthiscar, friends: $friends, following: $following, coinsPerDay: $coinsPerDay, colorfullMessage: $colorfullMessage, flyingComment: $flyingComment, hdeCountryAndOnlineTime: $hdeCountryAndOnlineTime, exclusiveGifts: $exclusiveGifts, preventFromBeingKicked: $preventFromBeingKicked, antiBan: $antiBan, valid: $valid, vipIconImage: $vipIconImage, uniqueFrameImage: $uniqueFrameImage, entranceEffectImage: $entranceEffectImage, getThisCarImage: $getThisCarImage, friendsImage: $friendsImage, followingFriends: $followingFriends, coinsImage: $coinsImage, mainImage: $mainImage, colorMessageImage: $colorMessageImage, flyingCommentImage: $flyingCommentImage, exclusiveGiftImage: $exclusiveGiftImage)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VipDetails &&
        other.id == id &&
        other.coins == coins &&
        other.batch == batch &&
        other.vipicon == vipicon &&
        other.uniqueframes == uniqueframes &&
        other.entranceeffect == entranceeffect &&
        other.getthiscar == getthiscar &&
        other.friends == friends &&
        other.following == following &&
        other.coinsPerDay == coinsPerDay &&
        other.colorfullMessage == colorfullMessage &&
        other.flyingComment == flyingComment &&
        other.hdeCountryAndOnlineTime == hdeCountryAndOnlineTime &&
        other.exclusiveGifts == exclusiveGifts &&
        other.preventFromBeingKicked == preventFromBeingKicked &&
        other.antiBan == antiBan &&
        other.valid == valid &&
        other.vipIconImage == vipIconImage &&
        other.uniqueFrameImage == uniqueFrameImage &&
        other.entranceEffectImage == entranceEffectImage &&
        other.getThisCarImage == getThisCarImage &&
        other.friendsImage == friendsImage &&
        other.followingFriends == followingFriends &&
        other.coinsImage == coinsImage &&
        other.mainImage == mainImage &&
        other.colorMessageImage == colorMessageImage &&
        other.flyingCommentImage == flyingCommentImage &&
        other.exclusiveGiftImage == exclusiveGiftImage;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        coins.hashCode ^
        batch.hashCode ^
        vipicon.hashCode ^
        uniqueframes.hashCode ^
        entranceeffect.hashCode ^
        getthiscar.hashCode ^
        friends.hashCode ^
        following.hashCode ^
        coinsPerDay.hashCode ^
        colorfullMessage.hashCode ^
        flyingComment.hashCode ^
        hdeCountryAndOnlineTime.hashCode ^
        exclusiveGifts.hashCode ^
        preventFromBeingKicked.hashCode ^
        antiBan.hashCode ^
        valid.hashCode ^
        vipIconImage.hashCode ^
        uniqueFrameImage.hashCode ^
        entranceEffectImage.hashCode ^
        getThisCarImage.hashCode ^
        friendsImage.hashCode ^
        followingFriends.hashCode ^
        coinsImage.hashCode ^
        mainImage.hashCode ^
        colorMessageImage.hashCode ^
        flyingCommentImage.hashCode ^
        exclusiveGiftImage.hashCode;
  }
}
