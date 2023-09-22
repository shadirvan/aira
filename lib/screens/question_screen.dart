import 'dart:convert';

import 'package:aira/screens/question_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  // Decalre TextEditing Controller for getting text
  TextEditingController _topicController = TextEditingController();

  String _topic = '';
  bool _isLoading = false;
  List<String> questions = [];

  @override
  void dispose() {
    super.dispose();
    // dispose the controller when not in use
    _topicController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ask Question',
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
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          TextField(
              controller: _topicController,
              decoration: InputDecoration(
                label: const Text('Topic'),
                hintText: 'Ask question from',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(40)),
              )),
          const SizedBox(
            height: 10,
          ),
          _isLoading
              ? CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: () async {
                    _topic = _topicController.text;

                    setState(() {
                      _isLoading = true;
                    });

                    final response = await http
                        .post(
                            Uri.parse(
                                'https://api.openai.com/v1/chat/completions'),
                            headers: {
                              'Content-Type': 'application/json',
                              'Authorization': 'Bearer ${dotenv.env['token']}',
                            },
                            body: jsonEncode({
                              'model': 'gpt-3.5-turbo',
                              "messages": [
                                {
                                  "role": "user",
                                  "content":
                                      "ask me  5  questions about $_topic"
                                }
                              ],
                              'temperature': 0.5,
                            }))
                        .then(
                      (value) {
                        questions = jsonDecode(value.body)['choices'][0]
                                ['message']['content']
                            .split('\n');

                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              QuestionListScreen(questions: questions),
                        ));
                      },
                    );

                    setState(() {
                      _isLoading = false;
                    });

                    String rawData = jsonDecode(response.body)['choices'][0]
                        ['message']['content'];

                    print(rawData);

                    questions = rawData.split('\n');
                    print(questions);
                  },
                  child: const Text('Ask Question'))
        ]),
      ),
    );
  }
}
