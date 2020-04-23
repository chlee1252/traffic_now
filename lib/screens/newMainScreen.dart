import 'package:flutter/material.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:trafficnow/screens/placeInputScreen.dart';

class NewMainScreen extends StatefulWidget {
  static final String id = "NewMainScreen";

  @override
  _NewMainScreenState createState() => _NewMainScreenState();
}

class _NewMainScreenState extends State<NewMainScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_alarm),
        onPressed: () {
          Navigator.pushNamed(context, PlaceInputScreen.id);
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
            Expanded(
              child: IndexedStack(
                index: _currentIndex,
                children: [
                  Card(
                    elevation: 3.0,
                    color: Colors.grey,
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child:
                    Container(),
                  ),
                  Card(
                    elevation: 3.0,
                    color: Colors.red,
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child:
                    Container(),
                  ),
                  Card(
                    elevation: 3.0,
                    color: Colors.green,
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child:
                    Container(),
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
