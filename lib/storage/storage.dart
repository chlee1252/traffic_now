import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';
import 'package:trafficnow/module/scheduleList.dart';
import 'package:trafficnow/module/userPlace.dart';

class Storage {
  ScheduleList scheduleList = new ScheduleList();
  final LocalStorage storage = LocalStorage('app.json');

  setItem(ScheduleList list) {
    storage.setItem('item', list.supportJSON());
  }

  getItems() {
    final result = storage.getItem('item');
    if (result != null) {
      scheduleList.scheduleList = List<UserPlace>.from(
        (result as List).map(
          (item) => UserPlace(
            date: DateTime.parse(item['date']),
            startPoint: item['start'],
            dest: item['dest'],
            startID: item['startID'],
            destID: item['destID'],
            turnON: item['turnON'],
          ),
        ),
      );
    }
  }

//  Storage() {
//   getItems();
//  }
}
