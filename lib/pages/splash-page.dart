import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mainx/store/store-main.dart';
import 'package:mainx/utils/requests.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPage createState() => _SplashPage();
}

class _SplashPage extends State<SplashPage> {
  @override
  void initState() {
    fetchGetAsync('https://jsonplaceholder.typicode.com/posts')
        .then((response) {
      postListStore.postList = jsonDecode(response);
      Navigator.pushNamed(context, '/postlist');
    }).catchError((error) {
      print(error);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildPostList();
  }

  Scaffold _buildPostList() {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
