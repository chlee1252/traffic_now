import 'package:flutter/material.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';

class MyBottomNav extends StatelessWidget {
  MyBottomNav({this.currentIndex, this.onTap});

  final int currentIndex;
  final ValueChanged<int> onTap;
  @override
  Widget build(BuildContext context) {
    return BubbleBottomBar(
      hasNotch: true,
      fabLocation: BubbleBottomBarFabLocation.end,
      opacity: .2,
      currentIndex: this.currentIndex,
      elevation: 8,
      onTap: this.onTap,
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
    );
  }
}
