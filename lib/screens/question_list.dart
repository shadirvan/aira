import 'package:flutter/material.dart';

class QuestionListScreen extends StatelessWidget {
  QuestionListScreen({super.key, required this.questions});

  List<String> questions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Questions',
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
      body: Center(
        child: ListView.builder(
          padding: EdgeInsets.all(10),
          itemCount: questions.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                questions[index],
                style: TextStyle(fontSize: 18),
              ),
            );
          },
        ),
      ),
    );
  }
}
