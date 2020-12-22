import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pages/city-selector.dart';
import 'pages/general-info.dart';
import 'pages/splash-page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      title: 'ProArea Demo',
      initialRoute: '/',
      routes: _routes(),
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.lightBlue,
        accentColor: Colors.cyan[600],
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }

  // create routes list
  _routes() {
    return {
      '/': (context) => SplashScreenPage(),
      '/cityselector': (context) => CitySelector(),
      '/generalinfo': (context) => GeneraiWeatherInfo(),
      //  '/detail': (context) => PostDetailPage(),
    };
  }
}
