import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Bloc/crudBloc.dart';
import '../main.dart';
import '../model/FlightModel.dart';
import '../../model/UserModel.dart';
import 'MyBookingScreen.dart';

class PaymentScreen extends StatefulWidget {
  final FlightModel flight;
  final Map<String, String> userData;

  PaymentScreen({required this.flight, required this.userData});

  @override
  State<PaymentScreen> createState() => PaymentScreenState();
}

class PaymentScreenState extends State<PaymentScreen> {
  final addBloc = crudBloc();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void dispose() {
    addBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Processing'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Flight Details:',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        'Flight IATA: ${widget.flight.flightIata}',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      Text('From: ${widget.flight.depIata}'),
                      Text('To: ${widget.flight.arrIata}'),
                      Text('Departure: ${widget.flight.depTime}'),
                      Text('Arrival: ${widget.flight.arrTime}'),
                      Text('Duration: ${widget.flight.duration}'),
                      SizedBox(height: 16.0),
                      Text(
                        'Personal Information:',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Text('First Name: ${widget.userData['firstName']}'),
                      Text('Last Name: ${widget.userData['lastName']}'),
                      Text(
                          'Passport Number: ${widget.userData['passportNumber']}'),
                      Text('Phone Number: ${widget.userData['phoneNumber']}'),
                      Text('Email Address: ${widget.userData['email']}'),
                      Text('Nationality: ${widget.userData['nationality']}'),
                      Text('Date of Birth: ${widget.userData['dob']}'),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Payment Details:',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 16.0),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Card Number',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          // suffixIcon: Padding(
                          //   padding: EdgeInsets.only(right: 15.0),
                          //   child: Image.asset(
                          //     'assets/visa.png',
                          //   ),
                          // ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the card number';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.0),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Expiration Date',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the expiration date';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(width: 16.0),
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'CVV',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the CVV';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: () {
                          String? firstName = widget.userData['firstName'];
                          String? lastName = widget.userData['lastName'];
                          String? phoneNo = widget.userData['phoneNumber'];
                          String flightIata = widget.flight.flightIata;
                          String from = widget.flight.depIata;
                          String to = widget.flight.arrIata;
                          String dep = widget.flight.depTime;
                          String arr = widget.flight.arrTime;

                          UserModel booking = UserModel(
                            firstName: firstName ?? '',
                            lastName: lastName ?? '',
                            phoneNo: phoneNo ?? '',
                            flightIata: flightIata,
                            from: from,
                            to: to,
                            dep: dep,
                            arr: arr,
                          );

                          // Perform payment processing logic here

                          // Show a success dialog
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Booking Successful'),
                                content: Text(
                                    'Your flight has been booked successfully.'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      addBloc.eventSink
                                          .add(InsertEvent(booking));
                                      Navigator.of(context).pop();
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MyBookingsScreen()));
                                    },

                                    // Close the dialog

                                    child: Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Text('Make Payment'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
