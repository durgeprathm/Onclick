class UpdatedService {
  String _Serviceid;
  String _name;
  String _Mobilenumber;
  String _City;
  String _pincode;
  String _area;
  String _lat;
  String _long;
  String _servicetypeid;
  String _Servicetypename;
  String _Email;
  String _addharcardnumber;
  String _imgfront;
  String _imgback;
  String _posteddate;
  String _Alternatenumber;
  String _StdCode;
  String _Telephone;

  UpdatedService(
      this._Serviceid,
      this._name,
      this._Mobilenumber,
      this._City,
      this._pincode,
      this._area,
      this._lat,
      this._long,
      this._servicetypeid,
      this._Servicetypename,
      this._Email,
      this._addharcardnumber,
      this._imgfront,
      this._imgback,
      this._posteddate,
      this._Alternatenumber,
      this._StdCode,
      this._Telephone);

  String get Serviceid => _Serviceid;

  set Serviceid(String value) {
    _Serviceid = value;
  }

  String get Email => _Email;

  set Email(String value) {
    _Email = value;
  }

  String get name => _name;

  String get posteddate => _posteddate;

  set posteddate(String value) {
    _posteddate = value;
  }

  String get imgback => _imgback;

  set imgback(String value) {
    _imgback = value;
  }

  String get imgfront => _imgfront;

  set imgfront(String value) {
    _imgfront = value;
  }

  String get addharcardnumber => _addharcardnumber;

  set addharcardnumber(String value) {
    _addharcardnumber = value;
  }

  String get Servicetypename => _Servicetypename;

  set Servicetypename(String value) {
    _Servicetypename = value;
  }

  String get servicetypeid => _servicetypeid;

  set servicetypeid(String value) {
    _servicetypeid = value;
  }

  String get long => _long;

  set long(String value) {
    _long = value;
  }

  String get lat => _lat;

  set lat(String value) {
    _lat = value;
  }

  String get area => _area;

  set area(String value) {
    _area = value;
  }

  String get pincode => _pincode;

  set pincode(String value) {
    _pincode = value;
  }

  String get City => _City;

  set City(String value) {
    _City = value;
  }

  String get Mobilenumber => _Mobilenumber;

  set Mobilenumber(String value) {
    _Mobilenumber = value;
  }

  set name(String value) {
    _name = value;
  }

  String get Telephone => _Telephone;

  set Telephone(String value) {
    _Telephone = value;
  }

  String get StdCode => _StdCode;

  set StdCode(String value) {
    _StdCode = value;
  }

  String get Alternatenumber => _Alternatenumber;

  set Alternatenumber(String value) {
    _Alternatenumber = value;
  }
}
