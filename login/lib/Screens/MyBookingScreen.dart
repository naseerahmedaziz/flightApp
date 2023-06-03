import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Bloc/crudBloc.dart';
import '../model/UserModel.dart';

class MyBookingsScreen extends StatefulWidget {
  @override
  State<MyBookingsScreen> createState() => _MyBookingsScreenState();
}

class _MyBookingsScreenState extends State<MyBookingsScreen> {
  final readBloc = crudBloc();

  @override
  void initState() {
    super.initState();
    readBloc.eventSink.add(Fetch());
  }

  @override
  void dispose() {
    readBloc.dispose();
    super.dispose();
  }

  CollectionReference _reference =
      FirebaseFirestore.instance.collection('Booking');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('My Bookings'),
      ),
      body: StreamBuilder<List<UserModel>>(
        stream: readBloc.userStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                UserModel booking = snapshot.data![index];
                return Padding(
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
                            '${booking.firstName} ${booking.lastName}',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text('Flight IATA: ${booking.flightIata}'),
                          Text('From: ${booking.from}'),
                          Text('To: ${booking.to}'),
                          Text('Departure: ${booking.dep}'),
                          Text('Arrival: ${booking.arr}'),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            // Print the specific error message to the console
            print('Stack trace: ${snapshot.stackTrace}');
            print('Error: ${snapshot.error}');

            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
