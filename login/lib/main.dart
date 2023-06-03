import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:login/Screens/searchBottomSheetFrom.dart';

import 'Bloc/FliBloc.dart';
import 'Screens/FlightBookingPage.dart';
import 'Screens/FlightOption.dart';
import 'Screens/MyBookingScreen.dart';
import 'Screens/SearchBottomSheet.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(FlightBookingApp());
}

class FlightBookingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flight Booking App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        brightness: Brightness.light,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FlightBookingPage(),
    );
  }
}
