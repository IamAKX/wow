import 'dart:convert';

class SendFriendModel {
  bool? isCar;
  String? validity;
  String? price;
  String? id;
  SendFriendModel({
    this.isCar,
    this.validity,
    this.price,
    this.id,
  });

  SendFriendModel copyWith({
    bool? isCar,
    String? validity,
    String? price,
    String? id,
  }) {
    return SendFriendModel(
      isCar: isCar ?? this.isCar,
      validity: validity ?? this.validity,
      price: price ?? this.price,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(isCar != null){
      result.addAll({'isCar': isCar});
    }
    if(validity != null){
      result.addAll({'validity': validity});
    }
    if(price != null){
      result.addAll({'price': price});
    }
    if(id != null){
      result.addAll({'id': id});
    }
  
    return result;
  }

  factory SendFriendModel.fromMap(Map<String, dynamic> map) {
    return SendFriendModel(
      isCar: map['isCar'],
      validity: map['validity'],
      price: map['price'],
      id: map['id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SendFriendModel.fromJson(String source) => SendFriendModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SendFriendModel(isCar: $isCar, validity: $validity, price: $price, id: $id)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is SendFriendModel &&
      other.isCar == isCar &&
      other.validity == validity &&
      other.price == price &&
      other.id == id;
  }

  @override
  int get hashCode {
    return isCar.hashCode ^
      validity.hashCode ^
      price.hashCode ^
      id.hashCode;
  }
}
