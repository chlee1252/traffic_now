import 'package:flutter/material.dart';
import 'package:trafficnow/screens/addScheduleScreen.dart';
import 'package:trafficnow/screens/mainScreen.dart';
import 'package:trafficnow/screens/placeInputScreen.dart';



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
        primaryColor: Color.fromRGBO(219, 235, 196, 1.0),
      ),
      home: MainScreen(title: 'TrafficNow'),
      initialRoute: MainScreen.id,
      routes: {
        MainScreen.id: (context) => MainScreen(),
        AddScheduleScreen.id: (context) => AddScheduleScreen(),
        PlaceInputScreen.id: (context) => PlaceInputScreen(),
      },
    );
  }
}