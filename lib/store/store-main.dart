import 'package:rxdart/rxdart.dart';

class _ListStore {
  BehaviorSubject _posts = BehaviorSubject.seeded(null);
  //Map<List> posts;

  Stream get stream$ => _posts.stream;

  set postList(list) {
    _posts.add(list);
  }

  get postList {
    return _posts.value;
  }
}

_ListStore postListStore = _ListStore();
