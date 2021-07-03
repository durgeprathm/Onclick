class BankBranch {
  String _bankid;
  String _bankname;
  String _rateinterest;
  String _processingfees;
  String _emi;
  String _date;

  BankBranch(this._bankid, this._bankname, this._rateinterest,
      this._processingfees, this._emi, this._date);

  String get date => _date;

  set date(String value) {
    _date = value;
  }

  String get emi => _emi;

  set emi(String value) {
    _emi = value;
  }

  String get processingfees => _processingfees;

  set processingfees(String value) {
    _processingfees = value;
  }

  String get rateinterest => _rateinterest;

  set rateinterest(String value) {
    _rateinterest = value;
  }

  String get bankname => _bankname;

  set bankname(String value) {
    _bankname = value;
  }

  String get bankid => _bankid;

  set bankid(String value) {
    _bankid = value;
  }

  factory BankBranch.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return BankBranch(json['bankid'], json['bankname'], json['rateinterest'],
        json['processingfees'], json['emi'], json['date']);
  }

  static List<BankBranch> fromJsonList(List list) {
    if (list == null) return null;
    return list.map((item) => BankBranch.fromJson(item)).toList();
  }

  ///this method will prevent the override of toString
  String userAsString() {
    return '#${this.bankid} ${this._bankname}';
  }

  ///custom comparing function to check if two users are equal
  bool isEqual(BankBranch model) {
    return this?.bankid == model?.bankid;
  }

  @override
  String toString() => _bankname;

}
