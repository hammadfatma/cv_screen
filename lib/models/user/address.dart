import 'geolocation.dart';

class Address {
  Geolocation? geolocation;
  String? city;
  String? street;
  int? number;
  String? zipcode;

  Address({
    this.geolocation,
    this.city,
    this.street,
    this.number,
    this.zipcode,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        geolocation: json['geolocation'] == null
            ? null
            : Geolocation.fromJson(json['geolocation'] as Map<String, dynamic>),
        city: json['city'] as String?,
        street: json['street'] as String?,
        number: json['number'] as int?,
        zipcode: json['zipcode'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'geolocation': geolocation?.toJson(),
        'city': city,
        'street': street,
        'number': number,
        'zipcode': zipcode,
      };
}
