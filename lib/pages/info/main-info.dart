import 'dart:ui';

import 'package:ProArea/components/dot-group.dart';
import 'package:ProArea/store/store-main.dart';
import 'package:flutter/material.dart';

import 'daily-forecast.dart';
import 'hourly-forecast.dart';
import 'interesting-info.dart';

class GeneraiWeatherInfo extends StatefulWidget {
  @override
  _GeneraiWeatherInfoState createState() => _GeneraiWeatherInfoState();
}

class _GeneraiWeatherInfoState extends State<GeneraiWeatherInfo> {
  final pageViewController = PageController(
    initialPage: 0,
  );

  String _bgImage = "assets/images/" +
      (store.weather["current"]["is_day"] == 1 ? "day.jpg" : "night.jpg");

  @override
  void initState() {
    super.initState();
    store.selectedDayIndex = 0;
    store.selectedPageIndex = 0;
    pageViewController.addListener(() {
      setState(() {
        store.selectedPageIndex = pageViewController.page.toInt();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        //fit: StackFit.expand,
        children: <Widget>[
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
              _indicators(),
              Text(
                _bottomHeader(),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Expanded(
                flex: 1,
                child: PageView(
                  controller: pageViewController,
                  children: [
                    InterestingInfo(),
                    DailyForecast(),
                    HourlyForecast(),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  _indicators() {
    return DotGroup(
      dotCount: 3,
      activeDotIndex: store.selectedPageIndex,
      selectedColor: Colors.blue[200],
      color: Colors.white,
    );
  }

  String _bottomHeader() {
    if (store.selectedPageIndex == 0) {
      return "Interesting Info";
    } else if (store.selectedPageIndex == 1) {
      return "Daily Forecast";
    } else if (store.selectedPageIndex == 2) {
      String date = store.weather["forecast"]["forecastday"]
          [store.selectedDayIndex]["date"];
      return "Hourly Forecast $date";
    }
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
        Text(
          current["condition"]["text"].toString(),
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 2.0,
          padding: const EdgeInsets.all(8.0),
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
          shrinkWrap: true,
          children: [
            ListView(
              shrinkWrap: true,
              children: [
                Card(
                  color: Colors.transparent,
                  elevation: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Feels Like ${current["feelslike_c"].toString()} C"),
                      Text("Feels Like ${current["feelslike_f"].toString()} F"),
                    ],
                  ),
                ),
                Card(
                  color: Colors.transparent,
                  elevation: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          "Barometer ${current["pressure_mb"].toString()}  mb"),
                      Text("Cloud ${current["cloud"].toString()} %"),
                    ],
                  ),
                ),
              ],
            ),
            // second part of GridView
            ListView(
              shrinkWrap: true,
              children: [
                Card(
                  color: Colors.transparent,
                  elevation: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Wind ${current["wind_kph"].toString()} kph"),
                      Text(
                          "Wind Degree ${current["wind_degree"].toString()} °"),
                    ],
                  ),
                ),
                Card(
                  color: Colors.transparent,
                  elevation: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Humidity ${current["humidity"].toString()} %"),
                      Text("Visibility ${current["vis_km"].toString()}  km"),
                    ],
                  ),
                ),
              ],
            )
          ],
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
