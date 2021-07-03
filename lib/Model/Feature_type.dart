class FeaturesType{
  int _featuresID;
  String _featuresName;

  FeaturesType(this._featuresID,this._featuresName);

  String get featuresName => _featuresName;

  set featuresName(String value) {
    _featuresName = value;
  }

  int get featuresID => _featuresID;

  set featuresID(int value) {
    _featuresID = value;
  }
}













