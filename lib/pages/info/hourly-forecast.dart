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

          final DateTime now = DateTime. now();
          final DateFormat formatter = DateFormat('yyyy-MM-dd');

          return Card(
            elevation: 5,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(hour[index]["time"].replaceAll(,"")),
                    Image.network(
                      hour[index]["condition"]["icon"]
                          .replaceAll("//", "http://"),
                    ),
                  ],
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
