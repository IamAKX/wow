class ThemeFreeImageModel {
  String? id;
  String? images;
  String? created;
  String? updated;

  ThemeFreeImageModel({this.id, this.images, this.created, this.updated});

  ThemeFreeImageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    images = json['images'];
    created = json['created'];
    updated = json['updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['images'] = images;
    data['created'] = created;
    data['updated'] = updated;
    return data;
  }
}
