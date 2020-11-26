import 'package:mainx/pages/post-detail.dart';
import 'package:mainx/pages/post-list.dart';
import 'package:mainx/pages/splash-page.dart';
import 'package:mainx/utils/requests.dart';
import 'package:mainx/utils/sqlite.dart';
import 'package:rxdart/rxdart.dart';

class _Store {
  bool _postListDataLoading = false;
  bool _hasCachedData = false;
  bool _hasUserCachedData = false;
  bool _firstUserRender = true;

  BehaviorSubject _posts = BehaviorSubject.seeded(null);
  BehaviorSubject _userDetail = BehaviorSubject.seeded(null);
  BehaviorSubject _userDetailUpdating = BehaviorSubject.seeded(false);
  //Map<List> posts;

  //Stream get stream$ => _posts.stream;

  var routes = {
    '/': (context) => SplashScreenPage(),
    '/postlist': (context) => PostListPage(),
    '/detail': (context) => PostDetailPage(),
  };

  get userDetailUpdateting {
    return _userDetailUpdating.value;
  }

  set userDetailUpdating(bool value) {
    return _userDetailUpdating.add(value);
  }

  Future<bool> dataLoaded() async {
    return await _posts.value != null;
  }

  Future<Map> postList([bool refresh = false]) async {
    print('geting list...');
    if ((!_postListDataLoading && _posts.value == null) || refresh) {
      _postListDataLoading = true;
      bool isExists = await _isListExists();
      if (isExists) {
        _hasCachedData = true;
        print('   from cache');
        var response = await SQL.execute("select * from posts");
        _postListDataLoading = false;
        _posts.add(response);
      } else {
        _hasCachedData = false;
        print('   from inet');
        var response =
            await fetchGet('https://jsonplaceholder.typicode.com/posts');
        _savePostList(response);

        _postListDataLoading = false;
        _posts.add(response);
      }
    } else {
      print('   current value');
    }

    return await _posts.value;
  }

  Future<bool> _isListExists() async {
    var response = await SQL.execute("select exists(select 1 from posts) ex");

    return await response["data"].first["ex"] == 1 ? true : false;
  }

  // save list into db
  _savePostList(data) async {
    if (data["result"]) {
      print('cashing post list...');
      String sql = "";
      // generate script
      for (var item in data["data"]) {
        String coma = sql == "" ? "" : ",";
        sql += coma +
            "(${item['id']}, ${item['userId']}, \"${item['title']}\", \"${item['body']}\")";
      }
      //execute insertion
      await SQL.execute(
        "replace into posts(id, userId, title, body) \n" + "values $sql",
      );
      print('   done');
    }

    //SQL.execute(sql)
  }

  get hasCachedData {
    return _hasCachedData;
  }

  Future<bool> _isUserExists(int id) async {
    var response = await SQL
        .execute("select exists(select 1 from v_users where id = $id) ex");

    return await response["data"].first["ex"] == 1 ? true : false;
  }

//save user data
  _saveUserDetail(Map data) async {
    print('saving user ${data["id"]}...');

    Map address = data["address"];
    //city.begin
    var response = await SQL.execute(
      "select id from cities where name = ? \n",
      [address["city"]],
    );

    if (response["data"].length == 0) {
      await SQL.execute(
        "insert into cities (name) \n values (?)  \n",
        [address["city"]],
      );

      response = await SQL.execute(
        "select id from cities where name = ? \n",
        [address["city"]],
      );
    }
    int cityId = response["data"][0]["id"] as int;
    //city.end
    //streets.begin
    response = await SQL.execute(
      "select id from streets where name = ? and cityId = ?\n",
      [address["street"], cityId],
    );

    if (response["data"].length == 0) {
      await SQL.execute(
        "insert into streets (name, cityId) \n values (?,?)  \n",
        [address["street"], cityId],
      );

      response = await SQL.execute(
        "select id from streets where name = ? \n",
        [address["street"]],
      );
    }
    int streetId = response["data"][0]["id"] as int;
    //streets.end
    //companies.begin
    Map companies = await data["company"];

    response = await SQL.execute(
      "select id from companies where name = ?\n",
      [companies["name"]],
    );

    if (response["data"].length == 0) {
      await SQL.execute(
        "insert into companies(name, catchPhrase, bs) \n" + "values (?,?,?)",
        [companies["name"], companies["catchPhrase"], companies["bs"]],
      );

      response = await SQL.execute(
        "select id from companies where name = ? \n",
        [companies["name"]],
      );
    } else {
      await SQL.execute(
        "update companies \n" +
            "set catchPhrase = ?, bs = ? \n" +
            "where name = ? \n",
        [companies["catchPhrase"], companies["bs"], companies["name"]],
      );
    }

    //execute companies

    response = await SQL.execute(
      "select id from companies \n where name = ?  \n",
      [companies["name"]],
    );

    int companyId = response["data"][0]["id"] as int;
    //companies.end

    await SQL.execute(
      "replace into users(id, name, username, email, streetId, address_suite, address_zipcode, address_geo_lat, address_geo_lng, phone, website, companyId ) \n" +
          "values (?,?,?,?,?,?,?,?,?,?,?,?)",
      [
        data["id"],
        data["name"],
        data["username"],
        data["email"],
        streetId,
        address["suite"],
        address["zipcode"],
        address["geo"]["lat"],
        address["geo"]["lng"],
        data["phone"],
        data["website"],
        companyId,
      ],
    );

    print('   done');
  }

  // post detail
  Future<Map> userDetail(int userId, var detail, [bool refresh = false]) async {
    if (_userDetail.value != null &&
        userId != _userDetail.value["data"]["id"]) {
      _userDetail.add(null);
      _hasUserCachedData = false;
      _firstUserRender = true;
    }
    print('geting user detail $userId...');
    if ((_userDetail.value == null) || refresh) {
      if (!refresh) {
        bool isExists = await _isUserExists(userId);
        if (isExists) {
          _hasUserCachedData = true;
          print('   from cache');
          var response =
              await SQL.execute("select * from v_users \n where id = $userId");
          //_postListDataLoading = false;
          response = {
            "result": response["result"],
            "data": response["data"][0],
          };
          _userDetail.add(response);
          return await _userDetail.value;
        }
      }
      print('   from inet');
      //userDetailUpdating = true;
      var response =
          await fetchGet('https://jsonplaceholder.typicode.com/users/$userId');
      await _saveUserDetail(response["data"]);

      //_postListDataLoading = false;
      _userDetail.add(response);
      //userDetailUpdating = false;
    }

    return await _userDetail.value;
  }

  get hasUserCachedData {
    return _hasUserCachedData;
  }

  get firstUserRender {
    return _firstUserRender;
  }

  set firstUserRender(value) {
    _firstUserRender = value;
  }
}

_Store store = _Store();
