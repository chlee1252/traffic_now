import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';
import 'package:trafficnow/module/scheduleList.dart';
import 'package:trafficnow/module/userPlace.dart';

class Storage {
  ScheduleList scheduleList = new ScheduleList();
  LocalStorage storage = LocalStorage('app.json');

  isReady() async {
    bool ready = await storage.ready;
    return ready;
  }

  setItem(ScheduleList list) {
    storage.setItem('item', list.supportJSON());
  }

  clearItem() async {
    await storage.clear();
    scheduleList.scheduleList = [];
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
    return scheduleList;
  }

}
