import 'package:flutter/material.dart';

class summariseScreen extends StatelessWidget {
  const summariseScreen({super.key});

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
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 400,
              height: 700,
              child: Text(
                'summary',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2)),
            ),
            TextField(
              decoration: InputDecoration(
                  floatingLabelAlignment: FloatingLabelAlignment.center,
                  suffixIcon: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.send,
                        color: Colors.black,
                      )),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  hintText: 'Type here..',
                  alignLabelWithHint: true),
            ),
          ],
        ),
      )),
    );
  }
}
