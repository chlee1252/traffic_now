import 'package:trafficnow/module/userPlace.dart';

// Source Code is from localStorage library example
// https://pub.dev/packages/localstorage#-example-tab-
class ScheduleList {
  List<UserPlace> scheduleList;

  ScheduleList() {
    scheduleList = new List();
  }

  supportJSON() {
    return scheduleList.map((item) {
      return item.supportJSON();
    }).toList();
  }
}