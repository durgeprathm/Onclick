class Subscriptions {
  String _subscribeid;
  String _subscribeforwhomid;
  String _subscribeforwhomname;
  String _subscribeTitle;
  String _subscribeSubTitle;
  String _subscribeRate;
  String _subscribeExtraVisibility;
  String _subscribeProfessionalAssistance;
  String _subscribeBenefits;
  String _subscribeUniqueFeatures;
  String _subscribeStatus;

  Subscriptions(
      this._subscribeid,
      this._subscribeforwhomid,
      this._subscribeforwhomname,
      this._subscribeTitle,
      this._subscribeSubTitle,
      this._subscribeRate,
      this._subscribeExtraVisibility,
      this._subscribeProfessionalAssistance,
      this._subscribeBenefits,
      this._subscribeUniqueFeatures,
      this._subscribeStatus);

  String get subscribeUniqueFeatures => _subscribeUniqueFeatures;

  set subscribeUniqueFeatures(String value) {
    _subscribeUniqueFeatures = value;
  }

  String get subscribeBenefits => _subscribeBenefits;

  set subscribeBenefits(String value) {
    _subscribeBenefits = value;
  }

  String get subscribeProfessionalAssistance =>
      _subscribeProfessionalAssistance;

  set subscribeProfessionalAssistance(String value) {
    _subscribeProfessionalAssistance = value;
  }

  String get subscribeExtraVisibility => _subscribeExtraVisibility;

  set subscribeExtraVisibility(String value) {
    _subscribeExtraVisibility = value;
  }

  String get subscribeRate => _subscribeRate;

  set subscribeRate(String value) {
    _subscribeRate = value;
  }

  String get subscribeSubTitle => _subscribeSubTitle;

  set subscribeSubTitle(String value) {
    _subscribeSubTitle = value;
  }

  String get subscribeTitle => _subscribeTitle;

  set subscribeTitle(String value) {
    _subscribeTitle = value;
  }

  String get subscribeforwhomname => _subscribeforwhomname;

  set subscribeforwhomname(String value) {
    _subscribeforwhomname = value;
  }

  String get subscribeforwhomid => _subscribeforwhomid;

  set subscribeforwhomid(String value) {
    _subscribeforwhomid = value;
  }

  String get subscribeid => _subscribeid;

  set subscribeid(String value) {
    _subscribeid = value;
  }

  String get subscribeStatus => _subscribeStatus;

  set subscribeStatus(String value) {
    _subscribeStatus = value;
  }
}
