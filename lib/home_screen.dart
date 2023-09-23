import 'dart:convert';

import 'package:aira/screens/grammer_screen.dart';
import 'package:aira/screens/question_screen.dart';

import 'package:aira/screens/summarise_screen.dart';
import 'package:aira/screens/time_table_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var fetchedData;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    fetchDataFromApi();
  }

  Future<void> fetchDataFromApi() async {
    isLoading = true;
    final response = await http.get(
        Uri.parse('https://api.api-ninjas.com/v1/quotes?category=education'),
        headers: {
          'X-Api-Key': '${dotenv.env['quote']}',
        });

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON
      setState(() {
        fetchedData = json.decode(response.body);
      });
      isLoading = false;
    } else {
      // If the server did not return a 200 OK response,
      // throw an exception or handle the error accordingly.
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.only(left: 30, right: 30, top: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Good day, Arun',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 26),
                          ),
                          Image.asset(
                            'assets/images/user.png',
                            width: 50,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 12,
                                offset: const Offset(0, 3),
                              ),
                            ],
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Colors.amber.shade800, Colors.amber])
                            // border: Border.all(width: 1, color: Colors.grey),
                            ),
                        child: Center(
                          child: Column(
                            children: [
                              Text(
                                '${fetchedData[0]['quote']}, \n',
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Text(
                                  '- ${fetchedData[0]['author']}',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      width: double.infinity,
                      child: const Text(
                        'Let\'s Learn',
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(top: 10),
                              width:
                                  (MediaQuery.of(context).size.width / 2) - 10,
                              height: 250,
                              child: InkWell(
                                onTap: () => Navigator.of(context)
                                    .push(MaterialPageRoute(
                                  builder: (context) => const SummariseScreen(),
                                )),
                                child: Stack(
                                  children: [
                                    Center(
                                      child: Container(
                                        width:
                                            (MediaQuery.of(context).size.width /
                                                    2) -
                                                30,
                                        height: 180,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 1,
                                              blurRadius: 12,
                                              offset: const Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                        left: 40,
                                        child: Column(
                                          children: [
                                            Image.asset(
                                              'assets/images/summarise.png',
                                              width: 100,
                                              fit: BoxFit.cover,
                                            ),
                                            const SizedBox(
                                              height: 40,
                                            ),
                                            const Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: Text(
                                                  'Summarise',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                )),
                                          ],
                                        )),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(top: 10),
                              width:
                                  (MediaQuery.of(context).size.width / 2) - 10,
                              height: 250,
                              child: InkWell(
                                onTap: () => Navigator.of(context)
                                    .push(MaterialPageRoute(
                                  builder: (context) => const TimeTableScreen(),
                                )),
                                child: Stack(
                                  children: [
                                    Center(
                                      child: Container(
                                        width:
                                            (MediaQuery.of(context).size.width /
                                                    2) -
                                                30,
                                        height: 180,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 1,
                                              blurRadius: 12,
                                              offset: const Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                        left: 45,
                                        child: Column(
                                          children: [
                                            Image.asset(
                                              'assets/images/timetable.png',
                                              width: 100,
                                              fit: BoxFit.cover,
                                            ),
                                            const SizedBox(
                                              height: 40,
                                            ),
                                            const Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: Text(
                                                  'Time Table',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                )),
                                          ],
                                        )),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(top: 10),
                              width:
                                  (MediaQuery.of(context).size.width / 2) - 10,
                              height: 250,
                              child: InkWell(
                                onTap: () => Navigator.of(context)
                                    .push(MaterialPageRoute(
                                  builder: (context) => const QuestionScreen(),
                                )),
                                child: Stack(
                                  children: [
                                    Center(
                                      child: Container(
                                        width:
                                            (MediaQuery.of(context).size.width /
                                                    2) -
                                                30,
                                        height: 180,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 1,
                                              blurRadius: 12,
                                              offset: const Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                        left: 25,
                                        child: Column(
                                          children: [
                                            Image.asset(
                                              'assets/images/question.png',
                                              width: 100,
                                              fit: BoxFit.cover,
                                            ),
                                            const SizedBox(
                                              height: 40,
                                            ),
                                            const Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: Text(
                                                  'Ask Questions',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                )),
                                          ],
                                        )),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(top: 10),
                              width:
                                  (MediaQuery.of(context).size.width / 2) - 10,
                              height: 250,
                              child: InkWell(
                                onTap: () => Navigator.of(context)
                                    .push(MaterialPageRoute(
                                  builder: (context) => GrammerScreen(),
                                )),
                                child: Stack(
                                  children: [
                                    Center(
                                      child: Container(
                                        width:
                                            (MediaQuery.of(context).size.width /
                                                    2) -
                                                30,
                                        height: 180,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 1,
                                              blurRadius: 12,
                                              offset: const Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                        left: 25,
                                        child: Column(
                                          children: [
                                            Image.asset(
                                              'assets/images/scanner.png',
                                              width: 100,
                                              fit: BoxFit.cover,
                                            ),
                                            const SizedBox(
                                              height: 40,
                                            ),
                                            const Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: Text(
                                                  'Fix Grammar',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                )),
                                          ],
                                        )),
                                  ],
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
