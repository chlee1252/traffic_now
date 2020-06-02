import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:trafficnow/screens/mainScreen.dart';
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

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return MainScreen(
            userLocation: location,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(219, 235, 196, 1.0),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "TrafficNow",
              style: TextStyle(fontSize: 30.0, color: Colors.black),
            ),
            SizedBox(
              height: 10.0,
            ),
            SpinKitFadingFour(
              color: Colors.black,
              size: 40.0,
            ),
          ],
        ),
      ),
    );
  }
}
