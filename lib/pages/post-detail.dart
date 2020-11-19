import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mainx/utils/requests.dart';

class PostDetail extends StatefulWidget {
  @override
  _PostDetailState createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  int _currentIndex = 0;
  Map _data;
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
        _data = jsonDecode(snap.data);
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.all(15),
            child: Card(
              elevation: 5,
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    colors: [Colors.blue[200], Colors.red],
                    stops: [0.0, 0.7],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.portrait),
                      title: Text(_data["name"]),
                      subtitle: Text(_data["username"]),
                    ),
                    Card(
                      elevation: 5,
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: _info(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            // onTap: onTabTapped, // new
            currentIndex: _currentIndex, // new
            onTap: onTabTapped,
            items: [
              new BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              new BottomNavigationBarItem(
                icon: Icon(Icons.apartment),
                label: 'Address',
              ),
              new BottomNavigationBarItem(
                icon: Icon(Icons.precision_manufacturing_outlined),
                label: 'Company',
              )
            ],
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

  // render info tab
  _info() {
    List<Widget> render;
    if (_currentIndex == 0) {
      render = _home();
    } else if (_currentIndex == 1) {
      render = _address();
    }

    return Padding(
      padding: EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: render,
      ),
    );
  }

  _home() {
    return [
      Text("email:  ${_data["email"]}"),
      Text("phone:  ${_data["phone"]}"),
      Text("website:  ${_data["website"]}"),
    ];
  }

  _address() {
    Map address = _data["address"];
    return [
      Text("city:  ${address["city"]}"),
      Text("street:  ${address["street"]}"),
      Text("suite:  ${address["suite"]}"),
      Text("zipcode:  ${address["zipcode"]}"),
      Text("geo:  ${address["geo"]["lat"]}; ${address["geo"]["lng"]}"),
    ];
  }

  // selected tab
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
