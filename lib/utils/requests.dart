import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map> fetchGet(String url) async {
  // данные
  var response;
  try {
    response = await http.get(url);
  } catch (error) {
    String message;
    if (error.osError.errorCode == 7)
      message = "check your internet connection";
    else
      message = error.message;
    return {
      "result": false,
      "message": message,
    };
  }

  Map result = {
    "result": true,
    "data": json.decode(response.body),
  };

  return result;
}

Future<Map> getWeatherByCityName(String cityName) async {
  return await fetchGet(
    'http://api.weatherapi.com/v1/forecast.json?key=701c9041891b4773ab6105328202212&q=$cityName&days=8',
  );
}
