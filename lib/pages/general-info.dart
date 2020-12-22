import 'package:ProArea/store/store-main.dart';
import 'package:flutter/material.dart';

class GeneraiWeatherInfo extends StatelessWidget {
  String _bgImage = "assets/images/" +
      (store.weather["current"]["is_day"] == 1 ? "day.jpg" : "night.jpg");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        //fit: StackFit.expand,
        children: <Widget>[
          /*new Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage(_bgImage),
                fit: BoxFit.cover,
              ),
            ),
          ),
          */
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
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
              _cityInfo(),
              _mainInfo(),
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Column(
                          children: [
                            TextField(
                              controller: store.weather[""],
                              decoration:
                                  InputDecoration(labelText: "Enter Location"),
                            ),
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

  Color _fontColor() {
    return store.weather["current"]["is_day"] == 1
        ? Colors.black
        : Colors.white;
  }

  _mainInfo() {
    Map current = store.weather["current"];
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              current["condition"]["icon"].replaceAll("//", "http://"),
            ),
            Column(
              children: [
                Text(current["temp_c"].toString() + " C"),
                Text(current["temp_f"].toString() + " F"),
              ],
            )
          ],
        ),
        Text(current["condition"]["text"].toString()),
        Padding(
          padding: EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text("Feels Like  ${current["feelslike_c"].toString()}  C"),
                  Text("Feels Like  ${current["feelslike_f"].toString()}  F"),
                ],
              ),
              Column(
                children: [
                  Text("Wind ${current["wind_kph"].toString()}  kph"),
                  Text("Wind Degree  ${current["wind_degree"].toString()} °"),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text("Feels Like  ${current["feelslike_c"].toString()}  C"),
                  Text("Feels Like  ${current["feelslike_f"].toString()}  F"),
                ],
              ),
              Column(
                children: [
                  Text("Barometer ${current["pressure_mb"].toString()}  mb"),
                  Text("Humidity  ${current["humidity"].toString()}  %"),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Cloud ${current["cloud"].toString()} %"),
              Text("Visibility ${current["vis_km"].toString()}  km"),
            ],
          ),
        ),
      ],
    );
  }

  _cityInfo() {
    Map location = store.weather["location"];

    return Container(
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage(_bgImage),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                Text(
                  "Country: ${location["country"]}",
                  style: TextStyle(
                    color: _fontColor(),
                  ),
                ),
                Text(
                  "City: ${location["name"]}",
                  style: TextStyle(
                    color: _fontColor(),
                  ),
                ),
                Text(
                  "Time: ${location["localtime"]}",
                  style: TextStyle(
                    color: _fontColor(),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
