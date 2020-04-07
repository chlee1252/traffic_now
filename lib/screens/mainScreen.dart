import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List testList = [];
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
//  int _index;

  void _addItem() {
    final int _index = testList.length;
    testList.insert(_index, _index);
    _listKey.currentState.insertItem(_index);
  }

  void _removeItem(int index) {
    _listKey.currentState
        .removeItem(index, (context, animation) => Container());
    testList.removeAt(index);
  }

  Widget _buildItem(String _item, int index, Animation _animation) {
    return Dismissible(
      key: Key("${testList[index]}"),
      direction: DismissDirection.endToStart,
      child: SizeTransition(
        sizeFactor: _animation,
        child: Card(
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Container(
            height: 100.0,
            child: ListTile(
              title: Text(
                _item,
              ),
              //TODO: trailing insert switch
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
            onPressed: () => _addItem(),
          )
        ],
      ),
      body: AnimatedList(
        key: _listKey,
        initialItemCount: testList.length,
        itemBuilder: (context, index, animation) {
          return _buildItem(testList[index].toString(), index, animation);
        },
      ),
    );
  }
}
