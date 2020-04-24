import 'package:flutter/material.dart';
import 'package:trafficnow/module/userPlace.dart';
import 'package:trafficnow/screens/placeInputScreen.dart';
import 'package:trafficnow/service/estimateTime.dart';
import 'package:trafficnow/widget/alarmTile.dart';
import 'package:trafficnow/widget/destTile.dart';
import 'package:trafficnow/widget/emptyTile.dart';
import 'package:trafficnow/widget/infoCard.dart';
import 'package:trafficnow/widget/myBottomNav.dart';

//TODO: Embed GoogleMap
//TODO: localStorage refactor
//TODO: Result Card
//TODO: background Fetch

class NewMainScreen extends StatefulWidget {
  static final String id = "NewMainScreen";

  @override
  _NewMainScreenState createState() => _NewMainScreenState();
}

class _NewMainScreenState extends State<NewMainScreen> {
  UserPlace _userPlace;
  int _currentIndex = 0;

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
                  InfoCard(
                    child: _userPlace == null
                        ? EmptyTile()
                        : DestTile(
                            dest: _userPlace.dest,
                          ),
                  ),
                  InfoCard(
                    child: _userPlace == null
                        ? EmptyTile()
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
                  InfoCard(
                    child: Container(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MyBottomNav(
        currentIndex: _currentIndex,
        onTap: (index) async {
          if (index == 2 && _userPlace != null) {
            try {
              final UserPlace result =
                  await EstimateTime(userData: this._userPlace)
                  .getEstimate();

              print(result.estTime);
            } catch(e) {
              print(e);
            }
          }
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
