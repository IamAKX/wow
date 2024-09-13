import 'dart:convert';

class SpinDataModel {
  String? typeId;
  String? typeName;
  String? quantity;
  String? header;
  String? subtitle;
  SpinDataModel({
    this.typeId,
    this.typeName,
    this.quantity,
    this.header,
    this.subtitle,
  });

  SpinDataModel copyWith({
    String? typeId,
    String? typeName,
    String? quantity,
    String? header,
    String? subtitle,
  }) {
    return SpinDataModel(
      typeId: typeId ?? this.typeId,
      typeName: typeName ?? this.typeName,
      quantity: quantity ?? this.quantity,
      header: header ?? this.header,
      subtitle: subtitle ?? this.subtitle,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (typeId != null) {
      result.addAll({'typeId': typeId});
    }
    if (typeName != null) {
      result.addAll({'typeName': typeName});
    }
    if (quantity != null) {
      result.addAll({'quantity': quantity});
    }
    if (header != null) {
      result.addAll({'header': header});
    }
    if (subtitle != null) {
      result.addAll({'subtitle': subtitle});
    }

    return result;
  }

  factory SpinDataModel.fromMap(Map<String, dynamic> map) {
    return SpinDataModel(
      typeId: map['typeId'],
      typeName: map['typeName'],
      quantity: map['quantity'],
      header: map['header'],
      subtitle: map['subtitle'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SpinDataModel.fromJson(String source) =>
      SpinDataModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SpinDataModel(typeId: $typeId, typeName: $typeName, quantity: $quantity, header: $header, subtitle: $subtitle)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SpinDataModel &&
        other.typeId == typeId &&
        other.typeName == typeName &&
        other.quantity == quantity &&
        other.header == header &&
        other.subtitle == subtitle;
  }

  @override
  int get hashCode {
    return typeId.hashCode ^
        typeName.hashCode ^
        quantity.hashCode ^
        header.hashCode ^
        subtitle.hashCode;
  }
}
