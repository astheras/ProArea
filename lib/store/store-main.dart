import 'package:rxdart/rxdart.dart';

class _Store {
  BehaviorSubject _posts = BehaviorSubject.seeded(null);
  BehaviorSubject _userDetail = BehaviorSubject.seeded(null);
  BehaviorSubject _userDetailUpdating = BehaviorSubject.seeded(false);
}

_Store store = _Store();
