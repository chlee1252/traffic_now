import 'package:flutter/foundation.dart';

class SelectTime extends ChangeNotifier {
  DateTime _time;

  DateTime getTime() => _time;

  void setTime(DateTime newTime) {
    _time = newTime;
    notifyListeners();
  }

  SelectTime () {
    _time = DateTime.now();
    notifyListeners();
  }
}