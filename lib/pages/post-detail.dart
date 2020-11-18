import 'package:flutter/material.dart';

class PostDetail extends StatefulWidget {
  @override
  _PostDetailState createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;

    return
        //Text(arguments['id'].toString()),
        //Text(arguments['userId'].toString()),
        FutureBuilder(
      builder: (context, projectSnap) {
        if (!projectSnap.hasData) {
          return CircularProgressIndicator();
        }
        return Stack(
          children: [
            Card(),
            ListView.builder(
              itemCount: projectSnap.data.length,
              itemBuilder: (context, index) {
                return Column(
                  children: <Widget>[
                    // Widget to display the list of project
                  ],
                );
              },
            ),
          ],
        );
      },
    );
  }
}
