import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:trafficnow/module/userPlace.dart';
import 'package:trafficnow/API/credential.dart';

class EstimateTime {
  EstimateTime({this.userData, this.userGeo});

  final UserPlace userData;
  final LatLng userGeo;

  // Code is from Medium
  List _decode(String poly) {
    var list = poly.codeUnits;
    var lList = new List();
    int index = 0;
    int len = poly.length;
    int c = 0;
    do {
      var shift = 0;
      int result = 0;
      do {
        c = list[index] - 63;
        result |= (c & 0x1F) << (shift * 5);
        index++;
        shift++;
      }
      while (c >= 32);
      if (result & 1 == 1) {
        result = ~result;
      }
      var result1 = (result >> 1) * 0.00001;
      lList.add(result1);
    } while (index < len);
    for (var i = 2; i < lList.length; i++)
      lList[i] += lList[i - 2];
    return lList;
  }

  List<LatLng> _convertToLatLng(List points) {
    List<LatLng> result = [];
    for (int i = 0; i < points.length; i++) {
      if (i % 2 != 0) {
        result.add(LatLng(points[i-1], points[i]));
      }
    }
    return result;
  }

  Future<List> getSteps() async {
    List<LatLng> navigation;
    final String url =
        "https://maps.googleapis.com/maps/api/directions/json?departure_time=now&origin=${this.userGeo.latitude}, ${this.userGeo.longitude}&destination=place_id:${this.userData.destID}&key=$myKey";
    var response = await http.get(url, headers: {
      "Accept": "application/json",
    });

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      try {
        var steps = data['routes'][0]['overview_polyline']['points'];
        navigation = _convertToLatLng(_decode(steps));
      } catch (e) {
        navigation = [];
      }
    }
    return navigation;
  }

  Future<UserPlace> getEstimate() async {
    final String url =
        "https://maps.googleapis.com/maps/api/directions/json?departure_time=now&origin=${this.userGeo.latitude}, ${this.userGeo.longitude}&destination=place_id:${this.userData.destID}&key=$myKey";
    var response = await http.get(url, headers: {
      "Accept": "application/json",
    });

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      try {
        var time = data["routes"][0]["legs"][0]["duration_in_traffic"]['text'];
        userData.estTime = time;
      } catch (e) {
        var time = data["routes"][0]["legs"][0]["duration"]['text'];
        userData.estTime = time;
      }
    }

    return userData;
  }
}
