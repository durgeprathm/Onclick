import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:onclickproperty/Adaptor/fetch_properties_paginationdata.dart';
import 'package:onclickproperty/Model/toppropertylist_model.dart';
import 'package:onclickproperty/Adaptor/fetch_filter_properties.dart';

class TopPropertiesNotifier extends ValueNotifier<List<PropertyListModel>> {
  TopPropertiesNotifier() : super(null);

  int _pageNumber = 1;
  bool _hasMoreProperties = true;
  int _batchesOf = 10;
  List<PropertyListModel> _listProperties;
  bool _loading = false;

  @override
  List<PropertyListModel> get value => _value;
  List<PropertyListModel> _value;

  @override
  set value(List<PropertyListModel> newValue) {
    _value = newValue;
    notifyListeners();
  }

  Future<void> reload(String actionid, String ptype, String checktype,
      String agentid, String localityname, String usertype) async {
    _listProperties = <PropertyListModel>[];
    _pageNumber = 1;
    await httpGetProperties(_pageNumber, actionid, ptype, checktype, agentid,
        localityname, usertype);
  }

  Future<void> getMore(String actionid, String ptype, String checktype,
      String agentid, String localityname, String usertype) async {
    if (_hasMoreProperties && !_loading) {
      _loading = true;
      await httpGetProperties(_pageNumber, actionid, ptype, checktype, agentid,
          localityname, usertype);
      _loading = false;
    }
  }

  Future<void> reloadWishList(String actionid, String ptype, String checktype,
      String agentid, String localityname, String usertype) async {
    _listProperties = <PropertyListModel>[];
    _pageNumber = 1;
    await httpGetWishListProperties(_pageNumber, actionid, ptype, checktype,
        agentid, localityname, usertype);
  }

  Future<void> getMoreWishList(String actionid, String ptype, String checktype,
      String agentid, String localityname, String usertype) async {
    if (_hasMoreProperties && !_loading) {
      _loading = true;
      await httpGetWishListProperties(_pageNumber, actionid, ptype, checktype,
          agentid, localityname, usertype);
      _loading = false;
    }
  }

  Future<void> getMorePostedByUser(String actionid) async {
    print('getMorePostedByUser');
    if (_hasMoreProperties && !_loading) {
      _loading = true;
      await httpGetPropertiesPostedByUser(_pageNumber, actionid);
      _loading = false;
    }
  }

  Future<void> reloadPostedByUser(String actionid) async {
    _listProperties = <PropertyListModel>[];
    _pageNumber = 1;
    await httpGetPropertiesPostedByUser(_pageNumber, actionid);
  }

  Future<void> getMorePostedByUserTab(
      String actionid, String Propertytype, String Forwhat) async {
    print('getMorePostedByUser');
    if (_hasMoreProperties && !_loading) {
      _loading = true;
      await httpGetPropertiesPostedByUserTab(
          _pageNumber, actionid, Propertytype, Forwhat);
      _loading = false;
    }
  }

  Future<void> reloadPostedByUsertab(
      String actionid, String propertytype, String forwhat) async {
    _listProperties = <PropertyListModel>[];
    _pageNumber = 1;
    await httpGetPropertiesPostedByUserTab(
        _pageNumber, actionid, propertytype, forwhat);
  }

  Future<void> getMoreFilterPropertyList(
      String tabType,
      String actionid,
      String lookingfor,
      String location,
      String pincode,
      String bedrooms,
      String propertytypes,
      String squrefeetstart,
      String squrefeetend,
      String bathroom,
      String pricestart,
      String priceend,
      String Furniture,
      String postedby,
      String typeofsort) async {
    if (_hasMoreProperties && !_loading) {
      _loading = true;
      await httpGetFilterPropertyList(
          tabType,
          _pageNumber,
          actionid,
          lookingfor,
          location,
          pincode,
          bedrooms,
          propertytypes,
          squrefeetstart,
          squrefeetend,
          bathroom,
          pricestart,
          priceend,
          Furniture,
          postedby,
          typeofsort);
      _loading = false;
    }
  }

  Future<void> reloadFilterPropertyList(
      String tabType,
      String actionid,
      String lookingfor,
      String location,
      String pincode,
      String bedrooms,
      String propertytypes,
      String squrefeetstart,
      String squrefeetend,
      String bathroom,
      String pricestart,
      String priceend,
      String Furniture,
      String postedby,
      String typeofsort) async {
    _listProperties = <PropertyListModel>[];
    _pageNumber = 1;
    await httpGetFilterPropertyList(
        tabType,
        _pageNumber,
        actionid,
        lookingfor,
        location,
        pincode,
        bedrooms,
        propertytypes,
        squrefeetstart,
        squrefeetend,
        bathroom,
        pricestart,
        priceend,
        Furniture,
        postedby,
        typeofsort);
  }

  Future<void> getMoreProjectFilterPropertyList(
      String actionid,
      String localityname,
      String ptype,
      String projectresidential,
      String residentialbhktype) async {
    if (_hasMoreProperties && !_loading) {
      _loading = true;
      await httpGetProjectFilterPropertyList(_pageNumber, actionid,
          localityname, ptype, projectresidential, residentialbhktype);
      _loading = false;
    }
  }

  Future<void> reloadProjectFilterPropertyList(
      String actionid,
      String localityname,
      String ptype,
      String projectresidential,
      String residentialbhktype) async {
    _listProperties = <PropertyListModel>[];
    _pageNumber = 1;
    await httpGetProjectFilterPropertyList(_pageNumber, actionid, localityname,
        ptype, projectresidential, residentialbhktype);
  }

  Future<void> httpGetProperties(
      int page,
      String actionid,
      String ptype,
      String checktype,
      String agentId,
      String localityname,
      String usertype) async {
    _listProperties ??= <PropertyListModel>[];
    int pageNumber = page;
    while (_hasMoreProperties && (pageNumber - page) < _batchesOf) {
      print('httpGetProperties Call Top Property $pageNumber');
      FetchPropertiesList fetchPropertiesList = new FetchPropertiesList();
      var response = await fetchPropertiesList.getPropertiesList(
          actionid,
          localityname,
          pageNumber.toString(),
          ptype,
          checktype,
          agentId,
          usertype);
      var propertiessd = response["toppropertieslist"];
      print(propertiessd);
      if (propertiessd != null) {
        for (var n in propertiessd) {
          PropertyListModel property = PropertyListModel(
            n["id"],
            n["propertysize"],
            n["furnishing"],
            n["Tagline"],
            n["Tagline2"],
            n["price"],
            n["topimglink"],
            n["like"] == '0' ? false : true,
            n["likecount"],
            n["mobile"],
          );
          _listProperties.add(property);
        }
      } else {
        _hasMoreProperties = false;
      }
      pageNumber++;
    }
    _pageNumber = pageNumber;
    value = _listProperties;
  }

  Future<void> httpGetWishListProperties(
      int page,
      String actionid,
      String ptype,
      String checktype,
      String agentId,
      String localityname,
      String usertype) async {
    _listProperties ??= <PropertyListModel>[];
    int pageNumber = page;
    while (_hasMoreProperties && (pageNumber - page) < _batchesOf) {
      FetchPropertiesList fetchPropertiesList = new FetchPropertiesList();
      var response = await fetchPropertiesList.getPropertiesList(
          actionid,
          localityname,
          pageNumber.toString(),
          ptype,
          checktype,
          agentId,
          usertype);
      var propertiessd = response["toppropertieslist"];
      print(propertiessd);
      if (propertiessd != null) {
        for (var n in propertiessd) {
          PropertyListModel property = PropertyListModel.withptypeid(
            n["id"],
            n["propertysize"],
            n["furnishing"],
            n["Tagline"],
            n["Tagline2"],
            n["price"],
            n["topimglink"],
            n["like"] == '0' ? false : true,
            n["ptypeid"],
            n["approve"],
          );
          _listProperties.add(property);
        }
      } else {
        _hasMoreProperties = false;
      }
      pageNumber++;
    }
    _pageNumber = pageNumber;
    value = _listProperties;
  }

  Future<void> httpGetFilterPropertyList(
      String tabType,
      int page,
      String actionid,
      String lookingfor,
      String location,
      String pincode,
      String bedrooms,
      String propertytypes,
      String squrefeetstart,
      String squrefeetend,
      String bathroom,
      String pricestart,
      String priceend,
      String Furniture,
      String postedby,
      String typeofsort) async {
    _listProperties ??= <PropertyListModel>[];
    int pageNumber = page;
    while (_hasMoreProperties && (pageNumber - page) < _batchesOf) {
      print("httpGetFilterPropertyList");
      FetchFilterPropertiesList fetchPropertiesList =
          new FetchFilterPropertiesList();
      var response = await fetchPropertiesList.getFetchFilterPropertiesList(
          tabType,
          pageNumber.toString(),
          actionid,
          lookingfor,
          location,
          pincode,
          bedrooms,
          propertytypes,
          squrefeetstart,
          squrefeetend,
          bathroom,
          pricestart,
          priceend,
          Furniture,
          postedby,
          typeofsort);
      print(response);
      var propertiessd = response["ResidentalTypeFilterList"];
      print(propertiessd);
      if (propertiessd != null) {
        for (var n in propertiessd) {
          PropertyListModel property = PropertyListModel.withptypeid(
            n["id"],
            n["propertysize"],
            n["furnishing"],
            n["Tagline"],
            n["Tagline2"],
            n["price"],
            n["topimglink"],
            n["like"] == '0' ? false : true,
            n["ptypeid"],
            n["approve"],
          );
          _listProperties.add(property);
        }
      } else {
        _hasMoreProperties = false;
      }
      pageNumber++;
    }
    _pageNumber = pageNumber;
    value = _listProperties;
  }

  Future<void> httpGetProjectFilterPropertyList(
      int page,
      String actionid,
      String localityname,
      String ptype,
      String projectresidential,
      String residentialbhktype) async {
    _listProperties ??= <PropertyListModel>[];
    int pageNumber = page;
    while (_hasMoreProperties && (pageNumber - page) < _batchesOf) {
      FetchPropertiesList fetchPropertiesList = new FetchPropertiesList();
      var response = await fetchPropertiesList.getProjectFilterPropertiesList(
          actionid,
          pageNumber.toString(),
          localityname,
          ptype,
          projectresidential,
          residentialbhktype);
      var propertiessd = response["toppropertieslist"];
      print(propertiessd);
      if (propertiessd != null) {
        for (var n in propertiessd) {
          PropertyListModel property = PropertyListModel.withptypeid(
            n["id"],
            n["propertysize"],
            n["furnishing"],
            n["Tagline"],
            n["Tagline2"],
            n["price"],
            n["topimglink"],
            n["like"] == '0' ? false : true,
            n["ptypeid"],
            n["approve"],
          );
          _listProperties.add(property);
        }
      } else {
        _hasMoreProperties = false;
      }
      pageNumber++;
    }
    _pageNumber = pageNumber;
    value = _listProperties;
  }

  Future<void> httpGetPropertiesPostedByUser(int page, String actionid) async {
    _listProperties ??= <PropertyListModel>[];
    int pageNumber = page;
    while (_hasMoreProperties && (pageNumber - page) < _batchesOf) {
      print('httpGetPropertiesPostedByUser Call $pageNumber');

      FetchPropertiesList fetchPropertiesList = new FetchPropertiesList();
      var response = await fetchPropertiesList.getPropertiesPostedByUserList(
          actionid, pageNumber.toString(), "", "");
      print(response);
      var propertiessd = response["UserPropertyList"];

      if (propertiessd != null) {
        for (var n in propertiessd) {
          PropertyListModel property = PropertyListModel.withptypeid(
            n["id"],
            n["propertysize"],
            n["furnishing"],
            n["Tagline"],
            n["Tagline2"],
            n["price"],
            n["topimglink"],
            n["like"] == '0' ? false : true,
            n["ptypeid"],
            n["approve"],
          );
          _listProperties.add(property);
        }
      } else {
        _hasMoreProperties = false;
      }
      pageNumber++;
    }
    _pageNumber = pageNumber;
    value = _listProperties;
  }

  Future<void> httpGetPropertiesPostedByUserTab(
      int page, String actionid, propertytype, forwhat) async {
    _listProperties ??= <PropertyListModel>[];
    int pageNumber = page;
    while (_hasMoreProperties && (pageNumber - page) < _batchesOf) {
      print('httpGetPropertiesPostedByUser Call $pageNumber');

      FetchPropertiesList fetchPropertiesList = new FetchPropertiesList();
      var response = await fetchPropertiesList.getPropertiesPostedByUserList(
          actionid, pageNumber.toString(), propertytype, forwhat);
      print(response);
      var propertiessd = response["UserPropertyList"];

      if (propertiessd != null) {
        for (var n in propertiessd) {
          PropertyListModel property = PropertyListModel.withptypeid(
            n["id"],
            n["propertysize"],
            n["furnishing"],
            n["Tagline"],
            n["Tagline2"],
            n["price"],
            n["topimglink"],
            n["like"] == '0' ? false : true,
            n["ptypeid"],
            n["approve"],
          );
          _listProperties.add(property);
        }
      } else {
        _hasMoreProperties = false;
      }
      pageNumber++;
    }
    _pageNumber = pageNumber;
    value = _listProperties;
  }
}
