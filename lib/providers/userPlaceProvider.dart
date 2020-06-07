import 'package:flutter/foundation.dart';
import 'package:trafficnow/module/userPlace.dart';
import 'package:trafficnow/storage/storage.dart';

class UserPlaceProvider extends ChangeNotifier {
  UserPlace _userPlace;

  UserPlace getUserData() => _userPlace;

  void setUserData(UserPlace userPlace) {
    _userPlace = userPlace;
    notifyListeners();
  }

  void changeSwitch(bool value) {
    _userPlace.turnON = value;
    notifyListeners();
  }

  Future<void> localStorage() async {
    Storage storage = new Storage();
    final ready = await storage.isReady();
    ready ? _userPlace = storage.getItems() : _userPlace = null;
  }

}
