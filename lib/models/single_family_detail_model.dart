class SingleFamilyDetailModel {
  String? id;
  String? familyLevelId;
  String? levelName;
  String? mainImage;
  String? rankMedal;
  String? totalExperience;
  String? members;
  String? memberImage;
  String? admin;
  String? adminImage;
  String? exclusiveFrames;
  String? exclusiveBackground;
  String? exclusiveGift;

  SingleFamilyDetailModel(
      {this.id,
      this.familyLevelId,
      this.levelName,
      this.mainImage,
      this.rankMedal,
      this.totalExperience,
      this.members,
      this.memberImage,
      this.admin,
      this.adminImage,
      this.exclusiveFrames,
      this.exclusiveBackground,
      this.exclusiveGift});

  SingleFamilyDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    familyLevelId = json['family_level_id'];
    levelName = json['level_name'];
    mainImage = json['main_image'];
    rankMedal = json['rank_medal'];
    totalExperience = json['totalExperience'];
    members = json['members'];
    memberImage = json['memberImage'];
    admin = json['admin'];
    adminImage = json['adminImage'];
    exclusiveFrames = json['exclusive_frames'];
    exclusiveBackground = json['exclusive_background'];
    exclusiveGift = json['exclusive_gift'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['family_level_id'] = familyLevelId;
    data['level_name'] = levelName;
    data['main_image'] = mainImage;
    data['rank_medal'] = rankMedal;
    data['totalExperience'] = totalExperience;
    data['members'] = members;
    data['memberImage'] = memberImage;
    data['admin'] = admin;
    data['adminImage'] = adminImage;
    data['exclusive_frames'] = exclusiveFrames;
    data['exclusive_background'] = exclusiveBackground;
    data['exclusive_gift'] = exclusiveGift;
    return data;
  }
}
