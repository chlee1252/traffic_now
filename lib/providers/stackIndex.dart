import 'package:flutter/foundation.dart';

class StackIndex extends ChangeNotifier {
  int _index = 0;

  int getIndex() => _index;

  void setIndex(int newIndex) {
    _index = newIndex;
    notifyListeners();
  }
}