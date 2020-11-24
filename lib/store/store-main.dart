import 'package:mainx/pages/post-detail.dart';
import 'package:mainx/pages/post-list.dart';
import 'package:mainx/pages/splash-page.dart';
import 'package:mainx/utils/requests.dart';
import 'package:mainx/utils/sqlite.dart';
import 'package:rxdart/rxdart.dart';

class _Store {
  bool _postListDataLoading = false;
  bool _hasCachedData = false;
  BehaviorSubject _posts = BehaviorSubject.seeded(null);
  BehaviorSubject _detail = BehaviorSubject.seeded(null);
  //Map<List> posts;

  //Stream get stream$ => _posts.stream;

  var routes = {
    '/': (context) => SplashScreenPage(),
    '/postlist': (context) => PostListPage(),
    '/detail': (context) => PostDetailPage(),
  };

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

    return response["data"].first["ex"] == 1 ? true : false;
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
      /*
      var response = await SQL.execute(
        "select * from posts",
      );
      */

      print('   done');
    }

    //SQL.execute(sql)
  }

  get hasCachedData {
    return _hasCachedData;
  }

  // post detail
  set postDetail(list) {
    _detail.add(list);
  }

  get postDetail {
    return _detail.value;
  }
}

_Store store = _Store();
