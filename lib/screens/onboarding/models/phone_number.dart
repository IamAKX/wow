import 'package:country_code_picker/country_code_picker.dart';

class PhoneNumberModel {
  String? phoneNumber;
  CountryCode? countryCode;
  String? verificationId;
  PhoneNumberModel({
    this.phoneNumber,
    this.countryCode,
    this.verificationId,
  });

  PhoneNumberModel copyWith({
    String? phoneNumber,
    CountryCode? countryCode,
    String? verificationId,
  }) {
    return PhoneNumberModel(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      countryCode: countryCode ?? this.countryCode,
      verificationId: verificationId ?? this.verificationId,
    );
  }

  @override
  String toString() => '${countryCode?.dialCode ?? ''} $phoneNumber';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PhoneNumberModel &&
        other.phoneNumber == phoneNumber &&
        other.countryCode == countryCode &&
        other.verificationId == verificationId;
  }

  @override
  int get hashCode =>
      phoneNumber.hashCode ^ countryCode.hashCode ^ verificationId.hashCode;
}
