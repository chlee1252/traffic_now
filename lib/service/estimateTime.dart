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

  String reformat(routes) {
    String latlng_string = "";
    routes.toList().forEach((element) {
      latlng_string += "${element.latitude},${element.longitude}|";
    });

    return latlng_string.substring(0, latlng_string.length - 1);
  }

  Future<Set> getSteps() async {
//    String latlng_string = "";
//    routes.toList().forEach((element) {
//      latlng_string += "${element.latitude},${element.longitude}|";
//    });
//    latlng_string = latlng_string.substring(0, latlng_string.length-1);
//    final String url = "https://roads.googleapis.com/v1/snapToRoads?interpolate=true&path=$latlng_string&key=$myKey";
//    var response = await http.get(url, headers: {
//      "Accept": "application/json",
//    });
//
//    if (response.statusCode == 200) {
//      var data = jsonDecode(response.body);
//
//      data['snappedPoints'].forEach((element) {
//        print(element['location']['latitude']);
//        print(element['location']['longitude']);
//      });
////      print(data['snappedPoints']['location']['latitude']);
////      print(data['snappedPoints']['location']['longitude']);
//    } else {
//      print(response.statusCode);
//    }
    Set<LatLng> navigation = {};
    String latlng = "";
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
          navigation.add(LatLng(
              value['start_location']['lat'], value['start_location']['lng']));
          navigation.add(LatLng(
              value['end_location']['lat'], value['end_location']['lng']));
        });
      } catch (e) {
        print(e);
      }
    }

    if (navigation.length > 0) {
      final String roadUrl =
          "https://roads.googleapis.com/v1/snapToRoads?interpolate=true&path=${this.reformat(navigation)}&key=$myKey";
      print(roadUrl);
      var response = await http.get(roadUrl, headers: {
        "Accept": "application/json",
      });
      if (response.statusCode == 200) {
        navigation.clear();
        var data = jsonDecode(response.body);
        try {
          data['snappedPoints'].forEach((element) {
            navigation.add(LatLng(element['location']['latitude'], element['location']['longitude']));
          });
        } catch (e) {
          print(e);
        }
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
