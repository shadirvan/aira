import 'dart:math';

import 'package:flutter/material.dart';

class home_screen extends StatelessWidget {
  const home_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Hi, John',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.account_circle_rounded,
                color: Colors.black,
                size: 40,
              )),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: SafeArea(
          child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Text(
            'Lets Learn',
            style: TextStyle(
                color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(30),
                child: Container(
                  height: 180,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Column(
                    children: [
                      Image(
                        image: AssetImage('assets/images/teacher.jpg'),
                        width: 130,
                        alignment: Alignment.topRight,
                      ),
                      Text(
                        'ask me',
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  height: 180,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Image(
                        image: AssetImage('assets/images/scanner.jpg'),
                        width: 130,
                      ),
                      Text(
                        'Scan me',
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  height: 180,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Image(
                        image: AssetImage('assets/images/exam 2.webp'),
                        width: 130,
                        height: 118,
                      ),
                      Text(
                        'Start Quiz',
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 18,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  height: 180,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Image(
                        image: AssetImage('assets/images/timetable.jpg'),
                        width: 130,
                      ),
                      Text(
                        'Create Time-table',
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      )),
    );
  }
}
