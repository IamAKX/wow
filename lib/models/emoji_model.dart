class EmojiModel {
  String? id;
  String? frameImg;
  String? price;
  String? created;
  String? updated;

  EmojiModel({this.id, this.frameImg, this.price, this.created, this.updated});

  EmojiModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    frameImg = json['frame_img'];
    price = json['price'];
    created = json['created'];
    updated = json['updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['frame_img'] = frameImg;
    data['price'] = price;
    data['created'] = created;
    data['updated'] = updated;
    return data;
  }
}
