import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:trafficnow/providers/userPlaceProvider.dart';
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
    await Provider.of<UserPlaceProvider>(context, listen: false).localStorage();

    Location location = Location();
    await location.getLocation();

    LatLng position;
    if (location.lat != null && location.long != null) position = LatLng(location.lat, location.long);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return MainScreen(
            position: position,
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
