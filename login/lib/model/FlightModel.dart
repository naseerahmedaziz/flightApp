class FlightModel {
  String? airlineIata;
  String? airlineIcao;
  String flightIata;
  String? flightIcao;
  String? flightNumber;
  String depIata;
  String? depIcao;
  dynamic depTerminal;
  dynamic depGate;
  String depTime;
  String? depTimeUtc;
  String arrIata;
  String? arrIcao;
  dynamic arrTerminal;
  dynamic arrGate;
  dynamic arrBaggage;
  String arrTime;
  String? arrTimeUtc;
  dynamic csAirlineIata;
  dynamic csFlightNumber;
  dynamic csFlightIata;
  String? status;
  int? duration;
  dynamic delayed;
  dynamic depDelayed;
  dynamic arrDelayed;
  String? aircraftIcao;
  int? arrTimeTs;
  int? depTimeTs;

  FlightModel({
    required this.airlineIata,
    required this.airlineIcao,
    required this.flightIata,
    required this.flightIcao,
    required this.flightNumber,
    required this.depIata,
    required this.depIcao,
    this.depTerminal,
    this.depGate,
    required this.depTime,
    required this.depTimeUtc,
    required this.arrIata,
    required this.arrIcao,
    this.arrTerminal,
    this.arrGate,
    this.arrBaggage,
    required this.arrTime,
    required this.arrTimeUtc,
    this.csAirlineIata,
    this.csFlightNumber,
    this.csFlightIata,
    required this.status,
    required this.duration,
    this.delayed,
    this.depDelayed,
    this.arrDelayed,
    required this.aircraftIcao,
    required this.arrTimeTs,
    required this.depTimeTs,
  });

  factory FlightModel.fromJson(Map<String, dynamic> json) => FlightModel(
        airlineIata: json["airline_iata"],
        airlineIcao: json["airline_icao"],
        flightIata: json["flight_iata"],
        flightIcao: json["flight_icao"],
        flightNumber: json["flight_number"],
        depIata: json["dep_iata"],
        depIcao: json["dep_icao"],
        depTerminal: json["dep_terminal"],
        depGate: json["dep_gate"],
        depTime: json["dep_time"],
        depTimeUtc: json["dep_time_utc"],
        arrIata: json["arr_iata"],
        arrIcao: json["arr_icao"],
        arrTerminal: json["arr_terminal"],
        arrGate: json["arr_gate"],
        arrBaggage: json["arr_baggage"],
        arrTime: json["arr_time"],
        arrTimeUtc: json["arr_time_utc"],
        csAirlineIata: json["cs_airline_iata"],
        csFlightNumber: json["cs_flight_number"],
        csFlightIata: json["cs_flight_iata"],
        status: json["status"],
        duration: json["duration"],
        delayed: json["delayed"],
        depDelayed: json["dep_delayed"],
        arrDelayed: json["arr_delayed"],
        aircraftIcao: json["aircraft_icao"],
        arrTimeTs: json["arr_time_ts"],
        depTimeTs: json["dep_time_ts"],
      );
}
