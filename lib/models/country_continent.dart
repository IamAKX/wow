import 'dart:convert';

import 'package:geolocator/geolocator.dart';

class CountryContinent {
  String? country;
  String? continent;
  Position? position;
  CountryContinent({
    this.country,
    this.continent,
    this.position,
  });

  CountryContinent copyWith({
    String? country,
    String? continent,
    Position? position,
  }) {
    return CountryContinent(
      country: country ?? this.country,
      continent: continent ?? this.continent,
      position: position ?? this.position,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(country != null){
      result.addAll({'country': country});
    }
    if(continent != null){
      result.addAll({'continent': continent});
    }
    if(position != null){
      result.addAll({'position': position});
    }
  
    return result;
  }

  factory CountryContinent.fromMap(Map<String, dynamic> map) {
    return CountryContinent(
      country: map['country'],
      continent: map['continent'],
      position: map['position'] != null ? Position.fromMap(map['position']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CountryContinent.fromJson(String source) => CountryContinent.fromMap(json.decode(source));

  @override
  String toString() => 'CountryContinent(country: $country, continent: $continent, position: $position)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is CountryContinent &&
      other.country == country &&
      other.continent == continent &&
      other.position == position;
  }

  @override
  int get hashCode => country.hashCode ^ continent.hashCode ^ position.hashCode;
}
