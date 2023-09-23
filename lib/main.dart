import 'package:aira/screens/login.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:flutter/material.dart';

Future<void> main() async {
  await dotenv.load();
  runApp(const MaterialApp(
    home: LoginScreen(),
  ));
}
