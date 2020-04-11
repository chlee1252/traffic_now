import 'package:flutter/material.dart';
import 'package:trafficnow/screens/addScheduleScreen.dart';

class PlaceInputScreen extends StatefulWidget {

  static final String id = "PlaceInputScreen";

  @override
  _PlaceInputScreenState createState() => _PlaceInputScreenState();
}

class _PlaceInputScreenState extends State<PlaceInputScreen> {
  FocusNode _startFocusNode, _destFocusNode;
  String _start = '';
  String _dest = '';

  @override
  void initState() {
    super.initState();
    _startFocusNode = new FocusNode();
    _destFocusNode = new FocusNode();
  }

  @override
  void dispose() {
    _startFocusNode.dispose();
    _destFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: new Scaffold(
        appBar: AppBar(
          title: FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              "Set Place",
              style: TextStyle(fontSize: 30.0),
            ),
          ),
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextField(
                  focusNode: _startFocusNode,
                  onTap: () {
                    setState(() {
                      FocusScope.of(context).requestFocus(_startFocusNode);
                    });
                  },
                  onChanged: (value) {
                    setState(() {
                      _start = value;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1.0, color: Colors.black),
                    ),
                    labelText: "Start Place",
                    labelStyle: TextStyle(
                        color: _startFocusNode.hasFocus
                            ? Colors.black
                            : Colors.grey),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 30.0, left: 8.0, right: 8.0),
                child: TextField(
                  focusNode: _destFocusNode,
                  onTap: () {
                    setState(() {
                      FocusScope.of(context).requestFocus(_destFocusNode);
                    });
                  },
                  onChanged: (value) {
                    setState(() {
                      _dest = value;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Destination",
                    labelStyle: TextStyle(
                        color: _destFocusNode.hasFocus
                            ? Colors.black
                            : Colors.grey),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1.0, color: Colors.black),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: FlatButton(
                  padding: EdgeInsets.only(top: 10.0, right: 40.0),
                  child: Text(
                    "Next",
                    style: TextStyle(fontSize: 20.0),
                  ),
                  textColor: Colors.blueAccent,
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    final result = await Navigator.pushNamed(context, AddScheduleScreen.id);

                    Navigator.pop(context, result);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
