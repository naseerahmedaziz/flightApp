import '../model/FlightModel.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

abstract class Myevent {}

class FetchFlight extends Myevent {
  String depiata;
  String arriata;
  String date;
  FetchFlight(this.depiata, this.arriata, this.date);
}

class FliBloc {
  final _flightsStreamController = StreamController<List<FlightModel>>();
  StreamSink<List<FlightModel>> get _flightSink =>
      _flightsStreamController.sink;
  Stream<List<FlightModel>> get flightStream => _flightsStreamController.stream;

  final _EventStreamController = StreamController<Myevent>();
  StreamSink<Myevent> get eventSink => _EventStreamController.sink;
  Stream<Myevent> get _eventStream => _EventStreamController.stream;
  // CollectionReference _refernce = FirebaseFirestore.instance.collection('shop');

  FliBloc() {
    print("Listener registered");
    _eventStream.listen((event) async {
      if (event is FetchFlight) {
        print("Inside FetchFlight condition");
        print("Event: $event");
        print("Before try block");
        try {
          var news =
              await fetchSchedule(event.depiata, event.arriata, event.date);
          _flightSink.add(List<FlightModel>.from(news));
          print("datainfightsink");
          print(_flightSink);
        } catch (e) {
          _flightSink.addError("error here ");
        }
      }
      print("After try block");
    });
  }

//getflight api call

  Future<List<FlightModel>> fetchSchedule(
      String departureIata, String arrivalIata, String date) async {
    final apiKey = '2c308108-2190-46a6-be8b-64bdffe99c0d';
    final endpoint = 'https://airlabs.co/api/v9/schedules';
    final url = Uri.parse(
        '$endpoint?dep_iata=$departureIata&arr_iata=$arrivalIata&api_key=$apiKey');

    final response = await http.get(url);
    print(
      'Response body: ${response.body}',
    );
    print('Date: $date');
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final scheduleJson = jsonResponse['response'] as List<dynamic>;

      List<FlightModel> schedule = scheduleJson
          .map((json) => FlightModel.fromJson(json))
          // .where((flight) =>
          //     flight.depIata == departureIata &&
          //     flight.arrIata == arrivalIata &&
          //     flight.depTime.startsWith(date))
          .toList();

      print("Schedule: $schedule");
      return schedule;
    } else {
      throw Exception('Failed to fetch schedule: ${response.statusCode}');
    }
  }

  void dispose() {
    _flightsStreamController.close();
    _EventStreamController.close();
  }
}
