class CarByLevel {
  String? id;
  String? image;
  String? level;
  String? price;
  String? validity;
  bool? available;

  CarByLevel(
      {this.id,
      this.image,
      this.level,
      this.price,
      this.validity,
      this.available});

  CarByLevel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    level = json['level'];
    price = json['price'];
    validity = json['validity'];
    available = json['available'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['level'] = level;
    data['price'] = price;
    data['validity'] = validity;
    data['available'] = available;
    return data;
  }
}
