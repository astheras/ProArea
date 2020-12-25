import 'package:ProArea/components/main-button.dart';
import 'package:ProArea/store/store-main.dart';
import 'package:ProArea/utils/requests.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

class CitySelector extends StatefulWidget {
  @override
  _CitySelectorState createState() => _CitySelectorState();
}

class _CitySelectorState extends State<CitySelector> {
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  TextEditingController controller;

  int _loading = -1;
  String errorMessage;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
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
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _loadingIndicator(),
                      Container(
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(5),
                              child: TextField(
                                controller: controller,
                                decoration: InputDecoration(
                                  labelText: "Enter Location",
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  MainButton(
                                    icon: Icon(Icons.location_on),
                                    onTap: () {
                                      setState(() {
                                        _getCurrentLocation();
                                      });
                                    },
                                  ),
                                  SizedBox(width: 15.0),
                                  MainButton(
                                    icon: Icon(Icons.search),
                                    onTap: () {
                                      setState(() {
                                        _getLocationData();
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  _loadingIndicator() {
    if (_loading == -1) {
      return SizedBox.shrink();
    } else if (_loading == 0) {
      return Text('Detecting your location...');
    } else if (_loading == 1) {
      return Text(errorMessage);
    } else if (_loading == 2) {
      return Text('Loading...');
    }
  }

  _getLocationData() async {
    Map response = await getWeatherByCityName(
      controller.text,
    );
    if (!response['result'] || response["data"]["error"] != null) {
      String message = response["data"]["error"]["message"] == null
          ? response['message']
          : response["data"]["error"]["message"];
      _dialogBox(
        'Oooops!',
        message,
        [
          FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Ok"),
          ),
        ],
      );
    } else {
      store.weather = response["data"];
      Navigator.pushNamed(
        context,
        '/generalinfo',
      );
    }
  }

  // modal dialog box
  _dialogBox(String title, String message, List<Widget> buttons) {
    showDialog(
      context: context,
      //child: dialogBox(title, message, buttons),
      builder: (_) => new AlertDialog(
        title: new Text(title),
        content: new Text(message),
        actions: buttons,
      ),
    );
  }

  // getting current geo
  _getCurrentLocation() async {
    _loading = 0;
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) async {
      await _getAddressFromLatLng(position);
    }).catchError((e) {
      setState(() {
        _loading = 1;
        errorMessage = e.toString();
      });
    });
  }

  // convert geo into city data
  _getAddressFromLatLng(Position position) async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          position.latitude, position.longitude);
      Placemark geo = p[0];
      setState(() {
        store.geo = geo;
        controller.text = store.geo.locality;
        _loading = -1;
      });
    } catch (e) {
      setState(() {
        _loading = 1;
        errorMessage = e.toString();
      });
    }
  }
}
