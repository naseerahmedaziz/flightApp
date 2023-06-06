import 'dart:async';
import 'dart:convert';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_signin/Bloc/crudBloc.dart';
import 'package:http/http.dart' as http;

import '../model/AirportModel.dart';

// enum CounterAction { Insert, Fetch, Delete }

abstract class Myevent {}

class InsertEvent extends Myevent {
  // final Student student;

  // InsertEvent(this.student);
}

class Fetch extends Myevent {
  // Student student;
  // AirportModel airports;
  String city;
  Fetch(this.city);
  // Fetch(this.student);
}

class Update extends Myevent {
  // final Student student;

  // Update(this.student);
}

class Delete extends Myevent {
  // final Student student;

  // Delete(this.student);
}

class AirBloc {
  final _airportStreamController = StreamController<List<AirportModel>>();
  StreamSink<List<AirportModel>> get _airportSink =>
      _airportStreamController.sink;
  Stream<List<AirportModel>> get airportStream =>
      _airportStreamController.stream;

  final _EventStreamController = StreamController<Myevent>();
  StreamSink<Myevent> get eventSink => _EventStreamController.sink;
  Stream<Myevent> get _eventStream => _EventStreamController.stream;
  // CollectionReference _refernce = FirebaseFirestore.instance.collection('shop');

  AirBloc() {
    _eventStream.listen((event) async {
      if (event is Fetch) {
        try {
          var news = await getCity(event.city);
          _airportSink.add(news);
        } catch (e) {
          _airportSink.addError("error here ");
        }
        // if (event is Fetch) {
        //   try {
        //     var news = await fetchRecord();
        //     _studentSink.add(news);
        //   } catch (e) {
        //     _studentSink.addError("error here ");
        //   }
        // } else if (event is InsertEvent) {
        //   try {
        //     await insertRecord(event.student); // Call the function to insert data
        //     // Fetch updated data after insertion
        //     var students = await fetchRecord();
        //     _studentSink.add(students);
        //   } catch (e) {
        //     _studentSink.addError("Error occurred while inserting data");
        //   }
        // } else if (event is Update) {
        //   try {
        //     await updateRecord(event.student); // Call the function to insert data
        //     // Fetch updated data after insertion
        //     var students = await fetchRecord();
        //     _studentSink.add(students);
        //   } catch (e) {
        //     _studentSink.addError("Error occurred while inserting data");
        //   }
        // } else if (event is Delete) {
        //   try {
        //     await delRecord(event.student); // Call the function to insert data
        //     // Fetch updated data after insertion
        //     var students = await fetchRecord();
        //     _studentSink.add(students);
        //   } catch (e) {
        //     _studentSink.addError("Error occurred while inserting data");
        //   }
        // }
      }
    });
  }

  Future<List<AirportModel>> getCity(String city) async {
    final String baseUrl = "https://airlabs.co/api/v9/";
    final String apiKey = "8bd89b9c-ab4c-4447-b39c-a8910eb4bc1c";

    final response = await http.get(
      Uri.parse(baseUrl + 'suggest?q=' + city + '&api_key=$apiKey'),
      headers: {"Content-Type": "application/x-www-form-urlencoded"},
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      List<dynamic>? airportsJson = jsonResponse['response']['airports'];

      if (airportsJson != null) {
        print(airportsJson);
        List<AirportModel> airports =
            airportsJson.map((json) => AirportModel.fromJson(json)).toList();
        return airports;
      } else {
        return []; // Return an empty list if no results are found
      }
    } else {
      throw Exception('Failed to load airports');
    }
  }

  Future<List<dynamic>> getFlights(String desIata, String arrIata) async {
    final String apiKey = "8bd89b9c-ab4c-4447-b39c-a8910eb4bc1c";
    final url = 'https://api.airlabs.co/v1/flights';
    https: //api.airlabs.co/v1/flights8bd89b9c-ab4c-4447-b39c-a8910eb4bc1c&from=JFK&to=LAX
    final response = await http.get(
      Uri.parse('$url?api_key=$apiKey&from=$desIata&to=$arrIata'),
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final flights = jsonData['data']['flights'];
      return flights;
    } else {
      throw Exception('Failed to get flights. Error ${response.statusCode}');
    }
  }

  // Future<List<Student>> fetchRecord() async {
  //   try {
  //     // Retrieve data from Firestore
  //     QuerySnapshot snapshot = await _refernce.get();

  //     // Extract the documents and map them to Student objects
  //     List<Student> students = snapshot.docs.map((doc) {
  //       String id = doc.id;
  //       String name = doc.get('name');
  //       String email = doc.get('email');
  //       String num = doc.get('num');
  //       return Student(id: id, name: name, email: email, num: num);
  //     }).toList();

  //     // Return the list of students
  //     return students;
  //   } catch (e) {
  //     // Handle any errors that occurred during fetching
  //     throw Exception('Error fetching records: $e');
  //   }
  // }

  // Future<void> insertRecord(Student student) async {
  //   try {
  //     // Get a reference to the Firestore collection
  //     CollectionReference studentsCollection =
  //         FirebaseFirestore.instance.collection('shop');

  //     // Create a map from the student object
  //     Map<String, dynamic> studentData = {
  //       'name': student.name,
  //       'email': student.email,
  //       'num': student.num,
  //     };

  //     // Insert the data into Firestore
  //     await studentsCollection.add(studentData);

  //     // Data inserted successfully
  //     print('Data inserted successfully!');
  //   } catch (e) {
  //     // Error occurred while inserting data
  //     print('Error inserting data: $e');
  //   }
  // }

  // updateRecord(Student student) {
  //   try {
  //     final CollectionReference = FirebaseFirestore.instance.collection("shop");
  //     CollectionReference.doc(student.id).update(student.toJson());
  //     print('Data updated successfully!');
  //   } catch (e) {
  //     // Error occurred while inserting data
  //     print('Error updating  data: $e');
  //   }
  // }

  // delRecord(Student student) {
  //   try {
  //     final CollectionReference = FirebaseFirestore.instance.collection("shop");
  //     CollectionReference.doc(student.id).delete();
  //   } catch (e) {
  //     print('Error deletuing  data: $e');
  //   }
  // }

  void dispose() {
    _airportStreamController.close();
    _EventStreamController.close();
  }
}
