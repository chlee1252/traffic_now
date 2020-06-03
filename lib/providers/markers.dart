import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trafficnow/module/userPlace.dart';
import 'package:trafficnow/service/convertLatLong.dart';

class Markers extends ChangeNotifier {
  Set _markers = {};

  Set getMarkers() => _markers;

  Future<LatLng> _getLatLng(UserPlace userPlace) async {
    ConvertLatLong data = ConvertLatLong(data: userPlace);
    LatLng result;
    try {
      result = await data.getLatLng();
    } catch (e) {
      result = null;
    }
    return result;
  }

  void addMarker(UserPlace result) async {
    var data = await _getLatLng(result);
    if (data != null) {
      if (_markers.length > 1) _markers.remove(_markers.last);

      _markers.add(Marker(
          markerId: MarkerId(data.toString()),
          position: data,
          icon: BitmapDescriptor.defaultMarker));
    }
    notifyListeners();
  }
}
