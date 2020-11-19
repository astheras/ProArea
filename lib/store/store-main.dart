import 'package:flutter/material.dart';
import 'package:mainx/pages/post-detail.dart';
import 'package:mainx/pages/post-list.dart';
import 'package:mainx/pages/splash-page.dart';
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
