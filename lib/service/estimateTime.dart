import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:trafficnow/module/userPlace.dart';
import 'package:trafficnow/API/credential.dart';

class EstimateTime {
  EstimateTime({this.userData});

  final UserPlace userData;
  Future<UserPlace> getEstimate() async {
    final String url =
        "https://maps.googleapis.com/maps/api/directions/json?departure_time=now&origin=place_id:${this.userData.startID}&destination=place_id:${this.userData.destID}&key=$myKey";
    print(url);
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
