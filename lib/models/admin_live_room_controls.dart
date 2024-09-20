import 'dart:convert';

class AdminLiveRoomControls {
  bool? isSpeakerMute;
  bool? isMicMute;
  bool? kickout;
  bool? invite;

  int? position;
  bool? giftVisiualEffect;
  bool? vehicalVisiualEffect;
  bool? giftSound;
  bool? rewardEffects;
  AdminLiveRoomControls({
    this.isSpeakerMute,
    this.isMicMute,
    this.kickout,
    this.invite,
    this.position,
    this.giftVisiualEffect,
    this.vehicalVisiualEffect,
    this.giftSound,
    this.rewardEffects,
  });

  AdminLiveRoomControls copyWith({
    bool? isSpeakerMute,
    bool? isMicMute,
    bool? kickout,
    bool? invite,
    int? position,
    bool? giftVisiualEffect,
    bool? vehicalVisiualEffect,
    bool? giftSound,
    bool? rewardEffects,
  }) {
    return AdminLiveRoomControls(
      isSpeakerMute: isSpeakerMute ?? this.isSpeakerMute,
      isMicMute: isMicMute ?? this.isMicMute,
      kickout: kickout ?? this.kickout,
      invite: invite ?? this.invite,
      position: position ?? this.position,
      giftVisiualEffect: giftVisiualEffect ?? this.giftVisiualEffect,
      vehicalVisiualEffect: vehicalVisiualEffect ?? this.vehicalVisiualEffect,
      giftSound: giftSound ?? this.giftSound,
      rewardEffects: rewardEffects ?? this.rewardEffects,
    );
  }

  Map<dynamic, dynamic> toMap() {
    final result = <dynamic, dynamic>{};

    if (isSpeakerMute != null) {
      result.addAll({'isSpeakerMute': isSpeakerMute});
    }
    if (isMicMute != null) {
      result.addAll({'isMicMute': isMicMute});
    }
    if (kickout != null) {
      result.addAll({'kickout': kickout});
    }
    if (invite != null) {
      result.addAll({'invite': invite});
    }
    if (position != null) {
      result.addAll({'position': position});
    }
    if (giftVisiualEffect != null) {
      result.addAll({'giftVisiualEffect': giftVisiualEffect});
    }
    if (vehicalVisiualEffect != null) {
      result.addAll({'vehicalVisiualEffect': vehicalVisiualEffect});
    }
    if (giftSound != null) {
      result.addAll({'giftSound': giftSound});
    }
    if (rewardEffects != null) {
      result.addAll({'rewardEffects': rewardEffects});
    }

    return result;
  }

  factory AdminLiveRoomControls.fromMap(Map<dynamic, dynamic> map) {
    return AdminLiveRoomControls(
      isSpeakerMute: map['isSpeakerMute'],
      isMicMute: map['isMicMute'],
      kickout: map['kickout'],
      invite: map['invite'],
      position: map['position']?.toInt(),
      giftVisiualEffect: map['giftVisiualEffect'],
      vehicalVisiualEffect: map['vehicalVisiualEffect'],
      giftSound: map['giftSound'],
      rewardEffects: map['rewardEffects'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AdminLiveRoomControls.fromJson(String source) =>
      AdminLiveRoomControls.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AdminLiveRoomControls(isSpeakerMute: $isSpeakerMute, isMicMute: $isMicMute, kickout: $kickout, invite: $invite, position: $position, giftVisiualEffect: $giftVisiualEffect, vehicalVisiualEffect: $vehicalVisiualEffect, giftSound: $giftSound, rewardEffects: $rewardEffects)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AdminLiveRoomControls &&
        other.isSpeakerMute == isSpeakerMute &&
        other.isMicMute == isMicMute &&
        other.kickout == kickout &&
        other.invite == invite &&
        other.position == position &&
        other.giftVisiualEffect == giftVisiualEffect &&
        other.vehicalVisiualEffect == vehicalVisiualEffect &&
        other.giftSound == giftSound &&
        other.rewardEffects == rewardEffects;
  }

  @override
  int get hashCode {
    return isSpeakerMute.hashCode ^
        isMicMute.hashCode ^
        kickout.hashCode ^
        invite.hashCode ^
        position.hashCode ^
        giftVisiualEffect.hashCode ^
        vehicalVisiualEffect.hashCode ^
        giftSound.hashCode ^
        rewardEffects.hashCode;
  }
}
