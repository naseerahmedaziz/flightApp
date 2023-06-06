import 'package:flutter/material.dart';

import 'FlightBookingPage.dart'; // Replace with your actual FlightBookingPage file

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    // Add a delay of 2 seconds (adjust as per your requirement)
    await Future.delayed(Duration(seconds: 3));

    // Navigate to the FlightBookingPage or any other desired page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => FlightBookingPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal, // Replace with your desired teal color
      body: Center(
        child: Icon(
          Icons.flight,
          size: 100,
          color: Colors.white,
        ),
      ),
    );
  }
}
