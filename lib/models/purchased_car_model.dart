class PurchasedCarModel {
  String? id;
  String? userId;
  String? luckyId;
  String? price;
  String? dateFrom;
  String? dateTo;
  String? frameIMage;
  bool? isApplied;
  String? expTime;

  PurchasedCarModel(
      {this.id,
      this.userId,
      this.luckyId,
      this.price,
      this.dateFrom,
      this.dateTo,
      this.frameIMage,
      this.isApplied,
      this.expTime});

  PurchasedCarModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    luckyId = json['luckyId'];
    price = json['price'];
    dateFrom = json['dateFrom'];
    dateTo = json['dateTo'];
    frameIMage = json['frameIMage'];
    isApplied = json['isApplied'];
    expTime = json['exp_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['luckyId'] = luckyId;
    data['price'] = price;
    data['dateFrom'] = dateFrom;
    data['dateTo'] = dateTo;
    data['frameIMage'] = frameIMage;
    data['isApplied'] = isApplied;
    data['exp_time'] = expTime;
    return data;
  }
}
