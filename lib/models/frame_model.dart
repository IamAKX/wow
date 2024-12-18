class FrameModel {
  String? id;
  String? frameImg;
  String? thumbnail;
  String? price;
  String? validity;
  String? type;
  String? created;
  String? updated;
  String? frameType;
  bool? isMy;
  String? remainingDays;

  FrameModel(
      {this.id,
      this.frameImg,
      this.thumbnail,
      this.price,
      this.validity,
      this.type,
      this.created,
      this.updated,
      this.frameType,
      this.isMy,
      this.remainingDays});

  FrameModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    frameImg = json['frame_img'];
    thumbnail = json['thumbnail'];
    price = json['price'];
    validity = json['validity'];
    type = json['type'];
    created = json['created'];
    updated = json['updated'];
    frameType = json['frameType'];
    isMy = json['isMy'];
    remainingDays = json['remainingDays'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['frame_img'] = frameImg;
    data['thumbnail'] = thumbnail;
    data['price'] = price;
    data['validity'] = validity;
    data['type'] = type;
    data['created'] = created;
    data['updated'] = updated;
    data['frameType'] = frameType;
    data['isMy'] = isMy;
    data['remainingDays'] = remainingDays;
    return data;
  }
}
