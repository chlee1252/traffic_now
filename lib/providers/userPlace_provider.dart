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

  void localStorage() {
    Storage storage = new Storage();
    storage.isReady().then((data) {
      if (data) {
        _userPlace = storage.getItems();
      } else {
        _userPlace = null;
      }
    });
    notifyListeners();
  }
}
