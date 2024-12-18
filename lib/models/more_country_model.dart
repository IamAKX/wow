import 'dart:convert';

class MoreCountryModel {
  String? country;
  String? flagPath;
  MoreCountryModel({
    this.country,
    this.flagPath,
  });

  MoreCountryModel copyWith({
    String? country,
    String? flagPath,
  }) {
    return MoreCountryModel(
      country: country ?? this.country,
      flagPath: flagPath ?? this.flagPath,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (country != null) {
      result.addAll({'country': country});
    }
    if (flagPath != null) {
      result.addAll({'flagPath': flagPath});
    }

    return result;
  }

  factory MoreCountryModel.fromMap(Map<String, dynamic> map) {
    return MoreCountryModel(
      country: map['country'],
      flagPath: map['flagPath'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MoreCountryModel.fromJson(String source) =>
      MoreCountryModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'MoreCountryModel(country: $country, flagPath: $flagPath)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MoreCountryModel &&
        other.country == country &&
        other.flagPath == flagPath;
  }

  @override
  int get hashCode => country.hashCode ^ flagPath.hashCode;
}
