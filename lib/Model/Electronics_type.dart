class ElectronicsType{
  int _ElectronicsTypeID;
  String _ElectronicsTypeName;

  ElectronicsType(this._ElectronicsTypeID,this._ElectronicsTypeName);

  String get ElectronicsTypeName => _ElectronicsTypeName;

  set ElectronicsTypeName(String value) {
    _ElectronicsTypeName = value;
  }

  int get ElectronicsTypeID => _ElectronicsTypeID;

  set ElectronicsTypeID(int value) {
    _ElectronicsTypeID = value;
  }





  factory ElectronicsType.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return ElectronicsType(
        json['ElectronicsTypeId'],
        json['ElectronicsTypeName']);
  }

  static List<ElectronicsType> fromJsonList(List list) {
    if (list == null) return null;
    return list.map((item) => ElectronicsType.fromJson(item)).toList();
  }

  ///this method will prevent the override of toString
  String userAsString() {
    return '#${this.ElectronicsTypeID} ${this.ElectronicsTypeName}';
  }

  ///custom comparing function to check if two users are equal
  bool isEqual(ElectronicsType model) {
    return this?.ElectronicsTypeID == model?.ElectronicsTypeID;
  }


  @override
  String toString() => ElectronicsTypeName;




}













