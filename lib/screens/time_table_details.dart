import 'package:flutter/material.dart';

class TimeTableDetailsScreen extends StatelessWidget {
  const TimeTableDetailsScreen({super.key, required this.timetable});

  final String timetable;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Generated Time Table',
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
      body: Card(
        elevation: 2,
        margin: const EdgeInsets.all(20),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: SelectableText(
              timetable,
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
