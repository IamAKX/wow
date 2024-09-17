class ThemePaidImageModel {
  String? id;
  String? theme;
  String? price;
  String? valditity;
  bool? purchasedType;
  String? remainingDays;

  ThemePaidImageModel(
      {this.id,
      this.theme,
      this.price,
      this.valditity,
      this.purchasedType,
      this.remainingDays});

  ThemePaidImageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    theme = json['theme'];
    price = json['price'];
    valditity = json['valditity'];
    purchasedType = json['purchasedType'];
    remainingDays = json['remainingDays'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['theme'] = theme;
    data['price'] = price;
    data['valditity'] = valditity;
    data['purchasedType'] = purchasedType;
    data['remainingDays'] = remainingDays;
    return data;
  }
}
