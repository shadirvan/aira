import 'dart:convert';

import 'package:aira/widgets/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class summariseScreen extends StatefulWidget {
  summariseScreen({super.key});

  @override
  State<summariseScreen> createState() => _summariseScreenState();
}

class _summariseScreenState extends State<summariseScreen> {
  final TextEditingController _summaryController = TextEditingController();
  List<Widget> messageWidgets = [];
  var replayMessages = [];
  String promptMessage = '';
  int words = 0;

  @override
  void dispose() {
    // TODO: implement dispose
    _summaryController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Summarise',
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
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(20),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(blurRadius: 5, color: Colors.grey)
                  ],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.black,
                    width: 1,
                  )),
              child: messageWidgets.isEmpty
                  ? const Center(
                      child: Text('Try summerising something! '),
                    )
                  : ListView.builder(
                      itemCount: messageWidgets.length,
                      itemBuilder: (context, index) {
                        return messageWidgets[index];
                      },
                    ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            child: TextField(
              textAlignVertical: TextAlignVertical.center,
              controller: _summaryController,
              maxLines: 5,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  floatingLabelAlignment: FloatingLabelAlignment.center,
                  suffixIcon: IconButton(
                      onPressed: () async {
                        setState(() {});
                        promptMessage = _summaryController.text;
                        List<String> splitMessage = promptMessage.split(' ');

                        words = splitMessage.length;

                        _summaryController.clear();

                        messageWidgets.add(MessageBubble.first(
                            userImage: '',
                            username: 'User',
                            message: promptMessage,
                            isMe: true));

                        final response = await http.post(
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
                                      "summarise $promptMessage in ${words / 2} words"
                                }
                              ],
                              'temperature': 0.7,
                            }));
                        setState(() {
                          print(jsonDecode(response.body)['choices'][0]
                              ['message']['content']);
                          messageWidgets.add(MessageBubble.first(
                              userImage: '',
                              username: 'AI',
                              message: jsonDecode(response.body)['choices'][0]
                                  ['message']['content'],
                              isMe: false));
                        });
                      },
                      icon: const Icon(
                        Icons.send,
                        color: Colors.black,
                      )),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  hintText: 'what do you want to summarise',
                  alignLabelWithHint: true),
            ),
          ),
        ],
      )),
    );
  }
}
