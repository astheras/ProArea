import 'package:flutter/material.dart';

class PostDetailPage extends StatefulWidget {
  @override
  _PostDetailPageState createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  int _currentIndex = 0;
  Map _data;
  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;

    return SizedBox.shrink();
    /*FutureBuilder(
      future: store.userDetail(arguments["userId"], this),
      /*future: fetchGetAsync(
        'https://jsonplaceholder.typicode.com/users/${arguments["userId"]}',
      ),*/
      //future: _getUserDetail(),
      builder: (context, snap) {
        if (!snap.hasData) {
          return _render(null, true);
        }
        if (store.firstUserRender && store.hasUserCachedData) {
          // aftre first render, try to refresh data
          print("refreshing list data from web");
          store.firstUserRender = false;
          Timer(
            Duration(seconds: 5),
            () {
              if (mounted) {
                setState(() {
                  print('refreshing user detail from inet...');
                  store.userDetail(arguments["userId"], this, true);
                });
              }
            },
          );
        }
        store.firstUserRender = false;

        _data = snap.data["data"];
        return _render(_data, false);
      },
    );*/
  }

  // render detail
  _render(Map data, bool loading) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Container(
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
                  colors: [Colors.blueGrey, Colors.red],
                  stops: [0.0, 0.7],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.portrait),
                    title: loading ? SizedBox.shrink() : Text(_data["name"]),
                    subtitle:
                        loading ? SizedBox.shrink() : Text(_data["username"]),
                    trailing: loading
                        ? CircularProgressIndicator()
                        : SizedBox.shrink(),
                  ),
                  Expanded(
                    child: Container(
                      child: Card(
                        elevation: 5,
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: loading ? SizedBox.shrink() : _info(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: loading
          ? null
          : BottomNavigationBar(
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
  }

  // render info tab
  _info() {
    List<Widget> children;
    if (_currentIndex == 0) {
      children = _home();
    } else if (_currentIndex == 1) {
      children = _address();
    } else if (_currentIndex == 2) {
      children = _company();
    }
    return ListView(
      padding: const EdgeInsets.all(8),
      children: children,
    );
  }

  _home() {
    return [
      ListTile(
        trailing: Icon(Icons.mail),
        title: Text('email'),
        subtitle: Text(_data["email"]),
      ),
      ListTile(
        trailing: Icon(Icons.phone),
        title: Text('phone'),
        subtitle: Text(_data["phone"]),
      ),
      ListTile(
        trailing: Icon(Icons.web_asset_sharp),
        title: Text('website'),
        subtitle: Text(_data["website"]),
      ),
    ];
  }

  _company() {
    Map company = _data["company"];

    return [
      ListTile(
        trailing: Icon(Icons.title_outlined),
        title: Text('name'),
        subtitle: Text(company["name"]),
      ),
      ListTile(
        trailing: Icon(Icons.recommend),
        title: Text('catchPhrase'),
        subtitle: Text(company["catchPhrase"]),
      ),
      ListTile(
        trailing: Icon(Icons.attach_money),
        title: Text('bs'),
        subtitle: Text(company["bs"]),
      ),
    ];
  }

  _address() {
    Map address = _data["address"];

    return [
      ListTile(
        trailing: Icon(Icons.location_city),
        title: Text('city'),
        subtitle: Text(address["city"]),
      ),
      ListTile(
        trailing: Icon(Icons.streetview_outlined),
        title: Text('street'),
        subtitle: Text(address["street"]),
      ),
      ListTile(
        trailing: Icon(Icons.apartment),
        title: Text('suite'),
        subtitle: Text(address["suite"]),
      ),
      ListTile(
        trailing: Icon(Icons.confirmation_number_outlined),
        title: Text('zipcode'),
        subtitle: Text(address["zipcode"]),
      ),
      ListTile(
        trailing: Icon(Icons.gps_fixed),
        title: Text('geo'),
        subtitle: Text("${address["geo"]["lat"]}; ${address["geo"]["lng"]}"),
      ),
    ];
  }

  // selected tab
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
