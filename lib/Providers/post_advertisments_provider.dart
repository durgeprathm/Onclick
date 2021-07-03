import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:onclickproperty/Adaptor/fetch_advertisement_paginationdata.dart';

class Advertisements {
  String _id;
  String _name;
  String _city;
  String _address;
  String _companyname;
  String _companywebsite;
  String _Image;
  String _email;
  String _mobileno;
  String _companytype;
  String _companyemail;
  String _companytitle;
  String _companydescription;
  String _lat;
  String _long;
  String _pincode;
  String _date;
  String _Aprrove;
  String _Alternatenumber;
  String _STDCode;
  String _Telephonenumber;

  Advertisements(this._id, this._name, this._city, this._address,
      this._companyname, this._companywebsite, this._Aprrove, this._Image);
  Advertisements.Details(
    this._id,
    this._name,
    this._email,
    this._mobileno,
    this._companyname,
    this._companytype,
    this._companywebsite,
    this._companyemail,
    this._companytitle,
    this._companydescription,
    this._city,
    this._address,
    this._lat,
    this._long,
    this._pincode,
    this._date,
    this._Alternatenumber,
    this._STDCode,
    this._Telephonenumber,
    this._Image,
  );

  String get companyname => _companyname;

  set companyname(String value) {
    _companyname = value;
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

  String get Image => _Image;

  set Image(String value) {
    _Image = value;
  }

  String get companywebsite => _companywebsite;

  set companywebsite(String value) {
    _companywebsite = value;
  }

  String get date => _date;

  set date(String value) {
    _date = value;
  }

  String get pincode => _pincode;

  set pincode(String value) {
    _pincode = value;
  }

  String get long => _long;

  set long(String value) {
    _long = value;
  }

  String get lat => _lat;

  set lat(String value) {
    _lat = value;
  }

  String get companydescription => _companydescription;

  set companydescription(String value) {
    _companydescription = value;
  }

  String get companytitle => _companytitle;

  set companytitle(String value) {
    _companytitle = value;
  }

  String get companyemail => _companyemail;

  set companyemail(String value) {
    _companyemail = value;
  }

  String get companytype => _companytype;

  set companytype(String value) {
    _companytype = value;
  }

  String get mobileno => _mobileno;

  set mobileno(String value) {
    _mobileno = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get Aprrove => _Aprrove;

  set Aprrove(String value) {
    _Aprrove = value;
  }

  String get Telephonenumber => _Telephonenumber;

  set Telephonenumber(String value) {
    _Telephonenumber = value;
  }

  String get STDCode => _STDCode;

  set STDCode(String value) {
    _STDCode = value;
  }

  String get Alternatenumber => _Alternatenumber;

  set Alternatenumber(String value) {
    _Alternatenumber = value;
  }
}

class PostAdvertisementProvider extends ValueNotifier<List<Advertisements>> {
  PostAdvertisementProvider() : super(null);

  int _pageNumber = 1;
  bool _hasMoreAdvertisements = true;
  int _batchesOf = 10;
  List<Advertisements> _listAdvertisements;
  bool _loading = false;

  @override
  List<Advertisements> get value => _value;
  List<Advertisements> _value;

  @override
  set value(List<Advertisements> newValue) {
    _value = newValue;
    notifyListeners();
  }

  Future<void> reload(String actionid) async {
    _listAdvertisements = <Advertisements>[];
    _pageNumber = 1;
    await httpGetAdvertisements(_pageNumber, actionid);
  }

  Future<void> getMore(String actionid) async {
    if (_hasMoreAdvertisements && !_loading) {
      _loading = true;
      await httpGetAdvertisements(_pageNumber, actionid);
      _loading = false;
    }
  }

  Future<void> httpGetAdvertisements(int page, String actionid) async {
    _listAdvertisements ??= <Advertisements>[];
    int pageNumber = page;
    while (_hasMoreAdvertisements && (pageNumber - page) < _batchesOf) {
      FetchAdvertisementsList fetchAdvertisementsList =
          new FetchAdvertisementsList();
      var response =
          await fetchAdvertisementsList.getFetchAdvertisementsPostedByUserList(
              actionid, pageNumber.toString());
      print(response);
      var servicessd = response["UserAdertisementList"];
      print(servicessd);
      if (servicessd != null) {
        for (var n in servicessd) {
          Advertisements property = Advertisements(
              n["id"],
              n["name"],
              n["city"],
              n["address"],
              n["companyname"],
              n["companywebsite"],
              n["approve"],
              n["img"]);
          _listAdvertisements.add(property);
        }
      } else {
        _hasMoreAdvertisements = false;
      }
      pageNumber++;
    }
    _pageNumber = pageNumber;
    value = _listAdvertisements;
  }
}
