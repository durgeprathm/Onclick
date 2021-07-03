class CityList{
  String _cityid;
  String _cityname;

  CityList(this._cityid, this._cityname);

  String get cityname => _cityname;

  set cityname(String value) {
    _cityname = value;
  }

  String get cityid => _cityid;

  set cityid(String value) {
    _cityid = value;
  }


}