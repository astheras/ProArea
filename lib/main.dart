import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'store/store-main.dart';
import 'utils/sqlite.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  Widget build(BuildContext context) {
    _init();

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

  // init main data
  _init() async {
    await _prepareDatabase();
    await store.postList();
  }

  // copying original db into user folder
  _prepareDatabase() async {
    print("checking  db file...");
    Directory directory = await getExternalStorageDirectory();
    var dbName = directory.path + '/data.db';

    if (await File(dbName).exists()) {
      print("file data.db exists. No action needed");
    } else {
      print('copying original db into user folder...');
      ByteData data = await rootBundle.load('assets/cont.db');
      final buffer = data.buffer;
      await new File(dbName).writeAsBytes(
          buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
      print('     done.');
    }
    await SQL.initDB();
  }

  // create routes list
  _routes() {
    return store.routes;
  }
}
