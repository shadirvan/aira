import 'dart:convert';

import 'package:aira/screens/time_table_details.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_dotenv/flutter_dotenv.dart';

class TimeTableScreen extends StatefulWidget {
  const TimeTableScreen({super.key});

  @override
  State<TimeTableScreen> createState() => _TimeTableScreenState();
}

class _TimeTableScreenState extends State<TimeTableScreen> {
  String wakeTime = '5:00 AM';
  String sleepTime = '10:00 PM';
  String classStartTime = '9:00 AM';
  String classEndTime = '4:00 PM';
  String dinnerTime = '8:00 PM';

  String otherInfo = '';

  var wakingTimes = [
    '5:00 AM',
    '5:30 AM',
    '6:00 AM',
    '6:30 AM',
    '7:00 AM',
    '7:30 AM',
    '8:00 AM',
    '8:30 AM',
    '9:00 AM',
  ];
  var sleepingTimes = [
    '8:00 PM',
    '8:30 PM',
    '9:00 PM',
    '9:30 PM',
    '10:00 PM',
    '10:30 PM',
    '11:00 PM',
    '11:30 PM',
    '12:00 PM',
    '12:30 PM',
    '1:00 PM',
    '1:30 PM',
    '2:00 PM',
  ];

  var classStartTimes = [
    '7:00 AM',
    '7:30 AM',
    '8:00 AM',
    '8:30 AM',
    '9:00 AM',
    '8:30 AM',
    '10:00 AM',
    '10:30 AM',
    '11:00 AM',
    '11:30 AM',
  ];
  var classEndTimes = [
    '2:00 PM',
    '2:30 PM',
    '3:00 PM',
    '3:30 PM',
    '4:00 PM',
    '4:30 PM',
    '5:00 PM',
    '5:30 PM',
    '6:00 PM',
    '6:30 PM',
    '7:00 PM',
    '7:30 PM',
  ];
  var dinnerTimes = [
    '7:00 PM',
    '7:30 PM',
    '8:00 PM',
    '8:30 PM',
    '9:00 PM',
    '9:30 PM',
    '10:00 PM',
    '10:30 PM',
    '11:00 PM',
    '11:30 PM',
  ];

  bool isLoading = false;

  final TextEditingController _otherInfoController = TextEditingController();

  @override
  void dispose() {
    _otherInfoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create Time-Table',
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
      body: SafeArea(
          child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 1),
                child: Text(
                  'Wakeup Time',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Center(
                  child: DropdownButton(
                    isExpanded: true,
                    // Initial Value
                    value: wakeTime,

                    // Down Arrow Icon
                    icon: const Icon(Icons.keyboard_arrow_down),

                    // Array list of items
                    items: wakingTimes.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),

                    onChanged: (String? newValue) {
                      setState(() {
                        wakeTime = newValue!;
                      });
                    },
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 1),
                child: Text(
                  'Sleep Time',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: DropdownButton(
                  // Initial Value
                  isExpanded: true,

                  value: sleepTime,

                  // Down Arrow Icon
                  icon: const Icon(Icons.keyboard_arrow_down),

                  // Array list of items
                  items: sleepingTimes.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),

                  onChanged: (String? newValue) {
                    setState(() {
                      sleepTime = newValue!;
                    });
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 1),
                child: Text(
                  'Class Start At',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: DropdownButton(
                  isExpanded: true,
                  // Initial Value
                  value: classStartTime,

                  // Down Arrow Icon
                  icon: const Icon(Icons.keyboard_arrow_down),

                  // Array list of items
                  items: classStartTimes.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  // After selecting the desired option,it will
                  // change button value to selected value
                  onChanged: (String? newValue) {
                    setState(() {
                      classStartTime = newValue!;
                    });
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 1),
                child: Text(
                  'Class End At',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: DropdownButton(
                  isExpanded: true,
                  // Initial Value
                  value: classEndTime,

                  // Down Arrow Icon
                  icon: const Icon(Icons.keyboard_arrow_down),

                  // Array list of items
                  items: classEndTimes.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  // After selecting the desired option,it will
                  // change button value to selected value
                  onChanged: (String? newValue) {
                    setState(() {
                      classStartTime = newValue!;
                    });
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 1),
                child: Text(
                  'Dinner Time',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: DropdownButton(
                  // Initial Value
                  isExpanded: true,

                  value: dinnerTime,

                  // Down Arrow Icon
                  icon: const Icon(Icons.keyboard_arrow_down),

                  // Array list of items
                  items: dinnerTimes.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),

                  onChanged: (String? newValue) {
                    setState(() {
                      dinnerTime = newValue!;
                    });
                  },
                ),
              ),
              Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: TextFormField(
                    onChanged: (value) {
                      otherInfo = value;
                    },
                    controller: _otherInfoController,
                    decoration: InputDecoration(
                      label: const Text(
                        'Other infos',
                        style: TextStyle(color: Colors.black),
                      ),
                      hintText: 'eg. want to learn AI and Flutter for 1 hr',
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Colors.redAccent, width: 1),
                          borderRadius: BorderRadius.circular(20)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Colors.redAccent, width: 1),
                          borderRadius: BorderRadius.circular(20)),
                      border: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.redAccent, width: 1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  )),
              const SizedBox(
                height: 30,
              ),
              isLoading
                  ? const CircularProgressIndicator(
                      color: Colors.redAccent,
                    )
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent),
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });

                        await http
                            .post(
                                Uri.parse(
                                    'https://api.openai.com/v1/chat/completions'),
                                headers: {
                                  'Content-Type': 'application/json',
                                  'Authorization':
                                      'Bearer ${dotenv.env['token']}',
                                },
                                body: jsonEncode({
                                  'model': 'gpt-3.5-turbo',
                                  "messages": [
                                    {
                                      "role": "user",
                                      "content":
                                          "Generate a time table for me i wake at $wakeTime and sleep at $sleepTime goes to class at $classStartTimes and class end at $classEndTime and dinner time at $dinnerTime i also need time table to include time for class studies or home works  and  $otherInfo"
                                    }
                                  ],
                                  'temperature': 0.7,
                                }))
                            .then((value) {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => TimeTableDetailsScreen(
                                timetable: jsonDecode(value.body)['choices'][0]
                                    ['message']['content']),
                          ));
                        });

                        setState(() {
                          isLoading = false;
                        });
                      },
                      child: const Text('Generate Time table'))
            ],
          ),
        ),
      )),
    );
  }
}
