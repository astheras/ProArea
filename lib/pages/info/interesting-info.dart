import 'package:ProArea/store/store-main.dart';
import 'package:flutter/material.dart';

class InterestingInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map day = store.weather["forecast"]["forecastday"][0]["day"];
    Map astro = store.weather["forecast"]["forecastday"][0]["astro"];
    return Container(
      child: ListView(
        shrinkWrap: true,
        children: [
          Text(
            "This day",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
          ),
          GridView.count(
            shrinkWrap: true,
            //childAspectRatio: 6,
            scrollDirection: Axis.vertical,
            crossAxisCount: 2,
            children: [
              ListView(
                children: [
                  Card(
                    elevation: 5,
                    child: Column(
                      children: [
                        Text("Max temperature"),
                        Text(day["maxtemp_c"].toString() + " C"),
                      ],
                    ),
                  ),
                  Card(
                    elevation: 5,
                    child: Column(
                      children: [
                        Text("Min temperature"),
                        Text(day["mintemp_c"].toString() + " C"),
                      ],
                    ),
                  ),
                  Card(
                    elevation: 5,
                    child: Column(
                      children: [
                        Text("Max wind"),
                        Text(day["maxwind_kph"].toString() + " kph"),
                      ],
                    ),
                  ),
                  Card(
                    elevation: 5,
                    child: Column(
                      children: [
                        Text("Chance of snow"),
                        Text(day["daily_chance_of_snow"].toString() + " %"),
                      ],
                    ),
                  ),
                ],
              ),
              // second part of GridView
              ListView(
                children: [
                  Card(
                    elevation: 5,
                    child: Column(
                      children: [
                        Text("Max temperature"),
                        Text(day["maxtemp_f"].toString() + " F"),
                      ],
                    ),
                  ),
                  Card(
                    elevation: 5,
                    child: Column(
                      children: [
                        Text("Min temperature"),
                        Text(day["mintemp_f"].toString() + " F"),
                      ],
                    ),
                  ),
                  Card(
                    elevation: 5,
                    child: Column(
                      children: [
                        Text("Avg humidity"),
                        Text(day["avghumidity"].toString() + " %"),
                      ],
                    ),
                  ),
                  Card(
                    elevation: 5,
                    child: Column(
                      children: [
                        Text("Chance of rain"),
                        Text(day["daily_chance_of_rain"].toString() + " %"),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
          Text(
            "Astro",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
          ),
          GridView.count(
            shrinkWrap: true,
            //childAspectRatio: 6,
            scrollDirection: Axis.vertical,
            crossAxisCount: 2,
            children: [
              ListView(
                children: [
                  Card(
                    elevation: 5,
                    child: Column(
                      children: [
                        Text("Sunrise"),
                        Text(astro["sunrise"].toString()),
                      ],
                    ),
                  ),
                  Card(
                    elevation: 5,
                    child: Column(
                      children: [
                        Text("Moonrise"),
                        Text(astro["moonrise"].toString()),
                      ],
                    ),
                  ),
                  Card(
                    elevation: 5,
                    child: Column(
                      children: [
                        Text("Moon Phase"),
                        Text(astro["moon_phase"].toString()),
                      ],
                    ),
                  ),
                ],
              ),
              // second part of GridView
              ListView(
                children: [
                  Card(
                    elevation: 5,
                    child: Column(
                      children: [
                        Text("Sunset"),
                        Text(astro["sunset"].toString()),
                      ],
                    ),
                  ),
                  Card(
                    elevation: 5,
                    child: Column(
                      children: [
                        Text("Moonset"),
                        Text(astro["moonset"].toString()),
                      ],
                    ),
                  ),
                  Card(
                    elevation: 5,
                    child: Column(
                      children: [
                        Text("Moon Illumination"),
                        Text(astro["moon_illumination"].toString()),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
