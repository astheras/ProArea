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
            childAspectRatio: 1,
            scrollDirection: Axis.vertical,
            crossAxisCount: 2,
            children: [
              ListView(
                children: [
                  _card("Max Temperature", day["maxtemp_c"].toString() + " C"),
                  _card("Min Temperature", day["mintemp_c"].toString() + " C"),
                  _card("Max Wind", day["maxwind_kph"].toString() + " kph"),
                  _card("Chance Of Snow",
                      day["daily_chance_of_snow"].toString() + " %"),
                ],
              ),
              // second part of GridView
              ListView(
                children: [
                  _card("Max Temperature", day["maxtemp_f"].toString() + " F"),
                  _card("Min Temperature", day["mintemp_f"].toString() + " F"),
                  _card("Avg humidity", day["avghumidity"].toString() + " %"),
                  _card("Chance of rain",
                      day["daily_chance_of_rain"].toString() + " %"),
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
                  _card("Sunrise", astro["sunrise"].toString()),
                  _card("Moonrise", astro["moonrise"].toString()),
                  _card("Moon Phase", astro["moon_phase"].toString()),
                ],
              ),
              // second part of GridView
              ListView(
                children: [
                  _card("Sunset", astro["sunset"].toString()),
                  _card("Moonset", astro["moonset"].toString()),
                  _card("Moon Illumination",
                      astro["moon_illumination"].toString()),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  _card(String label, String text) {
    return Card(
      elevation: 5,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            colors: [
              Colors.black,
              Colors.grey,
            ],
            stops: [0.1, 0.7],
          ),
        ),
        child: Column(
          children: [
            Text(label),
            Text(
              text,
              style: TextStyle(
                color: Colors.blue[200],
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
