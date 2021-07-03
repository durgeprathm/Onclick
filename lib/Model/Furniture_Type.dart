 class FurnitureType{
  int _FurnitureTypeID;
  String _FurnitureTypeName;

  FurnitureType(this._FurnitureTypeID,this._FurnitureTypeName);




  factory FurnitureType.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return FurnitureType(
        json['FurnitureID'],
        json['FurnitureName']);
  }

  static List<FurnitureType> fromJsonList(List list) {
    if (list == null) return null;
    return list.map((item) => FurnitureType.fromJson(item)).toList();
  }

  ///this method will prevent the override of toString
  String userAsString() {
    return '#${this.FurnitureTypeID} ${this.FurnitureTypeName}';
  }

  ///custom comparing function to check if two users are equal
  bool isEqual(FurnitureType model) {
    return this?.FurnitureTypeID == model?.FurnitureTypeID;
  }


  @override
  String toString() => FurnitureTypeName;




  String get FurnitureTypeName => _FurnitureTypeName;

  set FurnitureTypeName(String value) {
    _FurnitureTypeName = value;
  }

  int get FurnitureTypeID => _FurnitureTypeID;

  set FurnitureTypeID(int value) {
    _FurnitureTypeID = value;
  }
}