import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:trafficnow/screens/placeInputScreen.dart';
import 'package:trafficnow/widget/mySwitchListTile.dart';
import 'package:trafficnow/module/userPlace.dart';

//TODO: What to store for GOOGLE API
//TODO: Setup localStorage (Offline Service)
//TODO: Push Notification
//TODO: Setup GoogleMAP API (Places, direction)
//TODO: Connects to the application
//TODO: direction icon on leading - route to Google Map

class MainScreen extends StatefulWidget {
  MainScreen({Key key, this.title}) : super(key: key);

  static final String id = "MainScreen";

  final String title;

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List testList = [];
  UserPlace _userPlace;
  DateTime date;
  String start;
  String dest;
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  void _addItem(UserPlace value) {
    final int _index = testList.length;
    testList.insert(_index, value);
    _listKey.currentState.insertItem(_index);
  }

  void _removeItem(int index) {
    _listKey.currentState
        .removeItem(index, (context, animation) => Container());
    testList.removeAt(index);
  }

  Widget _buildItem(UserPlace _item, int index, Animation _animation) {
    return Dismissible(
      key: Key("${testList[index]}"),
      direction: DismissDirection.endToStart,
      child: SizeTransition(
        sizeFactor: _animation,
        child: Card(
          elevation: 2.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Container(
            height: 120.0,
            child: Center(
              child: MySwitchListTile(
                date: _item.date,
                start: _item.startPoint,
                end: _item.dest,
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
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        elevation: 0.0,
        title: FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            'TrafficNow',
            style: TextStyle(fontSize: 33.0, color: Colors.black),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.black,
              size: 30.0,
            ),
            onPressed: () async {
              final result = await Navigator.pushNamed(context, PlaceInputScreen.id);

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
      body: AnimatedList(
        key: _listKey,
        initialItemCount: testList.length,
        itemBuilder: (context, index, animation) {
          return _buildItem(testList[index], index, animation);
        },
      ),
    );
  }
}
