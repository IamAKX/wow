import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:worldsocialintegrationapp/models/prime_gift_model.dart';

class PrimeGiftListModel {
  List<PrimeGiftModel>? Privilege;
  List<PrimeGiftModel>? Trick;
  List<PrimeGiftModel>? EventGifts;
  List<PrimeGiftModel>? SoundGifts;
  PrimeGiftListModel({
    this.Privilege,
    this.Trick,
    this.EventGifts,
    this.SoundGifts,
  });

  PrimeGiftListModel copyWith({
    List<PrimeGiftModel>? Privilege,
    List<PrimeGiftModel>? Trick,
    List<PrimeGiftModel>? EventGifts,
    List<PrimeGiftModel>? SoundGifts,
  }) {
    return PrimeGiftListModel(
      Privilege: Privilege ?? this.Privilege,
      Trick: Trick ?? this.Trick,
      EventGifts: EventGifts ?? this.EventGifts,
      SoundGifts: SoundGifts ?? this.SoundGifts,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(Privilege != null){
      result.addAll({'Privilege': Privilege!.map((x) => x?.toMap()).toList()});
    }
    if(Trick != null){
      result.addAll({'Trick': Trick!.map((x) => x?.toMap()).toList()});
    }
    if(EventGifts != null){
      result.addAll({'EventGifts': EventGifts!.map((x) => x?.toMap()).toList()});
    }
    if(SoundGifts != null){
      result.addAll({'SoundGifts': SoundGifts!.map((x) => x?.toMap()).toList()});
    }
  
    return result;
  }

  factory PrimeGiftListModel.fromMap(Map<String, dynamic> map) {
    return PrimeGiftListModel(
      Privilege: map['Privilege'] != null ? List<PrimeGiftModel>.from(map['Privilege']?.map((x) => PrimeGiftModel.fromMap(x))) : null,
      Trick: map['Trick'] != null ? List<PrimeGiftModel>.from(map['Trick']?.map((x) => PrimeGiftModel.fromMap(x))) : null,
      EventGifts: map['EventGifts'] != null ? List<PrimeGiftModel>.from(map['EventGifts']?.map((x) => PrimeGiftModel.fromMap(x))) : null,
      SoundGifts: map['SoundGifts'] != null ? List<PrimeGiftModel>.from(map['SoundGifts']?.map((x) => PrimeGiftModel.fromMap(x))) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PrimeGiftListModel.fromJson(String source) => PrimeGiftListModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PrimeGiftListModel(Privilege: $Privilege, Trick: $Trick, EventGifts: $EventGifts, SoundGifts: $SoundGifts)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is PrimeGiftListModel &&
      listEquals(other.Privilege, Privilege) &&
      listEquals(other.Trick, Trick) &&
      listEquals(other.EventGifts, EventGifts) &&
      listEquals(other.SoundGifts, SoundGifts);
  }

  @override
  int get hashCode {
    return Privilege.hashCode ^
      Trick.hashCode ^
      EventGifts.hashCode ^
      SoundGifts.hashCode;
  }
}
