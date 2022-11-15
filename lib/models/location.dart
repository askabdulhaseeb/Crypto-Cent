class Location {
  const Location({
    required this.latitude,
    required this.longitude,
    required this.country,
    required this.locality,
    required this.sublocality,
  });
  final double latitude;
  final double longitude;
  final String country;
  final String locality;
  final String sublocality;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'latitude': latitude,
      'longitude': longitude,
      'country': country,
      'locality': locality,
      'sublocality': sublocality,
    };
  }

  // ignore: sort_constructors_first
  factory Location.fromMap(Map<String, dynamic> map) {
    return Location(
      latitude: map['latitude'] ?? '',
      longitude: map['longitude'] ?? '',
      country: map['country'] ?? '',
      locality: map['locality'] ?? '',
      sublocality: map['sublocality'] ?? '',
    );
  }
}
