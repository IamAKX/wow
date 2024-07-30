import 'package:country_code_picker/country_code_picker.dart';

class PhoneNumberModel {
  String? phoneNumber;
  CountryCode? countryCode;
  PhoneNumberModel({
    this.phoneNumber,
    this.countryCode,
  });

  PhoneNumberModel copyWith({
    String? phoneNumber,
    CountryCode? countryCode,
  }) {
    return PhoneNumberModel(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      countryCode: countryCode ?? this.countryCode,
    );
  }

  @override
  String toString() => '${countryCode?.dialCode} $phoneNumber';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PhoneNumberModel &&
        other.phoneNumber == phoneNumber &&
        other.countryCode == countryCode;
  }

  @override
  int get hashCode => phoneNumber.hashCode ^ countryCode.hashCode;
}
