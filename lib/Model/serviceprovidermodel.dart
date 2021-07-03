class ServiceProvider{

  String _spid;
  String _spname;
  String _spcity;
  String _spmobno;

  ServiceProvider(this._spid, this._spname, this._spcity, this._spmobno);


  String get spmobno => _spmobno;

  set spmobno(String value) {
    _spmobno = value;
  }

  String get spcity => _spcity;

  set spcity(String value) {
    _spcity = value;
  }

  String get spname => _spname;

  set spname(String value) {
    _spname = value;
  }

  String get spid => _spid;

  set spid(String value) {
    _spid = value;
  }

}