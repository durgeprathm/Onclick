import 'dart:collection';

import 'package:flutter/material.dart';

class AllDashboardPropertyItems {
  String _id;
  String _posterid;
  String _aid;
  String _propertytype;
  String _price;
  String _topimglink;

  AllDashboardPropertyItems(this._id, this._posterid, this._aid,
      this._propertytype, this._price, this._topimglink);

  String get topimglink => _topimglink;

  set topimglink(String value) {
    _topimglink = value;
  }

  String get price => _price;

  set price(String value) {
    _price = value;
  }

  String get propertytype => _propertytype;

  set propertytype(String value) {
    _propertytype = value;
  }

  String get aid => _aid;

  set aid(String value) {
    _aid = value;
  }

  String get posterid => _posterid;

  set posterid(String value) {
    _posterid = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }
}

class AllDashboardResTopProperty with ChangeNotifier {
  List<AllDashboardPropertyItems> _dashPropertyItems = [];

  int get itemCount {
    return _dashPropertyItems.length;
  }

  UnmodifiableListView<AllDashboardPropertyItems> get pTopProperty {
    return UnmodifiableListView(_dashPropertyItems);
  }

  void addAllDashboardProperty(AllDashboardPropertyItems item) {
    _dashPropertyItems.add(item);
    notifyListeners();
  }

  void removeItem(AllDashboardPropertyItems item) {
    _dashPropertyItems.remove(item);
    notifyListeners();
  }

  void clear() {
    if (_dashPropertyItems.isNotEmpty) {
      _dashPropertyItems.clear();
      notifyListeners();
    }
  }
}

class AllDashboardResRentProperty with ChangeNotifier {
  List<AllDashboardPropertyItems> _dashPropertyItems = [];

  int get itemCount {
    return _dashPropertyItems.length;
  }

  UnmodifiableListView<AllDashboardPropertyItems> get pRentProperty {
    return UnmodifiableListView(_dashPropertyItems);
  }

  void addAllDashboardProperty(AllDashboardPropertyItems item) {
    _dashPropertyItems.add(item);
    notifyListeners();
  }

  void removeItem(AllDashboardPropertyItems item) {
    _dashPropertyItems.remove(item);
    notifyListeners();
  }

  void clear() {
    if (_dashPropertyItems.isNotEmpty) {
      _dashPropertyItems.clear();
      notifyListeners();
    }
  }
}

class AllDashboardResSellProperty with ChangeNotifier {
  List<AllDashboardPropertyItems> _dashPropertyItems = [];

  int get itemCount {
    return _dashPropertyItems.length;
  }

  UnmodifiableListView<AllDashboardPropertyItems> get pSellProperty {
    return UnmodifiableListView(_dashPropertyItems);
  }

  void addAllDashboardProperty(AllDashboardPropertyItems item) {
    _dashPropertyItems.add(item);
    notifyListeners();
  }

  void removeItem(AllDashboardPropertyItems item) {
    _dashPropertyItems.remove(item);
    notifyListeners();
  }

  void clear() {
    if (_dashPropertyItems.isNotEmpty) {
      print('_dashPropertyItems if call');
      _dashPropertyItems.clear();
      notifyListeners();
    } else {
      print('_dashPropertyItems else call');
    }
  }
}


class AllDashboardCommTopProperty with ChangeNotifier {
  List<AllDashboardPropertyItems> _dashPropertyItems = [];

  int get itemCount {
    return _dashPropertyItems.length;
  }

  UnmodifiableListView<AllDashboardPropertyItems> get pTopProperty {
    return UnmodifiableListView(_dashPropertyItems);
  }

  void addAllDashboardProperty(AllDashboardPropertyItems item) {
    _dashPropertyItems.add(item);
    notifyListeners();
  }

  void removeItem(AllDashboardPropertyItems item) {
    _dashPropertyItems.remove(item);
    notifyListeners();
  }

  void clear() {
    if (_dashPropertyItems.isNotEmpty) {
      print('_dashPropertyItems if call');
      _dashPropertyItems.clear();
      notifyListeners();
    } else {
      print('_dashPropertyItems else call');
    }
  }
}



class AllDashboardCommSellProperty with ChangeNotifier {
  List<AllDashboardPropertyItems> _dashPropertyItems = [];

  int get itemCount {
    return _dashPropertyItems.length;
  }

  UnmodifiableListView<AllDashboardPropertyItems> get pSellProperty {
    return UnmodifiableListView(_dashPropertyItems);
  }

  void addAllDashboardProperty(AllDashboardPropertyItems item) {
    _dashPropertyItems.add(item);
    notifyListeners();
  }

  void removeItem(AllDashboardPropertyItems item) {
    _dashPropertyItems.remove(item);
    notifyListeners();
  }

  void clear() {
    if (_dashPropertyItems.isNotEmpty) {
      print('_dashPropertyItems if call');
      _dashPropertyItems.clear();
      notifyListeners();
    } else {
      print('_dashPropertyItems else call');
    }
  }
}



class AllDashboardCommRentProperty with ChangeNotifier {
  List<AllDashboardPropertyItems> _dashPropertyItems = [];

  int get itemCount {
    return _dashPropertyItems.length;
  }

  UnmodifiableListView<AllDashboardPropertyItems> get pRentProperty {
    return UnmodifiableListView(_dashPropertyItems);
  }

  void addAllDashboardProperty(AllDashboardPropertyItems item) {
    _dashPropertyItems.add(item);
    notifyListeners();
  }

  void removeItem(AllDashboardPropertyItems item) {
    _dashPropertyItems.remove(item);
    notifyListeners();
  }

  void clear() {
    if (_dashPropertyItems.isNotEmpty) {
      _dashPropertyItems.clear();
      notifyListeners();
    }
  }
}

class AllDashboardProjectTopProperty with ChangeNotifier {
  List<AllDashboardPropertyItems> _dashPropertyItems = [];

  int get itemCount {
    return _dashPropertyItems.length;
  }

  UnmodifiableListView<AllDashboardPropertyItems> get pTopProperty {
    return UnmodifiableListView(_dashPropertyItems);
  }

  void addAllDashboardProperty(AllDashboardPropertyItems item) {
    _dashPropertyItems.add(item);
    notifyListeners();
  }

  void removeItem(AllDashboardPropertyItems item) {
    _dashPropertyItems.remove(item);
    notifyListeners();
  }

  void clear() {
    if (_dashPropertyItems.isNotEmpty) {
      _dashPropertyItems.clear();
      notifyListeners();
    }
  }
}

class AllDashboardProjectSellProperty with ChangeNotifier {
  List<AllDashboardPropertyItems> _dashPropertyItems = [];

  int get itemCount {
    return _dashPropertyItems.length;
  }

  UnmodifiableListView<AllDashboardPropertyItems> get pSellProperty {
    return UnmodifiableListView(_dashPropertyItems);
  }

  void addAllDashboardProperty(AllDashboardPropertyItems item) {
    _dashPropertyItems.add(item);
    notifyListeners();
  }

  void removeItem(AllDashboardPropertyItems item) {
    _dashPropertyItems.remove(item);
    notifyListeners();
  }

  void clear() {
    if (_dashPropertyItems.isNotEmpty) {
      print('_dashPropertyItems if call');
      _dashPropertyItems.clear();
      notifyListeners();
    } else {
      print('_dashPropertyItems else call');
    }
  }
}
