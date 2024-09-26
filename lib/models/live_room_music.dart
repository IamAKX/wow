import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:worldsocialintegrationapp/models/music_model.dart';

class LiveRoomMusic {
  List<MusicModel>? musicModel;
  String? playingState;
  int? playingIndex;
  LiveRoomMusic({
    this.musicModel,
    this.playingState,
    this.playingIndex,
  });

  LiveRoomMusic copyWith({
    List<MusicModel>? musicModel,
    String? playingState,
    int? playingIndex,
  }) {
    return LiveRoomMusic(
      musicModel: musicModel ?? this.musicModel,
      playingState: playingState ?? this.playingState,
      playingIndex: playingIndex ?? this.playingIndex,
    );
  }

  Map toMap() {
    final result = <dynamic, dynamic>{};

    if (musicModel != null) {
      result
          .addAll({'musicModel': musicModel!.map((x) => x?.toMap()).toList()});
    }
    if (playingState != null) {
      result.addAll({'playingState': playingState});
    }
    if (playingIndex != null) {
      result.addAll({'playingIndex': playingIndex});
    }

    return result;
  }

  factory LiveRoomMusic.fromMap(Map map) {
    return LiveRoomMusic(
      musicModel: map['musicModel'] != null
          ? List<MusicModel>.from(
              map['musicModel']?.map((x) => MusicModel.fromMap(x)))
          : null,
      playingState: map['playingState'],
      playingIndex: map['playingIndex']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory LiveRoomMusic.fromJson(String source) =>
      LiveRoomMusic.fromMap(json.decode(source));

  @override
  String toString() =>
      'LiveRoomMusic(musicModel: $musicModel, playingState: $playingState, playingIndex: $playingIndex)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LiveRoomMusic &&
        listEquals(other.musicModel, musicModel) &&
        other.playingState == playingState &&
        other.playingIndex == playingIndex;
  }

  @override
  int get hashCode =>
      musicModel.hashCode ^ playingState.hashCode ^ playingIndex.hashCode;
}
