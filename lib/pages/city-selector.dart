import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

class CitySelector extends StatefulWidget {
  @override
  _CitySelectorState createState() => _CitySelectorState();
}

class _CitySelectorState extends State<CitySelector> {
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position _currentPosition;
  Placemark _currentPlace;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                colors: [
                  Colors.black,
                  Colors.pinkAccent[400],
                  Colors.deepPurple,
                ],
                stops: [0.0, 0.7, 0.7],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Column(
                          children: [
                            new Row(
                              children: <Widget>[
                                Flexible(
                                  child: TextField(
                                    // focusNode: widget.focus,
                                    // controller: controller,
                                    // style: TextStyle(color: AppColors.mainFontColor),
                                    decoration: InputDecoration(
                                      labelText: _currentPlace == null
                                          ? ""
                                          : _currentPlace.locality,
/*                                      labelStyle: new TextStyle(color: Colors.mainFontColor),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.mainFontColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.mainFontColor),
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.mainFontColor),
                    ),*/
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "https://proarea.co/",
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  _getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);
      Placemark place = p[0];
      setState(() {
        print(place);
        _currentPlace = place;
      });
    } catch (e) {
      print(e);
    }
  }
}
