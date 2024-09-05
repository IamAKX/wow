class GamesModel {
  String? id;
  String? name;
  String? link;
  String? image;
  String? gameStatus;
  String? gameType;
  String? section;

  GamesModel(
      {this.id,
      this.name,
      this.link,
      this.image,
      this.gameStatus,
      this.gameType,
      this.section});

  GamesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    link = json['link'];
    image = json['image'];
    gameStatus = json['gameStatus'];
    gameType = json['gameType'];
    section = json['section'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['link'] = link;
    data['image'] = image;
    data['gameStatus'] = gameStatus;
    data['gameType'] = gameType;
    data['section'] = section;
    return data;
  }
}
