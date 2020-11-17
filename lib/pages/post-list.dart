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
      appBar: AppBar(
        title: Text('NBA Teams'),
      ),
      body: Container(
        child: ListView.builder(
          padding: EdgeInsets.all(8),
          itemCount: postListStore.postList.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text(postListStore.postList[index]['title']),
                    onTap: () => {
                      /*setState(() {
                        _selectedTeamID = index;
                      })*/
                    },
                    subtitle: Text(postListStore.postList[index]['body']),
                    //trailing: Text(_age(snapshot.data[index])),
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
