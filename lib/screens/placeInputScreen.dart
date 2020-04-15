import 'package:flutter/material.dart';
import 'package:trafficnow/module/userPlace.dart';
import 'package:trafficnow/screens/addScheduleScreen.dart';
import 'package:trafficnow/API/credential.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:trafficnow/widget/myDialog.dart';

class PlaceInputScreen extends StatefulWidget {
  static final String id = "PlaceInputScreen";

  @override
  _PlaceInputScreenState createState() => _PlaceInputScreenState();
}

class _PlaceInputScreenState extends State<PlaceInputScreen> {
  FocusNode _startFocusNode, _destFocusNode;
  TextEditingController _startController, _destController;
  UserPlace _data;

  @override
  void initState() {
    super.initState();
    _startFocusNode = new FocusNode();
    _destFocusNode = new FocusNode();
    _startController = new TextEditingController();
    _destController = new TextEditingController();
    _data = new UserPlace();
  }

  @override
  void dispose() {
    _startFocusNode.dispose();
    _destFocusNode.dispose();
    _startController.dispose();
    _destController.dispose();
    super.dispose();
  }

  Future<Prediction> getPrediction() async {
    Prediction p = await PlacesAutocomplete.show(
        context: context,
        apiKey: myKey,
        mode: Mode.fullscreen,
        language: "en",
        components: [new Component(Component.country, "us")]);

    return p;
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
                  controller: _startController,
                  onTap: () async {
                    var value = await getPrediction();

                    if (value != null) {
                      _startController.text = value.description;
                      setState(() {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        this._data.startPoint = value?.description;
                        this._data.startID = value?.id;
                      });
                    }
                  },
                  onChanged: (value) {
                    setState(() {
                      this._data.startPoint = value;
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
                  controller: _destController,
                  onTap: () async {
                    var value = await getPrediction();

                    if (value != null) {
                      _destController.text = value.description;
                      setState(() {
                        this._data.dest = value?.description;
                        this._data.destID = value?.id;
                      });
                    }
                    FocusScope.of(context).requestFocus(new FocusNode());
                  },
                  onChanged: (value) {
                    setState(() {
                      this._data.dest = value;
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
                    if (this._data.startPoint == null || this._data.dest == null) {
                      closeButtonDialog(
                          context: context,
                          title: "Input Error",
                          content: "Please Enter all your input! :)");
                    } else {
                      final result = await Navigator.pushNamed(
                          context, AddScheduleScreen.id,
                          arguments: {'data': this._data});
                      Navigator.pop(context, result);
                    }
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
