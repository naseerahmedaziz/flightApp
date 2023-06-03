import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:login/Screens/searchBottomSheetFrom.dart';

import '../Bloc/FliBloc.dart';
import 'FlightOption.dart';
import 'MyBookingScreen.dart';
import 'SearchBottomSheet.dart';

class FlightBookingPage extends StatefulWidget {
  @override
  _FlightBookingPageState createState() => _FlightBookingPageState();
}

class _FlightBookingPageState extends State<FlightBookingPage> {
  bool isRoundTrip = true;
  String flyingFrom = '';
  String flyingTo = '';
  TextEditingController _textEditingControllerFrom = TextEditingController();
  TextEditingController _textEditingControllerTo = TextEditingController();
  DateTime departureDate = DateTime.now();
  DateTime returnDate = DateTime.now();

  final flightBloc = FliBloc();

  DateFormat dateFormat = DateFormat("yyyy-MM-dd");

  @override
  void initState() {
    super.initState();
    _textEditingControllerFrom = TextEditingController();
    _textEditingControllerTo = TextEditingController();
    departureDate = DateTime.now();

    returnDate = DateTime.now();
  }

  @override
  void dispose() {
    _textEditingControllerFrom.dispose();
    _textEditingControllerTo.dispose();
    flightBloc.dispose();
    super.dispose();
  }

  String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(date);
  }

  @override
  Widget build(BuildContext context) {
    _textEditingControllerFrom.text = flyingFrom;
    _textEditingControllerFrom.selection =
        TextSelection.fromPosition(TextPosition(offset: flyingFrom.length));

    _textEditingControllerTo.text = flyingTo;
    _textEditingControllerTo.selection =
        TextSelection.fromPosition(TextPosition(offset: flyingTo.length));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Flight Booking',
        ),
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 16.0),
              Text(
                'Book a Trip ',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              Text(
                '   To Your Dreams',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.0),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Text('Book Flight')],
                      ),
                      SizedBox(height: 24.0),
                      TextFormField(
                        controller: _textEditingControllerFrom,
                        onChanged: (value) {
                          setState(() {
                            flyingFrom = value;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Flying From',
                          prefixIcon: Icon(Icons.flight_land),
                          suffixIcon: GestureDetector(
                            onTap: () async {
                              final selectedData =
                                  await showModalBottomSheet<String>(
                                context: context,
                                builder: (BuildContext context) =>
                                    SearchBottomSheetFrom(
                                        flyingFrom: flyingFrom),
                              );
                              if (selectedData != null) {
                                setState(() {
                                  flyingFrom = selectedData;
                                  _textEditingControllerFrom.text = flyingFrom;
                                  _textEditingControllerFrom.selection =
                                      TextSelection.fromPosition(TextPosition(
                                          offset: flyingFrom.length));
                                });
                              }
                            },
                            child: Icon(Icons.search),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      Divider(),
                      TextFormField(
                        controller: _textEditingControllerTo,
                        onChanged: (value) {
                          setState(() {
                            flyingTo = value;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Flying To',
                          prefixIcon: Icon(Icons.flight_land),
                          suffixIcon: GestureDetector(
                            onTap: () async {
                              final selectedData =
                                  await showModalBottomSheet<String>(
                                context: context,
                                builder: (BuildContext context) =>
                                    SearchBottomSheet(flyingTo: flyingTo),
                              );
                              if (selectedData != null) {
                                setState(() {
                                  flyingTo = selectedData;
                                  _textEditingControllerTo.text = flyingTo;
                                  _textEditingControllerTo.selection =
                                      TextSelection.fromPosition(TextPosition(
                                          offset: flyingTo.length));
                                });
                              }
                            },
                            child: Icon(Icons.search),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      SizedBox(height: 16.0),
                      GestureDetector(
                        onTap: () async {
                          final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: departureDate,
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(Duration(days: 365)),
                          );
                          if (picked != null) {
                            setState(() {
                              departureDate = picked;
                              _textEditingControllerFrom.text =
                                  formatDate(departureDate);
                              departureDate =
                                  departureDate; // Store the selected date here
                            });
                          }
                        },
                        child: AbsorbPointer(
                          child: TextFormField(
                            controller: TextEditingController(
                              text: formatDate(departureDate),
                            ),
                            readOnly: true,
                            decoration: InputDecoration(
                              labelText: 'Departure Date',
                              prefixIcon: Icon(Icons.calendar_today),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      SizedBox(height: 16.0),
                      SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => FlightOptionPage(
                                  from: flyingFrom,
                                  to: flyingTo,
                                  selectedDate: departureDate),
                            ),
                          );
                        },
                        child: Text(
                          'Search Flights',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.teal),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 20,
        color: Colors.teal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.flight),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyBookingsScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
