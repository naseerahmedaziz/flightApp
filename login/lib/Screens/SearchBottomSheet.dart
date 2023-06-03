import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Bloc/AirBloc.dart';
import '../model/AirportModel.dart';

class SearchBottomSheet extends StatefulWidget {
  final String flyingTo;

  SearchBottomSheet({required this.flyingTo});

  @override
  _SearchBottomSheetState createState() => _SearchBottomSheetState();
}

class _SearchBottomSheetState extends State<SearchBottomSheet> {
  TextEditingController _searchController = TextEditingController();
  Future<List<AirportModel>>? _searchResult;
  String _searchText = '';
  String selectedData = '';
  final airportBloc = AirBloc();

  @override
  void initState() {
    super.initState();
    _searchText = widget.flyingTo; // Initialize _searchText with flyingTo
    airportBloc.eventSink.add(Fetch(_searchText)); // Trigger search on init
  }

  @override
  void dispose() {
    _searchController.dispose();
    airportBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: StreamBuilder<List<AirportModel>>(
            stream: airportBloc.airportStream,
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
                    AirportModel airport = snapshot.data![index];
                    return Card(
                      child: ListTile(
                        title: Text(airport.iataCode),
                        onTap: () {
                          setState(() {
                            selectedData = airport.iataCode;
                          });
                          Navigator.pop(context,
                              selectedData); // Close the bottom sheet and pass the selected data
                        },
                      ),
                    );
                  },
                );
              } else {
                return Text('Enter a city and press search.');
              }
            },
          ),
        ),
      ],
    );
  }
}
