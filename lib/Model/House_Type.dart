 class HouseType{
  int _HouseTypeID;
  String _HouseTypeName;

  HouseType(this._HouseTypeID,this._HouseTypeName);


  int get HouseTypeID => _HouseTypeID;

  set HouseTypeID(int value) {
    _HouseTypeID = value;
  }

  factory HouseType.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return HouseType(
        json['houseTypeId'],
        json['HouseTypeName']);
  }

  static List<HouseType> fromJsonList(List list) {
    if (list == null) return null;
    return list.map((item) => HouseType.fromJson(item)).toList();
  }

  ///this method will prevent the override of toString
  String userAsString() {
    return '#${this.HouseTypeID} ${this.HouseTypeName}';
  }

  ///custom comparing function to check if two users are equal
  bool isEqual(HouseType model) {
    return this?.HouseTypeID == model?.HouseTypeID;
  }


  @override
  String toString() => HouseTypeName;

  String get HouseTypeName => _HouseTypeName;

  set HouseTypeName(String value) {
    _HouseTypeName = value;
  }
}