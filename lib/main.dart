import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:trafficnow/providers/userPlaceProvider.dart';
import 'package:trafficnow/screens/addScheduleScreen.dart';
import 'package:trafficnow/screens/placeInputScreen.dart';
import 'package:trafficnow/screens/splashScreen.dart';
import 'package:trafficnow/screens/mainScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ChangeNotifierProvider(
      create: (context) => UserPlaceProvider(),
      child: MaterialApp(
        title: 'TrafficNow',
        theme: ThemeData(
          primaryColor: Colors.white,
        ),
        home: SplashScreen(),
        initialRoute: SplashScreen.id,
        routes: {
          SplashScreen.id : (context) => SplashScreen(),
          MainScreen.id: (context) => MainScreen(),
          AddScheduleScreen.id: (context) => AddScheduleScreen(),
          PlaceInputScreen.id: (context) => PlaceInputScreen(),
        },
      ),
    );
  }
}