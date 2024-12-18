class PurchasedTheme {
  String? id;
  String? userId;
  String? image;
  String? price;
  String? dateFrom;
  String? dateTo;
  String? themeId;
  bool? isApplied;
  String? type;
  String? expTime;

  PurchasedTheme(
      {this.id,
      this.userId,
      this.image,
      this.price,
      this.dateFrom,
      this.dateTo,
      this.themeId,
      this.isApplied,
      this.type,
      this.expTime});

  PurchasedTheme.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    image = json['image'];
    price = json['price'];
    dateFrom = json['dateFrom'];
    dateTo = json['dateTo'];
    themeId = json['themeId'];
    isApplied = json['isApplied'];
    type = json['type'];
    expTime = json['exp_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['image'] = image;
    data['price'] = price;
    data['dateFrom'] = dateFrom;
    data['dateTo'] = dateTo;
    data['themeId'] = themeId;
    data['isApplied'] = isApplied;
    data['type'] = type;
    data['exp_time'] = expTime;
    return data;
  }
}
