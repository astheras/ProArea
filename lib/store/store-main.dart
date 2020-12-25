import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rxdart/rxdart.dart';

class _Store {
  BehaviorSubject _geo = BehaviorSubject.seeded(null);
  BehaviorSubject _weather = BehaviorSubject.seeded(null);
  BehaviorSubject _selectedDayIndex = BehaviorSubject.seeded(null);
  BehaviorSubject _selectedPageIndex = BehaviorSubject.seeded(null);

  //sorry, but i dod't now how to make pageview change active page without srore(((
  final pageViewController = PageController(
    initialPage: 0,
  );

  get geo {
    return _geo.value;
  }

  set geo(Placemark data) {
    _geo.add(data);
  }

  get weather {
    return _weather.value;
  }

  set weather(Map data) {
    _weather.add(data);
  }

  get selectedDayIndex {
    return _selectedDayIndex.value;
  }

  set selectedDayIndex(int value) {
    _selectedDayIndex.add(value);
  }

  get selectedPageIndex {
    return _selectedPageIndex.value;
  }

  set selectedPageIndex(int value) {
    _selectedPageIndex.add(value);
  }
}

_Store store = _Store();
