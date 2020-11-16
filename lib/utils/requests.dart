import 'dart:convert';
import 'package:http/http.dart' as http;

Future<dynamic> fetchGet(String url) async {
  // данные
  final response = await http.get(url);
  return json.decode(response.body);
}

fetchGetAsync(String url) {
  http.get(url).then((response) {
    //_status = response.statusCode;
    //_body = response.body;

    // setState(() {});//перестраиваем виджет окна для отображения изменений _status и _body
  }).catchError((error) {
    // _status = 0;
    //_body = error.toString();

    //setState(() {});//перестраиваем виджет окна в случае сетевой ошибки
  });
}
