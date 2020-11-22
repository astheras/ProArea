import 'package:flutter/material.dart';
import 'package:mainx/store/store-main.dart';

class PostListPage extends StatefulWidget {
  @override
  _PostListPageState createState() => _PostListPageState();
}

class _PostListPageState extends State<PostListPage> {
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
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          /*store.postList.removeWhere((item) {
            return item["id"] == 1;
          });*/

          var postList = snap.data;
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
        },
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
