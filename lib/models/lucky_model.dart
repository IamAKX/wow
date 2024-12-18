class LuckyModel {
  String? id;
  String? name;
  String? image;
  String? thumbnail;
  String? price;
  String? type;
  String? validity;
  String? created;
  String? updated;
  String? entryType;
  bool? isMy;
  String? remainingDays;

  LuckyModel(
      {this.id,
      this.name,
      this.image,
      this.thumbnail,
      this.price,
      this.type,
      this.validity,
      this.created,
      this.updated,
      this.entryType,
      this.isMy,
      this.remainingDays});

  LuckyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    thumbnail = json['thumbnail'];
    price = json['price'];
    type = json['type'];
    validity = json['validity'];
    created = json['created'];
    updated = json['updated'];
    entryType = json['entry_type'];
    isMy = json['isMy'];
    remainingDays = json['remainingDays'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['thumbnail'] = thumbnail;
    data['price'] = price;
    data['type'] = type;
    data['validity'] = validity;
    data['created'] = created;
    data['updated'] = updated;
    data['entry_type'] = entryType;
    data['isMy'] = isMy;
    data['remainingDays'] = remainingDays;
    return data;
  }
}
