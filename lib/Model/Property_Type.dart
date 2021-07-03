 class PropertType{
  int _PropertyTypeID;
  String _PropertyTypeName;

  PropertType(this._PropertyTypeID,this._PropertyTypeName);



  String get PropertyTypeName => _PropertyTypeName;

  set PropertyTypeName(String value) {
    _PropertyTypeName = value;
  }

  int get PropertyTypeID => _PropertyTypeID;

  set PropertyTypeID(int value) {
    _PropertyTypeID = value;
  }


  factory PropertType.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return PropertType(
        json['PropertryTypesID'],
        json['PropertryTypesName']);
  }

  static List<PropertType> fromJsonList(List list) {
    if (list == null) return null;
    return list.map((item) => PropertType.fromJson(item)).toList();
  }

  ///this method will prevent the override of toString
  String userAsString() {
    return '#${this.PropertyTypeID} ${this.PropertyTypeName}';
  }

  ///custom comparing function to check if two users are equal
  bool isEqual(PropertType model) {
    return this?.PropertyTypeID == model?.PropertyTypeID;
  }


  @override
  String toString() => PropertyTypeName;




}