import 'dart:convert';

import 'package:aira/screens/question_answer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class QuestionListScreen extends StatefulWidget {
  const QuestionListScreen({super.key, required this.questions});

  final List<String> questions;

  @override
  State<QuestionListScreen> createState() => _QuestionListScreenState();
}

class _QuestionListScreenState extends State<QuestionListScreen> {
  bool isLoading = false;

  int buttonIndex = -1;

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
          padding: const EdgeInsets.all(10),
          itemCount: widget.questions.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                ListTile(
                  title: SelectableText(
                    widget.questions[index],
                    style: const TextStyle(fontSize: 18),
                  ),
                  trailing: isLoading && buttonIndex == index
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.amber,
                              foregroundColor: Colors.black),
                          onPressed: () async {
                            buttonIndex = index;
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
                                          "content": widget.questions[index]
                                        }
                                      ],
                                      'temperature': 0.5,
                                    }))
                                .then((value) => Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) =>
                                          QuestionAnswerScreen(
                                              question: widget.questions[index],
                                              answer: jsonDecode(
                                                      value.body)['choices'][0]
                                                  ['message']['content']),
                                    )));

                            setState(() {
                              isLoading = false;
                            });
                          },
                          child: const Text('Show Answer'),
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
