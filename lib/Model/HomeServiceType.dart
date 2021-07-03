class HomeServiceType{

  String _typeid;
  String _servicename;
  String _servicedecsp;

  HomeServiceType(this._typeid, this._servicename, this._servicedecsp);

  String get servicedecsp => _servicedecsp;

  set servicedecsp(String value) {
    _servicedecsp = value;
  }

  String get servicename => _servicename;

  set servicename(String value) {
    _servicename = value;
  }

  String get typeid => _typeid;

  set typeid(String value) {
    _typeid = value;
  }





  factory HomeServiceType.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return HomeServiceType(
        json['serviceid'],
        json['servicename'],
        json['servicedecp']);
  }

  static List<HomeServiceType> fromJsonList(List list) {
    if (list == null) return null;
    return list.map((item) => HomeServiceType.fromJson(item)).toList();
  }

  ///this method will prevent the override of toString
  String userAsString() {
    return '#${this.typeid} ${this.servicename}';
  }

  ///custom comparing function to check if two users are equal
  bool isEqual(HomeServiceType model) {
    return this?.typeid == model?.typeid;
  }


  @override
  String toString() => servicename;
}