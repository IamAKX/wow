import 'dart:convert';

class CoinModel {
  String? id;
  String? moneyValue;
  String? coinValue;
  CoinModel({
    this.id,
    this.moneyValue,
    this.coinValue,
  });

  CoinModel copyWith({
    String? id,
    String? moneyValue,
    String? coinValue,
  }) {
    return CoinModel(
      id: id ?? this.id,
      moneyValue: moneyValue ?? this.moneyValue,
      coinValue: coinValue ?? this.coinValue,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (moneyValue != null) {
      result.addAll({'moneyValue': moneyValue});
    }
    if (coinValue != null) {
      result.addAll({'coinValue': coinValue});
    }

    return result;
  }

  factory CoinModel.fromMap(Map<String, dynamic> map) {
    return CoinModel(
      id: map['id'],
      moneyValue: map['moneyValue'],
      coinValue: map['coinValue'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CoinModel.fromJson(String source) =>
      CoinModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'CoinModel(id: $id, moneyValue: $moneyValue, coinValue: $coinValue)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CoinModel &&
        other.id == id &&
        other.moneyValue == moneyValue &&
        other.coinValue == coinValue;
  }

  @override
  int get hashCode => id.hashCode ^ moneyValue.hashCode ^ coinValue.hashCode;
}
