import 'dart:io';

import 'package:ProArea/store/store-main.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HourlyForecast extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<dynamic> hour = store.weather["forecast"]["forecastday"][0]["hour"];
    return GridView.count(
      crossAxisCount: 2,
      children: List.generate(
        24,
        (index) {
          final DateFormat formatter = DateFormat('yyyy-MM-dd');
          String now = formatter.format(DateTime.now());

          //print(formatter.format(now));
          return Card(
            elevation: 5,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(hour[index]["time"].replaceAll(now, "")),
                    Image.network(
                      hour[index]["condition"]["icon"]
                          .replaceAll("//", "http://"),
                    ),
                    Column(
                      children: [
                        Text(hour[index]["temp_c"].toString() + " C"),
                        Text(hour[index]["temp_f"].toString() + " F"),
                      ],
                    )
                  ],
                ),
                Text(
                  hour[index]["condition"]["text"].toString(),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Card(
                  elevation: 8,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Wind"),
                          Text(
                            hour[index]["wind_kph"].toString() + " kph",
                            style: TextStyle(
                              color: Colors.blue[200],
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Feels Like "),
                          Text(
                            hour[index]["feelslike_c"].toString() + " C",
                            style: TextStyle(
                              color: Colors.blue[200],
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Chance Of Rain"),
                          Text(
                            hour[index]["chance_of_rain"].toString() + " %",
                            style: TextStyle(
                              color: Colors.blue[200],
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Chance Of Snow "),
                          Text(
                            hour[index]["chance_of_snow"].toString() + " %",
                            style: TextStyle(
                              color: Colors.blue[200],
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
          /*Center(
          child: Text(
            'Item $index',
            style: Theme.of(context).textTheme.headline5,
          ),
          */
        },
      ),
    );
    /*return Container(
      child: ListView.builder(
        primary: false,
        shrinkWrap: true,
        padding: EdgeInsets.all(8),
        itemCount: hour.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            elevation: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Text(index.toString()),
                    Image.network(
                      hour[index]["condition"]["icon"]
                          .replaceAll("//", "http://"),
                    ),
                    Text(hour[index]["condition"]["text"].toString()),
                  ],
                ),
                Text("temp_c"),
                Text(hour[index]["temp_c"].toString() + " C"),
              ],
            ),
          );
        },
      ),
    );*/
  }
}
