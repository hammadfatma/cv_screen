class Geolocation {
  String? lat;
  String? long;

  Geolocation({this.lat, this.long});

  factory Geolocation.fromJson(Map<String, dynamic> json) => Geolocation(
        lat: json['lat'] as String?,
        long: json['long'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'long': long,
      };
}
