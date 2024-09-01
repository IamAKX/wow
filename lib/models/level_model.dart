class LevelModel {
  String? sandColor;
  String? sandBgImage;
  String? sendLevel;
  String? sendExp;
  int? sendStart;
  int? sendEnd;
  String? requiredExperience;
  String? reciveColor;
  String? reciveBgImage;
  String? reciveLevel;
  String? reciveExp;
  int? reciveStart;
  int? reciveEnd;
  String? receiveRequiredExperience;

  LevelModel(
      {this.sandColor,
      this.sandBgImage,
      this.sendLevel,
      this.sendExp,
      this.sendStart,
      this.sendEnd,
      this.requiredExperience,
      this.reciveColor,
      this.reciveBgImage,
      this.reciveLevel,
      this.reciveExp,
      this.reciveStart,
      this.reciveEnd,
      this.receiveRequiredExperience});

  LevelModel.fromJson(Map<String, dynamic> json) {
    sandColor = json['sandColor'];
    sandBgImage = json['sandBgImage'];
    sendLevel = json['sendLevel'];
    sendExp = json['sendExp'];
    sendStart = json['sendStart'];
    sendEnd = json['sendEnd'];
    requiredExperience = json['requiredExperience'];
    reciveColor = json['reciveColor'];
    reciveBgImage = json['reciveBgImage'];
    reciveLevel = json['reciveLevel'];
    reciveExp = json['reciveExp'];
    reciveStart = json['reciveStart'];
    reciveEnd = json['reciveEnd'];
    receiveRequiredExperience = json['receiveRequiredExperience'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sandColor'] = sandColor;
    data['sandBgImage'] = sandBgImage;
    data['sendLevel'] = sendLevel;
    data['sendExp'] = sendExp;
    data['sendStart'] = sendStart;
    data['sendEnd'] = sendEnd;
    data['requiredExperience'] = requiredExperience;
    data['reciveColor'] = reciveColor;
    data['reciveBgImage'] = reciveBgImage;
    data['reciveLevel'] = reciveLevel;
    data['reciveExp'] = reciveExp;
    data['reciveStart'] = reciveStart;
    data['reciveEnd'] = reciveEnd;
    data['receiveRequiredExperience'] = receiveRequiredExperience;
    return data;
  }
}
