class LikeBy {
  String _likeid;
  String _date;
  String _userid;
  String _fullname;
  String _mobileno;
  String _email;
  String _profile;

  LikeBy(this._likeid, this._date, this._userid, this._fullname, this._mobileno,
      this._email, this._profile);

  String get likeid => _likeid;

  set likeid(String value) {
    _likeid = value;
  }

  String get date => _date;

  String get profile => _profile;

  set profile(String value) {
    _profile = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get mobileno => _mobileno;

  set mobileno(String value) {
    _mobileno = value;
  }

  String get fullname => _fullname;

  set fullname(String value) {
    _fullname = value;
  }

  String get userid => _userid;

  set userid(String value) {
    _userid = value;
  }

  set date(String value) {
    _date = value;
  }
}
