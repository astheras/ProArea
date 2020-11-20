import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mainx/store/store-main.dart';
import 'package:mainx/utils/requests.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPage createState() => _SplashScreenPage();
}

class _SplashScreenPage extends State<SplashScreenPage> {
  @override
  void initState() {
    fetchGetAsync('https://jsonplaceholder.typicode.com/posts')
        .then((response) {
      store.postList = jsonDecode(response);
    }).catchError((error) {
      print(error);
    });
    super.initState();
    Timer(
        Duration(seconds: 4),
        () => Navigator.pushNamedAndRemoveUntil(
            context, "/postlist", (r) => false));
  }

  @override
  Widget build(BuildContext context) {
    return _buildPostList();
  }

  Scaffold _buildPostList() {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.blueGrey,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        "assets/images/logo.jpg",
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),
                      Text(
                        "Computer Software",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0,
                        ),
                      ),
                      Text(
                        "Unity and Flutter develop agency",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    ),
                    Text(
                      "http://mainx.dev",
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
