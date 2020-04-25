import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trafficnow/module/userPlace.dart';
import 'package:trafficnow/screens/placeInputScreen.dart';
import 'package:trafficnow/service/convertLatLong.dart';
import 'package:trafficnow/service/estimateTime.dart';
import 'package:trafficnow/widget/alarmTile.dart';
import 'package:trafficnow/widget/destTile.dart';
import 'package:trafficnow/widget/emptyTile.dart';
import 'package:trafficnow/widget/estTile.dart';
import 'package:trafficnow/widget/infoCard.dart';
import 'package:trafficnow/widget/myBottomNav.dart';

//TODO: Google Map draw direction
//TODO: localStorage refactor
//TODO: background Fetch

class NewMainScreen extends StatefulWidget {
  static final String id = "NewMainScreen";

  @override
  _NewMainScreenState createState() => _NewMainScreenState();
}

class _NewMainScreenState extends State<NewMainScreen> {
  UserPlace _userPlace;
  int _currentIndex = 0;
  Set<Marker> _markers = {};

  Future<LatLng> _getLatLng(UserPlace userPlace) async {
    ConvertLatLong data = ConvertLatLong(data: userPlace);
    LatLng result;
    try {
      result = await data.getLatLng();
    } catch (e) {
      result = null;
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    final Map args = ModalRoute.of(context).settings.arguments as Map;
    LatLng position = LatLng(args['userLocation'].lat, args['userLocation'].long);
    final CameraPosition _user = CameraPosition(
      target: position,
      zoom: 20,
      tilt: 0,
      bearing: 30,
    );
    setState(() {
      _markers.add(Marker(
          markerId: MarkerId(position.toString()),
          position: position,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure)
      ));
    });


    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_alarm),
        onPressed: () async {
          final result =
              await Navigator.pushNamed(context, PlaceInputScreen.id);
          if (result != null) {
            setState(() {
              _userPlace = result;
              _getLatLng(_userPlace).then((data) {
                _markers.add(Marker(
                  markerId: MarkerId(data.toString()),
                  position: data,
                  icon: BitmapDescriptor.defaultMarker
                ));
              });
            });
          }
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
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: _user,
                  markers: _markers,
                ),
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
                    child: this._userPlace?.estTime == null
                        ? EmptyTile()
                        : EstTile(
                            userPlace: this._userPlace,
                          ),
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
          setState(() {
            _currentIndex = index;
          });
//          print(args['userLocation'].lat);
//          print(args['userLocation'].long);
          if (index == 2 && _userPlace != null) {
            try {
              final UserPlace result =
                  await EstimateTime(userData: this._userPlace).getEstimate();

              setState(() {
                this._userPlace = result;
              });
            } catch (e) {
              print(e);
            }
          }
        },
      ),
    );
  }
}
