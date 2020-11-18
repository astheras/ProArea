import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mainx/utils/requests.dart';

class PostDetail extends StatefulWidget {
  @override
  _PostDetailState createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;

    return FutureBuilder(
      future: fetchGetAsync(
        'https://jsonplaceholder.typicode.com/users/${arguments["userId"]}',
      ),
      builder: (context, snap) {
        if (!snap.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        Map data = jsonDecode(snap.data);
        return Padding(
          padding: EdgeInsets.all(10),
          child: Card(
            child: Column(
              Text(
                data["name"].toString(),
              ),
            ),
          ),
        );
/*
        Card(
          child: Column(
            Text(
              data["name"],
            ),
          ),
        );*/
      },
    );
  }
}
