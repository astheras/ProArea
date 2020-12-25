import 'package:ProArea/store/store-main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';

class DailyForecast extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<dynamic> day = store.weather["forecast"]["forecastday"];

    return StaggeredGridView.count(
      crossAxisCount: 4,
      padding: const EdgeInsets.all(2.0),
      staggeredTiles:
          day.map<StaggeredTile>((_) => StaggeredTile.fit(2)).toList(),
      mainAxisSpacing: 3.0,
      crossAxisSpacing: 4.0, // add some space
      children: List.generate(
        day.length,
        (index) {
          final f = new DateFormat('hh');
          int curHour = int.parse(f.format(new DateTime.now()));
          var hour = day[index]["hour"][curHour];

          return GestureDetector(
            onTap: () {
              store.selectedDayIndex = index;

              store.pageViewController.animateToPage(
                2,
                curve: Curves.easeIn,
                duration: Duration(milliseconds: 300),
              );
            },
            child: Card(
              elevation: 5,
              child: Stack(
                children: [
                  Container(
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
                  ),
                  Column(
                    children: [
                      Text(
                        hour["time"]
                            .toString()
                            .substring(0, hour["time"].toString().indexOf(' ')),
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(
                            hour["condition"]["icon"]
                                .replaceAll("//", "http://"),
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
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Card(
                        elevation: 8,
                        child: Container(
                          color: Colors.black.withOpacity(0.4),
                          child: Column(
                            children: [
                              _detailText(
                                "Wind",
                                hour["wind_kph"].toString() + " kph",
                              ),
                              _detailText(
                                "Feels Like",
                                hour["feelslike_c"].toString() + " C",
                              ),
                              _detailText(
                                "Chance Of Rain",
                                hour["chance_of_rain"].toString() + " %",
                              ),
                              _detailText(
                                "Chance Of Snow",
                                hour["chance_of_snow"].toString() + " %",
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _detailText(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        Text(
          value,
          style: TextStyle(
            color: Colors.blue[200],
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
