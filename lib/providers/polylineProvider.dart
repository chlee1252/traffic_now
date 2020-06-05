import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trafficnow/module/userPlace.dart';
import 'package:trafficnow/service/estimateTime.dart';

class Polylines extends ChangeNotifier {
  Set _polyline = {};

  Set getPolylines() => _polyline;

  void addRoute(UserPlace result, LatLng position) async {
    var routes =
    await EstimateTime(userData: result, userGeo: position)
        .getSteps();
    if (routes.length != 0) {
        _polyline.clear();
        _polyline.add(Polyline(
          polylineId: PolylineId("direction"),
          visible: true,
          points: routes,
          width: 3,
          color: Colors.blue,
        ));
    }
    notifyListeners();
  }
}