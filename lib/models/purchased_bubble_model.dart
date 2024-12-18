class PurchasedVipModel {
  String? id;
  String? vipImage;
  String? created;
  bool? isApplied;

  PurchasedVipModel({this.id, this.vipImage, this.created, this.isApplied});

  PurchasedVipModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vipImage = json['vip_image'];
    created = json['created'];
    isApplied = json['is_applied'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['vip_image'] = vipImage;
    data['created'] = created;
    data['is_applied'] = isApplied;
    return data;
  }
}
