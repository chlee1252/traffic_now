import 'package:flutter/material.dart';

import './screens/mainScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TrafficNow',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: MainScreen(title: 'TrafficNow'),
    );
  }
}