import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:onclickproperty/Adaptor/fetch_services_paginationdata.dart';
import 'package:onclickproperty/Model/toppropertylist_model.dart';
import 'package:onclickproperty/Adaptor/fetch_filter_properties.dart';

class Services {
  String _id;
  String _name;
  String _city;
  String _address;
  String _servicetypeid;
  String _servicetypename;
  String _Aprrove;

  Services(this._id, this._name, this._city, this._address, this._servicetypeid,
      this._servicetypename,this._Aprrove);

  String get servicetypename => _servicetypename;

  set servicetypename(String value) {
    _servicetypename = value;
  }


  String get Aprrove => _Aprrove;

  set Aprrove(String value) {
    _Aprrove = value;
  }

  String get servicetypeid => _servicetypeid;

  set servicetypeid(String value) {
    _servicetypeid = value;
  }

  String get address => _address;

  set address(String value) {
    _address = value;
  }

  String get city => _city;

  set city(String value) {
    _city = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

}

class PostServiceProvider extends ValueNotifier<List<Services>> {
  PostServiceProvider() : super(null);

  int _pageNumber = 1;
  bool _hasMoreServices = true;
  int _batchesOf = 10;
  List<Services> _listServices;
  bool _loading = false;

  @override
  List<Services> get value => _value;
  List<Services> _value;

  @override
  set value(List<Services> newValue) {
    _value = newValue;
    notifyListeners();
  }

  Future<void> reload(String actionid) async {
    _listServices = <Services>[];
    _pageNumber = 1;
    await httpGetServices(_pageNumber, actionid);
  }

  Future<void> getMore(String actionid) async {
    if (_hasMoreServices && !_loading) {
      _loading = true;
      await httpGetServices(_pageNumber, actionid);
      _loading = false;
    }
  }

  Future<void> httpGetServices(int page, String actionid) async {
    _listServices ??= <Services>[];
    int pageNumber = page;
    while (_hasMoreServices && (pageNumber - page) < _batchesOf) {
      FetchServicesList fetchServicesList = new FetchServicesList();
      var response = await fetchServicesList.getFetchServicesPostedByUserList(
          actionid, pageNumber.toString());
      print(response);
      var servicessd = response["UserserviceList"];
      print(servicessd);
      if (servicessd != null) {
        for (var n in servicessd) {
          Services property = Services(n["id"], n["name"], n["city"],
              n["address"], n["servicetypeid"], n["servicetypename"], n["approve"]);
          _listServices.add(property);
        }
      } else {
        _hasMoreServices = false;
      }
      pageNumber++;
    }
    _pageNumber = pageNumber;
    value = _listServices;
  }
}
