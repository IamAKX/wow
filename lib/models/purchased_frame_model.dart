class PurchasedFrameModel {
  String? id;
  String? userId;
  String? frameId;
  String? type;
  String? price;
  String? dateFrom;
  String? dateTo;
  String? frameType;
  String? frameIMage;
  bool? isApplied;
  String? expTime;

  PurchasedFrameModel(
      {this.id,
      this.userId,
      this.frameId,
      this.type,
      this.price,
      this.dateFrom,
      this.dateTo,
      this.frameType,
      this.frameIMage,
      this.isApplied,
      this.expTime});

  PurchasedFrameModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    frameId = json['frameId'];
    type = json['type'];
    price = json['price'];
    dateFrom = json['dateFrom'];
    dateTo = json['dateTo'];
    frameType = json['frameType'];
    frameIMage = json['frameIMage'];
    isApplied = json['isApplied'];
    expTime = json['exp_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['frameId'] = frameId;
    data['type'] = type;
    data['price'] = price;
    data['dateFrom'] = dateFrom;
    data['dateTo'] = dateTo;
    data['frameType'] = frameType;
    data['frameIMage'] = frameIMage;
    data['isApplied'] = isApplied;
    data['exp_time'] = expTime;
    return data;
  }
}
