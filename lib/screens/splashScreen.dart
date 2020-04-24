import 'dart:async';

import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:trafficnow/screens/mainScreen.dart';
import 'package:trafficnow/screens/newMainScreen.dart';
import 'package:trafficnow/service/location.dart';

class SplashScreen extends StatefulWidget {
  static final String id = "SplashScreen";

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  _getUserLocation() async {
    Location location = Location();
    await location.getLocation();

    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacementNamed(context, NewMainScreen.id,
            arguments: {'userLocation': location}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(219, 235, 196, 1.0),
      body: Center(
        child: FadeAnimatedTextKit(
          text: ["TrafficNow"],
          textStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 45.0,
            letterSpacing: 2.5,
          ),
        ),
      ),
    );
  }
}
