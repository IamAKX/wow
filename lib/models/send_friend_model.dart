import 'dart:convert';

class SendFriendModel {
  bool? isCar;
  String? validity;
  String? price;
  String? id;
  String? url;
  SendFriendModel({
    this.isCar,
    this.validity,
    this.price,
    this.id,
    this.url,
  });

  SendFriendModel copyWith({
    bool? isCar,
    String? validity,
    String? price,
    String? id,
    String? url,
  }) {
    return SendFriendModel(
      isCar: isCar ?? this.isCar,
      validity: validity ?? this.validity,
      price: price ?? this.price,
      id: id ?? this.id,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (isCar != null) {
      result.addAll({'isCar': isCar});
    }
    if (validity != null) {
      result.addAll({'validity': validity});
    }
    if (price != null) {
      result.addAll({'price': price});
    }
    if (id != null) {
      result.addAll({'id': id});
    }
    if (url != null) {
      result.addAll({'url': url});
    }

    return result;
  }

  factory SendFriendModel.fromMap(Map<String, dynamic> map) {
    return SendFriendModel(
      isCar: map['isCar'],
      validity: map['validity'],
      price: map['price'],
      id: map['id'],
      url: map['url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SendFriendModel.fromJson(String source) =>
      SendFriendModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SendFriendModel(isCar: $isCar, validity: $validity, price: $price, id: $id, url: $url)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SendFriendModel &&
        other.isCar == isCar &&
        other.validity == validity &&
        other.price == price &&
        other.id == id &&
        other.url == url;
  }

  @override
  int get hashCode {
    return isCar.hashCode ^
        validity.hashCode ^
        price.hashCode ^
        id.hashCode ^
        url.hashCode;
  }
}
