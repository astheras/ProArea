import 'package:flutter/material.dart';

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
      '/postlist': (context) => PostListPage(),
      //  '/list': (context) => MyHomePage(page: "list"),
      //  '/detail': (context) => MyHomePage(page: "detail"),
    };
  }
}
