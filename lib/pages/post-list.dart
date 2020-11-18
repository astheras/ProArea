import 'package:flutter/material.dart';
import 'package:mainx/store/store-main.dart';

class PostList extends StatefulWidget {
  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView.builder(
          padding: EdgeInsets.all(8),
          itemCount: store.postList.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              elevation: 5,
              child: Column(
                children: <Widget>[
                  ListTile(
                    //trailing: Icon(Icons.supervised_user_circle),
                    title: Text(store.postList[index]['title']),
                    onTap: () {
                      Map params = {
                        "userId": store.postList[index]['userId'],
                      };
                      Navigator.pushNamed(
                        context,
                        '/detail',
                        arguments: params,
                      );
                    },
                    subtitle: Text(store.postList[index]['body']),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
