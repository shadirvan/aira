import 'package:aira/widgets/message_bubble.dart';
import 'package:flutter/material.dart';

class summariseScreen extends StatefulWidget {
  summariseScreen({super.key});

  @override
  State<summariseScreen> createState() => _summariseScreenState();
}

class _summariseScreenState extends State<summariseScreen> {
  final TextEditingController _summaryController = TextEditingController();
  var messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
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
              child: messages.isEmpty
                  ? const Center(
                      child: Text('Try summerising something! '),
                    )
                  : ListView.builder(
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        return MessageBubble.first(
                            username: 'User',
                            userImage:
                                'https://cdn-icons-png.flaticon.com/512/219/219970.png',
                            message: messages[index],
                            isMe: false);
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
                      onPressed: () {
                        setState(() {
                          messages.add(_summaryController.text);
                        });
                        _summaryController.clear();
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
