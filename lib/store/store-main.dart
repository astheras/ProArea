import 'package:mainx/pages/post-detail.dart';
import 'package:mainx/pages/post-list.dart';
import 'package:mainx/pages/splash-page.dart';
import 'package:mainx/utils/requests.dart';
import 'package:rxdart/rxdart.dart';

class _Store {
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

  // post list
  /*set postList(value) {
    _posts.add(jsonDecode(value));
  }*/

  Future<Map> postList([bool refresh = false]) async {
    if (_posts.value == null || refresh)
      return await fetchGet('https://jsonplaceholder.typicode.com/posts');

    return _posts.value;
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
