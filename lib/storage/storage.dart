import 'package:localstorage/localstorage.dart';
import 'package:trafficnow/module/scheduleList.dart';
import 'package:trafficnow/module/userPlace.dart';

class Storage {
  ScheduleList scheduleList = new ScheduleList();
  LocalStorage storage = LocalStorage('app.json');

  // Check the storage is ready
  isReady() async {
    bool ready = await storage.ready;
    return ready;
  }

  setItem(UserPlace list) {
    storage.setItem('item', list.supportJSON());
  }

//  // Set item to local storage
//  setItem(ScheduleList list) {
//    storage.setItem('item', list.supportJSON());
//  }

  // Clear all Item in localStorage
  clearItem() async {
    await storage.clear();
    scheduleList.scheduleList = [];
  }

  getItems() {
    UserPlace result;
    final item = storage.getItem('item');
    if (item != null) {
      result = UserPlace(
        date: DateTime.parse(item['date']),
        startPoint: item['start'],
        dest: item['dest'],
        startID: item['startID'],
        destID: item['destID'],
        turnON: item['turnON'],
      );
    }

    return result;
  }
//
//  // Get items from local storage
//  getItems() {
//    final result = storage.getItem('item');
//    if (result != null) {
//      scheduleList.scheduleList = List<UserPlace>.from(
//        (result as List).map(
//          (item) => UserPlace(
//            date: DateTime.parse(item['date']),
//            startPoint: item['start'],
//            dest: item['dest'],
//            startID: item['startID'],
//            destID: item['destID'],
//            turnON: item['turnON'],
//          ),
//        ),
//      );
//    }
//    return scheduleList;
//  }
}
