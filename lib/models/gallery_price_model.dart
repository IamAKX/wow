class GalleryPriceModel {
  String? id;
  String? coins;
  String? validity;
  String? created;
  bool? purStatus;
  String? remainingDays;

  GalleryPriceModel(
      {this.id,
      this.coins,
      this.validity,
      this.created,
      this.purStatus,
      this.remainingDays});

  GalleryPriceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    coins = json['coins'];
    validity = json['validity'];
    created = json['Created'];
    purStatus = json['purStatus'];
    remainingDays = json['remainingDays'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['coins'] = coins;
    data['validity'] = validity;
    data['Created'] = created;
    data['purStatus'] = purStatus;
    data['remainingDays'] = remainingDays;
    return data;
  }
}
