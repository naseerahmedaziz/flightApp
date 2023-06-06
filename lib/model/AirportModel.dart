class AirportModel {
  final String name;
  final String iataCode;
  final String icaoCode;
  final double latitude;
  final double longitude;
  final String slug;
  final String countryCode;
  final int popularity;
  final String cityCode;

  AirportModel({
    required this.name,
    required this.iataCode,
    required this.icaoCode,
    required this.latitude,
    required this.longitude,
    required this.slug,
    required this.countryCode,
    required this.popularity,
    required this.cityCode,
  });

  factory AirportModel.fromJson(Map<String, dynamic> json) {
    return AirportModel(
      name: json['name'],
      iataCode: json['iata_code'],
      icaoCode: json['icao_code'],
      latitude: json['lat'].toDouble(),
      longitude: json['lng'].toDouble(),
      slug: json['slug'],
      countryCode: json['country_code'],
      popularity: json['popularity'],
      cityCode: json['city_code'],
    );
  }
}
