class PropertyListModel {
//  factory PropertyListModel.fromJson(Map<dynamic, dynamic> json) {
//    return PropertyListModel(
//        Id: json['id'],
//        PropertySize: json['propertysize'],
//        Furnishing: json['furnishing'],
//        Tagline: json['Tagline'],
//        Tagline2: json['Tagline2'],
//        Price: json['price'],
//        Topimglink:json['topimglink']);
//  }

  String _Id;
  String _PropertySize;
  String _Furnishing;
  String _Tagline;
  String _Tagline2;
  String _Price;
  String _Topimglink;
  bool _isFavourite;
  String _ptypeid;
  String _Approve;
  String _likecount;
  String _mobile;

  PropertyListModel(
      this._Id,
      this._PropertySize,
      this._Furnishing,
      this._Tagline,
      this._Tagline2,
      this._Price,
      this._Topimglink,
      this._isFavourite,
      this._likecount,
      this._mobile);
  PropertyListModel.withptypeid(
      this._Id,
      this._PropertySize,
      this._Furnishing,
      this._Tagline,
      this._Tagline2,
      this._Price,
      this._Topimglink,
      this._isFavourite,
      this._ptypeid,
      this._Approve);

  bool get isFavourite => _isFavourite;

  set isFavourite(bool value) {
    _isFavourite = value;
  }

  String get Topimglink => _Topimglink;

  set Topimglink(String value) {
    _Topimglink = value;
  }

  String get Price => _Price;

  set Price(String value) {
    _Price = value;
  }

  String get Tagline2 => _Tagline2;

  set Tagline2(String value) {
    _Tagline2 = value;
  }

  String get Tagline => _Tagline;

  set Tagline(String value) {
    _Tagline = value;
  }

  String get Furnishing => _Furnishing;

  set Furnishing(String value) {
    _Furnishing = value;
  }

  String get PropertySize => _PropertySize;

  set PropertySize(String value) {
    _PropertySize = value;
  }

  String get Id => _Id;

  set Id(String value) {
    _Id = value;
  }

  String get ptypeid => _ptypeid;

  set ptypeid(String value) {
    _ptypeid = value;
  }

  String get Approve => _Approve;

  set Approve(String value) {
    _Approve = value;
  }

  String get mobile => _mobile;

  set mobile(String value) {
    _mobile = value;
  }

  String get likecount => _likecount;

  set likecount(String value) {
    _likecount = value;
  }
}
