import 'package:rxdart/rxdart.dart';

class _Store {
  BehaviorSubject _posts = BehaviorSubject.seeded(null);
  BehaviorSubject _detail = BehaviorSubject.seeded(null);
  //Map<List> posts;

  //Stream get stream$ => _posts.stream;

  // post list
  set postList(list) {
    _posts.add(list);
  }

  get postList {
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
