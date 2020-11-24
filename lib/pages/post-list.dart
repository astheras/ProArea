import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mainx/store/store-main.dart';

class PostListPage extends StatefulWidget {
  @override
  _PostListPageState createState() => _PostListPageState();
}

class _PostListPageState extends State<PostListPage> {
  bool _firstRender = true;
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: store.postList(),
        builder: (context, snap) {
          if (!snap.hasData) {
            return Column(
              children: [
                Spacer(),
                CircularProgressIndicator(),
                Center(
                  child: Text("Loading..."),
                ),
                Spacer(),
              ],
            );
          }

          if (_firstRender && store.hasCachedData) {
            // aftre first render, try to refresh data
            print("refreshing list data from web");
            _firstRender = false;
            Timer(
              Duration(seconds: 4),
              () => setState(() {
                store.postList(true);
              }),
            );
          }
          _firstRender = false;
          if (!snap.data["result"]) {
            return _renderError(snap.data["message"]);
          } else {
            return _renderList(snap.data["data"]);
          }
        },
      ),
    );
  }

  _renderError(message) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Colors.black,
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
                    Text(
                      message,
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        setState(() {
                          store.postList(true);
                        });
                      },
                      child: Icon(Icons.refresh),
                    )
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  _renderList(postList) {
    return Container(
      child: RefreshIndicator(
        child: ListView.builder(
          padding: EdgeInsets.all(8),
          itemCount: postList.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              elevation: 5,
              child: Column(
                children: <Widget>[
                  ListTile(
                    //trailing: Icon(Icons.supervised_user_circle),
                    title: Text(postList[index]['title']),
                    onTap: () {
                      Map params = {
                        "userId": postList[index]['userId'],
                      };
                      Navigator.pushNamed(
                        context,
                        '/detail',
                        arguments: params,
                      );
                    },
                    subtitle: Text(postList[index]['body']),
                  )
                ],
              ),
            );
          },
        ),
        onRefresh: _refreshData,
      ),
    );
  }

  //pull to refresh
  Future<void> _refreshData() async {
    setState(() {
      store.postList(true);
    });
  }
}
