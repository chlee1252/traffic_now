import 'package:geolocator/geolocator.dart';

class Location {

  double long;
  double lat;

  Future<void> getLocation() async {
    Position position;

    try {
      position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    } catch (e) {
      position = null;
    }

    if (position != null) {
      this.long = position.longitude;
      this.lat = position.latitude;
    }

  }
}