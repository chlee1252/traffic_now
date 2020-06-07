import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trafficnow/module/userPlace.dart';
import 'package:trafficnow/service/estimateTime.dart';

class PolylineProvider extends ChangeNotifier {
  Set<Polyline> _polyline = {};

  Set<Polyline> getPolylines() => _polyline;

  Future<void> addRoute(UserPlace result, LatLng position) async {
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
  }

  addRouteNotifier({UserPlace userPlace, LatLng position}) async {
    await addRoute(userPlace, position);
    notifyListeners();
  }

  PolylineProvider({UserPlace userPlace, LatLng position}) {
    addRoute(userPlace, position).then((data) {
      notifyListeners();
    });
  }
}