import 'package:flutter/material.dart';

import 'pages/post-detail.dart';
import 'pages/post-list.dart';
import 'pages/splash-page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MainX Demo',
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
      // When navigating to the "/" route, build the FirstScreen widget.
      '/': (context) => SplashPage(),
      '/postlist': (context) => PostList(),
      '/detail': (context) => PostDetail(),
    };
  }
}
