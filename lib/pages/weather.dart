import 'package:ProArea/utils/requests.dart';

Future<Map> getWeatherByCityName(String cityName) async {
  return await fetchGet(
    'http://api.weatherapi.com/v1/forecast.json?key=701c9041891b4773ab6105328202212&q=$cityName&days=1',
  );
}
