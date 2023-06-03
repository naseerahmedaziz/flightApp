import 'package:flutter/material.dart';
import '../model/FlightModel.dart';
import 'PaymentScreen.dart';

class TravellerScreen extends StatefulWidget {
  final FlightModel flight;

  TravellerScreen({required this.flight});

  @override
  _TravellerScreenState createState() => _TravellerScreenState();
}

class _TravellerScreenState extends State<TravellerScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _passportNumberController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _nationalityController = TextEditingController();
  TextEditingController _dobController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _passportNumberController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    _nationalityController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking'),
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
                      Row(
                        children: [
                          Icon(Icons.flight, size: 30.0),
                          SizedBox(width: 8.0),
                          Text(
                            'Flight Details',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        'Flight IATA: ${widget.flight.flightIata}',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      SizedBox(height: 8.0),
                      Text('From: ${widget.flight.depIata}'),
                      Text('To: ${widget.flight.arrIata}'),
                      Text('Departure: ${widget.flight.depTime}'),
                      Text('Arrival: ${widget.flight.arrTime}'),
                      Text('Duration: ${widget.flight.duration}'),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Personal Information',
                style: TextStyle(
                  fontSize: 20.0,
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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _firstNameController,
                                decoration: InputDecoration(
                                  labelText: 'First Name',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your first name';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(width: 16.0),
                            Expanded(
                              child: TextFormField(
                                controller: _lastNameController,
                                decoration: InputDecoration(
                                  labelText: 'Last Name',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your last name';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.0),
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'Email Address',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email address';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16.0),
                        TextFormField(
                          controller: _passportNumberController,
                          decoration: InputDecoration(
                            labelText: 'Passport Number',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your passport number';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16.0),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _nationalityController,
                                decoration: InputDecoration(
                                  labelText: 'Nationality',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your nationality';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(width: 16.0),
                            Expanded(
                              child: TextFormField(
                                controller: _dobController,
                                decoration: InputDecoration(
                                  labelText: 'Date of Birth',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your date of birth';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.0),
                        TextFormField(
                          controller: _phoneNumberController,
                          decoration: InputDecoration(
                            labelText: 'Phone Number',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your phone number';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16.0),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Map<String, String> userData = {
                                'firstName': _firstNameController.text,
                                'lastName': _lastNameController.text,
                                'passportNumber':
                                    _passportNumberController.text,
                                'phoneNumber': _phoneNumberController.text,
                                'email': _emailController.text,
                                'nationality': _nationalityController.text,
                                'dob': _dobController.text,
                              };

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PaymentScreen(
                                    flight: widget.flight,
                                    userData: userData,
                                  ),
                                ),
                              );
                            }
                          },
                          child: Text('Book Now'),
                        ),
                      ],
                    ),
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
