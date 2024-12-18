import 'dart:convert';

class LavelInfomation {
  String? sandColor;
  String? sandBgImage;
  String? sendLevel;
  String? sendExp;
  int? sendStart;
  int? sendEnd;
  String? reciveColor;
  String? reciveBgImage;
  String? reciveLevel;
  String? reciveExp;
  int? reciveStart;
  int? reciveEnd;
  LavelInfomation({
    this.sandColor,
    this.sandBgImage,
    this.sendLevel,
    this.sendExp,
    this.sendStart,
    this.sendEnd,
    this.reciveColor,
    this.reciveBgImage,
    this.reciveLevel,
    this.reciveExp,
    this.reciveStart,
    this.reciveEnd,
  });

  LavelInfomation copyWith({
    String? sandColor,
    String? sandBgImage,
    String? sendLevel,
    String? sendExp,
    int? sendStart,
    int? sendEnd,
    String? reciveColor,
    String? reciveBgImage,
    String? reciveLevel,
    String? reciveExp,
    int? reciveStart,
    int? reciveEnd,
  }) {
    return LavelInfomation(
      sandColor: sandColor ?? this.sandColor,
      sandBgImage: sandBgImage ?? this.sandBgImage,
      sendLevel: sendLevel ?? this.sendLevel,
      sendExp: sendExp ?? this.sendExp,
      sendStart: sendStart ?? this.sendStart,
      sendEnd: sendEnd ?? this.sendEnd,
      reciveColor: reciveColor ?? this.reciveColor,
      reciveBgImage: reciveBgImage ?? this.reciveBgImage,
      reciveLevel: reciveLevel ?? this.reciveLevel,
      reciveExp: reciveExp ?? this.reciveExp,
      reciveStart: reciveStart ?? this.reciveStart,
      reciveEnd: reciveEnd ?? this.reciveEnd,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(sandColor != null){
      result.addAll({'sandColor': sandColor});
    }
    if(sandBgImage != null){
      result.addAll({'sandBgImage': sandBgImage});
    }
    if(sendLevel != null){
      result.addAll({'sendLevel': sendLevel});
    }
    if(sendExp != null){
      result.addAll({'sendExp': sendExp});
    }
    if(sendStart != null){
      result.addAll({'sendStart': sendStart});
    }
    if(sendEnd != null){
      result.addAll({'sendEnd': sendEnd});
    }
    if(reciveColor != null){
      result.addAll({'reciveColor': reciveColor});
    }
    if(reciveBgImage != null){
      result.addAll({'reciveBgImage': reciveBgImage});
    }
    if(reciveLevel != null){
      result.addAll({'reciveLevel': reciveLevel});
    }
    if(reciveExp != null){
      result.addAll({'reciveExp': reciveExp});
    }
    if(reciveStart != null){
      result.addAll({'reciveStart': reciveStart});
    }
    if(reciveEnd != null){
      result.addAll({'reciveEnd': reciveEnd});
    }
  
    return result;
  }

  factory LavelInfomation.fromMap(Map<String, dynamic> map) {
    return LavelInfomation(
      sandColor: map['sandColor'],
      sandBgImage: map['sandBgImage'],
      sendLevel: map['sendLevel'],
      sendExp: map['sendExp'],
      sendStart: map['sendStart']?.toInt(),
      sendEnd: map['sendEnd']?.toInt(),
      reciveColor: map['reciveColor'],
      reciveBgImage: map['reciveBgImage'],
      reciveLevel: map['reciveLevel'],
      reciveExp: map['reciveExp'],
      reciveStart: map['reciveStart']?.toInt(),
      reciveEnd: map['reciveEnd']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory LavelInfomation.fromJson(String source) => LavelInfomation.fromMap(json.decode(source));

  @override
  String toString() {
    return 'LavelInfomation(sandColor: $sandColor, sandBgImage: $sandBgImage, sendLevel: $sendLevel, sendExp: $sendExp, sendStart: $sendStart, sendEnd: $sendEnd, reciveColor: $reciveColor, reciveBgImage: $reciveBgImage, reciveLevel: $reciveLevel, reciveExp: $reciveExp, reciveStart: $reciveStart, reciveEnd: $reciveEnd)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is LavelInfomation &&
      other.sandColor == sandColor &&
      other.sandBgImage == sandBgImage &&
      other.sendLevel == sendLevel &&
      other.sendExp == sendExp &&
      other.sendStart == sendStart &&
      other.sendEnd == sendEnd &&
      other.reciveColor == reciveColor &&
      other.reciveBgImage == reciveBgImage &&
      other.reciveLevel == reciveLevel &&
      other.reciveExp == reciveExp &&
      other.reciveStart == reciveStart &&
      other.reciveEnd == reciveEnd;
  }

  @override
  int get hashCode {
    return sandColor.hashCode ^
      sandBgImage.hashCode ^
      sendLevel.hashCode ^
      sendExp.hashCode ^
      sendStart.hashCode ^
      sendEnd.hashCode ^
      reciveColor.hashCode ^
      reciveBgImage.hashCode ^
      reciveLevel.hashCode ^
      reciveExp.hashCode ^
      reciveStart.hashCode ^
      reciveEnd.hashCode;
  }
}
