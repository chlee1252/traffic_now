import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:trafficnow/API/credential.dart';
import 'package:trafficnow/module/userPlace.dart';

class ConvertLatLong {
  ConvertLatLong({this.data});

  final UserPlace data;

  Future<LatLng> getLatLng() async {
    LatLng geo;
    final String url =
        'https://maps.googleapis.com/maps/api/geocode/json?address=${this.data.formatURL()}&key=$myKey';
    var response = await http.get(url, headers: {
      "Accept": "application/json",
    });

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var lat = json['results'][0]['geometry']['location']['lat'];
      var long = json['results'][0]['geometry']['location']['lng'];

      geo = LatLng(lat, long);
    }

    return geo;
  }
}
