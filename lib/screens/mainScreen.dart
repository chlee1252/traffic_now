import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:trafficnow/screens/placeInputScreen.dart';
import 'package:trafficnow/widget/mySwitchListTile.dart';
import 'package:trafficnow/module/userPlace.dart';
import 'package:trafficnow/module/scheduleList.dart';
import 'package:trafficnow/storage/storage.dart';
import 'package:trafficnow/notification/notification.dart';

//TODO: Change UI/UX, put Google Map
//TODO: Get Current Location
//TODO: Put Marker in Google Map
//TODO: Background Execution (background_fetch 0.5.5)
//TODO: Setup GoogleMAP API (Places, direction)
// ["routes"][0]["legs"][0]["duration_in_traffic"]['text']
// https://maps.googleapis.com/maps/api/directions/json?departure_time=now&origin=place_id:{}&destination=place_id:{}&key=myKey

class MainScreen extends StatefulWidget {
  MainScreen({Key key}) : super(key: key);

  static final String id = "MainScreen";

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  ScheduleList testList;
  UserPlace _userPlace;
  DateTime date;
  String start, dest;
  Storage storage = new Storage();
  FlutterLocalNotificationsPlugin plugin;
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    super.initState();
    storage.isReady().then((data) {
      setState(() {
        data ? testList = storage.getItems() : testList = new ScheduleList();
      });
    });
    plugin = FlutterLocalNotificationsPlugin();
    requestIOS(plugin);
    initializeNotifications(plugin);
  }

  void _addItem(UserPlace value) {
    final int _index = testList.scheduleList.length;
    testList.scheduleList.insert(_index, value);
    _listKey.currentState.insertItem(_index);
    setState(() {
//      storage.setItem(testList);
    });
  }

  void _removeItem(int index) {
    _listKey.currentState
        .removeItem(index, (context, animation) => Container());
    testList.scheduleList.removeAt(index);
    setState(() {
//      storage.setItem(testList);
      testList = storage.scheduleList;
    });
  }

  Widget _buildItem(UserPlace _item, int index, Animation _animation) {
    return Dismissible(
      key: Key("${testList.scheduleList[index]}"),
      direction: DismissDirection.endToStart,
      child: SizeTransition(
        sizeFactor: _animation,
        child: Card(
          color: Colors.white,
          elevation: 2.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Container(
            height: 120.0,
            child: Center(
              child: MySwitchListTile(
                plugin: plugin,
                myKey: index,
                data: _item,
                index: index,
                storage: this.storage,
                list: this.testList,
              ),
            ),
          ),
        ),
      ),
      background: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.red,
        child: Container(
          alignment: AlignmentDirectional.centerEnd,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.delete,
              color: Colors.white,
              size: 30.0,
            ),
          ),
        ),
      ),
      onDismissed: (direction) {
        setState(() {
          _removeItem(index);
          plugin.cancel(index);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(219, 235, 196, 1.0),
      appBar: AppBar(
        centerTitle: false,
        elevation: 0.0,
        title: FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            'TrafficNow',
            style: TextStyle(fontSize: 33.0),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
//              color: Colors.white,
              size: 30.0,
            ),
            onPressed: () async {
              final result =
                  await Navigator.pushNamed(context, PlaceInputScreen.id);
              setState(() {
                this._userPlace = result;
                if (this._userPlace != null) {
                  _addItem(this._userPlace);
                }
              });
            },
          )
        ],
      ),
      body: testList == null
          ? Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : AnimatedList(
              key: _listKey,
              initialItemCount: testList.scheduleList.length,
              itemBuilder: (
                context,
                index,
                animation
              ) {
                return _buildItem(
                    testList.scheduleList[index], index, animation);
              },
            ),
    );
  }
}
