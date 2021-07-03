class SubPropertyType{
  int _SubPropertyId;
  String _SubPropertyName;

  SubPropertyType(this._SubPropertyId,this._SubPropertyName);

  String get SubPropertyName => _SubPropertyName;

  set SubPropertyName(String value) {
    _SubPropertyName = value;
  }

  int get SubPropertyId => _SubPropertyId;

  set SubPropertyId(int value) {
    _SubPropertyId = value;
  }


  factory SubPropertyType.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return SubPropertyType(
        json['SubPropertytypeID'],
        json['SubPropertyName']);
  }

  static List<SubPropertyType> fromJsonList(List list) {
    if (list == null) return null;
    return list.map((item) => SubPropertyType.fromJson(item)).toList();
  }

  ///this method will prevent the override of toString
  String userAsString() {
    return '#${this.SubPropertyName} ${this.SubPropertyName}';
  }

  ///custom comparing function to check if two users are equal
  bool isEqual(SubPropertyType model) {
    return this?.SubPropertyName == model?.SubPropertyName;
  }


  @override
  String toString() => SubPropertyName;









}