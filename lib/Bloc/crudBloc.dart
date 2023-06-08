import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

// import 'package:firebase_auth/firebase_auth.dart';

import '../model/UserModel.dart';
import 'crudBloc.dart';

// enum CounterAction { Insert, Fetch, Delete }

abstract class Myevent {}

class InsertEvent extends Myevent {
  final UserModel booking;

  InsertEvent(this.booking);
}

class Fetch extends Myevent {
  // final UserModel booking;
  // Fetch(this.booking);
}

class Update extends Myevent {
  final UserModel booking;

  Update(this.booking);
}

class Delete extends Myevent {
  final UserModel booking;

  Delete(this.booking);
}

class crudBloc {
  final _StateStreamController = StreamController<List<UserModel>>();
  StreamSink<List<UserModel>> get _userSink => _StateStreamController.sink;
  Stream<List<UserModel>> get userStream => _StateStreamController.stream;

  final _EventStreamController = StreamController<Myevent>();
  StreamSink<Myevent> get eventSink => _EventStreamController.sink;
  Stream<Myevent> get _eventStream => _EventStreamController.stream;
  CollectionReference _refernce =
      FirebaseFirestore.instance.collection('Booking');

  crudBloc() {
    _eventStream.listen((event) async {
      if (event is Fetch) {
        try {
          var news = await fetchRecord();
          _userSink.add(news);
        } catch (e) {
          _userSink.addError("error here ");
        }
      } else if (event is InsertEvent) {
        try {
          await insertRecord(event.booking); // Call the function to insert data
          // Fetch updated data after insertion
          var booking = await fetchRecord();
          _userSink.add(booking);
        } catch (e) {
          _userSink.addError("Error occurred while inserting data");
        }
      } else if (event is Update) {
        try {
          // await updateRecord(event.booking); // Call the function to insert data
          // Fetch updated data after insertion
          // var students = await fetchRecord();
          // _studentSink.add(students);
        } catch (e) {
          // _studentSink.addError("Error occurred while inserting data");
        }
      } else if (event is Delete) {
        try {
          await delRecord(event.booking); // Call the function to insert data
          // Fetch updated data after insertion
          var booking = await fetchRecord();
          _userSink.add(booking);
        } catch (e) {
          _userSink.addError("Error occurred while inserting data");
        }
      }
    });
  }

  Future<List<UserModel>> fetchRecord() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String userId = user.uid;

        // Retrieve data from Firestore
        QuerySnapshot snapshot =
            await _refernce.where('userId', isEqualTo: userId).get();

        // Extract the documents and map them to UserModel objects
        List<UserModel> bookings = snapshot.docs.map((doc) {
          String id = doc.id;
          String firstName = doc.get('firstName');
          String lastName = doc.get('lastName');
          String phoneNo = doc.get('phoneNo');
          String flightIata = doc.get('flightIata');
          String from = doc.get('from');
          String to = doc.get('to');
          String dep = doc.get('dep');
          String arr = doc.get('arr');
          return UserModel(
            userId: id,
            firstName: firstName,
            lastName: lastName,
            phoneNo: phoneNo,
            flightIata: flightIata,
            from: from,
            to: to,
            dep: dep,
            arr: arr,
          );
        }).toList();

        // Return the list of bookings
        print(bookings);
        return bookings;
      } else {
        throw Exception('User not found');
      }
    } catch (e) {
      throw Exception('Error fetching records: $e');
    }
  }

  Future<void> insertRecord(UserModel booking) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String userId = user.uid;

        // Get a reference to the Firestore collection
        CollectionReference bookingCollection =
            FirebaseFirestore.instance.collection('Booking');

        // Create a map from the booking object
        Map<String, dynamic> bookingData = {
          'userId': userId, // Add the user ID to the data
          'firstName': booking.firstName,
          'lastName': booking.lastName,
          'phoneNo': booking.phoneNo,
          'flightIata': booking.flightIata,
          'from': booking.from,
          'to': booking.to,
          'dep': booking.dep,
          'arr': booking.arr,
        };

        // Insert the data into Firestore
        await bookingCollection.add(bookingData);

        // Data inserted successfully
        print('Data inserted successfully!');
      } else {
        throw Exception('User not found');
      }
    } catch (e) {
      // Error occurred while inserting data
      print('Error inserting data: $e');
    }
  }

  delRecord(UserModel booking) {
    try {
      final CollectionReference =
          FirebaseFirestore.instance.collection("Booking");
      CollectionReference.doc(booking.userId).delete();
    } catch (e) {
      print('Error deletuing  data: $e');
    }
  }

  void dispose() {
    _StateStreamController.close();
    _EventStreamController.close();
  }
}
