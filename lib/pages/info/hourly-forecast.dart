import 'package:ProArea/store/store-main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HourlyForecast extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<dynamic> hour = store.weather["forecast"]["forecastday"]
        [store.selectedDayIndex]["hour"];
    return StaggeredGridView.count(
      crossAxisCount: 4,
      padding: const EdgeInsets.all(2.0),
      staggeredTiles:
          hour.map<StaggeredTile>((_) => StaggeredTile.fit(2)).toList(),
      mainAxisSpacing: 3.0,
      crossAxisSpacing: 4.0, // add some space
      children: List.generate(
        24,
        (index) {
          return Card(
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        hour[index]["time"]
                            .substring(hour[index]["time"].indexOf(' ') + 1),
                      ),
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
                    child: Container(
                      color: Colors.black.withOpacity(0.4),
                      child: Column(
                        children: [
                          _detailText(
                            "Wind",
                            hour[index]["wind_kph"].toString() + " kph",
                          ),
                          _detailText(
                            "Feels Like",
                            hour[index]["feelslike_c"].toString() + " C",
                          ),
                          _detailText(
                            "Chance Of Rain",
                            hour[index]["chance_of_rain"].toString() + " %",
                          ),
                          _detailText(
                            "Chance Of Snow",
                            hour[index]["chance_of_snow"].toString() + " %",
                          ),
                        ],
                      ),
                    ),
                  )
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
