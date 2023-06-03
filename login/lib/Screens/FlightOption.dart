import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'TravellerScreen.dart';
import '../Bloc/FliBloc.dart';
import '../model/FlightModel.dart';

class FlightOptionPage extends StatefulWidget {
  final String from;
  final String to;
  final DateTime selectedDate;

  FlightOptionPage({
    required this.from,
    required this.to,
    required this.selectedDate,
  });

  @override
  State<FlightOptionPage> createState() => _FlightOptionPageState();
}

class _FlightOptionPageState extends State<FlightOptionPage> {
  final flightBloc = FliBloc();

  @override
  void initState() {
    super.initState();
    flightBloc.eventSink.add(
      FetchFlight(
        widget.from,
        widget.to,
        DateFormat('yyyy-MM-dd')
            .format(widget.selectedDate), // Format the selectedDate
      ),
    );
  }

  @override
  void dispose() {
    flightBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flight Options"),
      ),
      body: StreamBuilder<List<FlightModel>>(
        stream: flightBloc.flightStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return Text('No results found.');
            }

            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                FlightModel flight = snapshot.data![index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TravellerScreen(flight: flight),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              flight.flightIata,
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("From: ${flight.depIata}"),
                                    Text("To: ${flight.arrIata}"),
                                    Text("Departure: ${flight.depTime}"),
                                    Text("Arrival: ${flight.arrTime}"),
                                    Text("Duration: ${flight.duration}"),
                                  ],
                                ),
                                Text(
                                  "Cost: 200",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text('No data available.'),
            );
          }
        },
      ),
    );
  }
}
