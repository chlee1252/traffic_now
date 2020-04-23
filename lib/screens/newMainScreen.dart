import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:trafficnow/module/userPlace.dart';
import 'package:trafficnow/screens/placeInputScreen.dart';
import 'package:trafficnow/widget/alarmTile.dart';

class NewMainScreen extends StatefulWidget {
  static final String id = "NewMainScreen";

  @override
  _NewMainScreenState createState() => _NewMainScreenState();
}

class _NewMainScreenState extends State<NewMainScreen> {
  UserPlace _userPlace;
  int _currentIndex = 0;
  bool _value = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_alarm),
        onPressed: () async {
          final result =
              await Navigator.pushNamed(context, PlaceInputScreen.id);
          setState(() {
            _userPlace = result;
          });
        },
        backgroundColor: Color.fromRGBO(219, 235, 196, 1.0),
        foregroundColor: Colors.black,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Placeholder(),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.20,
              child: IndexedStack(
                index: _currentIndex,
                children: [
                  Card(
                    elevation: 3.0,
                    color: Colors.white,
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey, width: 2),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: _userPlace == null
                        ? Center(
                            child: Padding(
                              padding: const EdgeInsets.all(40.0),
                              child: AutoSizeText(
                                "Please add Destination :)",
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                                maxLines: 1,
                              ),
                            ),
                          )
                        : Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.15,
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Icon(
                                      Icons.location_on,
                                      size: 35.0,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: AutoSizeText(
                                    _userPlace.dest,
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ),
                  Card(
                    elevation: 3.0,
                    color: Colors.white,
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey, width: 2.0),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: _userPlace == null
                        ? Center(
                            child: Padding(
                              padding: const EdgeInsets.all(40.0),
                              child: AutoSizeText(
                                "Please add Schedule :)",
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                                maxLines: 1,
                              ),
                            ),
                          )
                        : AlarmTile(
                            value: _userPlace.turnON,
                            date: _userPlace.date,
                            onChanged: (value) {
                              setState(() {
                                _userPlace.turnON = value;
                              });
                            },
                          ),
                  ),
                  Card(
                    elevation: 3.0,
                    color: Colors.white,
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey, width: 2.0),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Container(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BubbleBottomBar(
        hasNotch: true,
        fabLocation: BubbleBottomBarFabLocation.end,
        opacity: .2,
        currentIndex: _currentIndex,
        elevation: 8,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: <BubbleBottomBarItem>[
          BubbleBottomBarItem(
            backgroundColor: Colors.lightGreen,
            icon: Icon(Icons.location_on, color: Colors.lightGreen),
            activeIcon: Icon(Icons.location_on, color: Colors.lightGreen),
            title: Text('Destination'),
          ),
          BubbleBottomBarItem(
            backgroundColor: Colors.lightGreen,
            icon: Icon(Icons.access_alarm, color: Colors.lightGreen),
            activeIcon: Icon(Icons.access_alarm, color: Colors.lightGreen),
            title: Text('Time'),
          ),
          BubbleBottomBarItem(
            backgroundColor: Colors.lightGreen,
            icon: Icon(Icons.message, color: Colors.lightGreen),
            activeIcon: Icon(Icons.message, color: Colors.lightGreen),
            title: Text('Estimated'),
          ),
        ],
      ),
    );
  }
}
