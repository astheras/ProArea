import 'package:ProArea/store/store-main.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DailyForecast extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<dynamic> day = store.weather["forecast"]["forecastday"];
    return GridView.count(
      crossAxisCount: 2,
      children: List.generate(
        day.length,
        (index) {
          final f = new DateFormat('hh');
          int curHour = int.parse(f.format(new DateTime.now()));
          var hour = day[index]["hour"][curHour];

          //print(formatter.format(now));
          //return SizedBox.shrink();
          return GestureDetector(
            onTap: () {
              store.selectedDayIndex = index;
              store.selectedDayIndex = index;
            },
            child: Card(
              elevation: 5,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    colors: [
                      Colors.black,
                      Colors.grey,
                    ],
                    stops: [0.1, 0.8],
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      hour["time"]
                          .toString()
                          .substring(0, hour["time"].toString().indexOf(' ')),
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                          hour["condition"]["icon"].replaceAll("//", "http://"),
                        ),
                        Column(
                          children: [
                            Text(hour["temp_c"].toString() + " C"),
                            Text(hour["temp_f"].toString() + " F"),
                          ],
                        )
                      ],
                    ),
                    Text(
                      hour["condition"]["text"].toString(),
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Card(
                      elevation: 8,
                      child: Container(
                        color: Colors.black.withOpacity(0.4),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Wind"),
                                Text(
                                  hour["wind_kph"].toString() + " kph",
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
                                  hour["feelslike_c"].toString() + " C",
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
                                  hour["chance_of_rain"].toString() + " %",
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
                                  hour["chance_of_snow"].toString() + " %",
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
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
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
