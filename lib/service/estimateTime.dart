import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:trafficnow/module/userPlace.dart';
import 'package:trafficnow/API/credential.dart';

class EstimateTime {
  EstimateTime({this.userData, this.userGeo});

  final UserPlace userData;
  final LatLng userGeo;
//  Set<LatLng> navigation = {};

  Future<Set> getSteps() async {
    Set<LatLng> navigation = {};
    final String url =
        "https://maps.googleapis.com/maps/api/directions/json?departure_time=now&origin=${this.userGeo.latitude}, ${this.userGeo.longitude}&destination=place_id:${this.userData.destID}&key=$myKey";
    var response = await http.get(url, headers: {
      "Accept": "application/json",
    });

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      try {
        var steps = data['routes'][0]['legs'][0]['steps'];
        steps.forEach((value) {
          navigation.add(LatLng(value['start_location']['lat'], value['start_location']['lng']));
          navigation.add(LatLng(value['end_location']['lat'], value['end_location']['lng']));
        });
      } catch(e) {
        print(e);
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
