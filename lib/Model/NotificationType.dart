class NotificationType{
  String _NotificationTypeID;
  String _NotificationTypeName;

  NotificationType(this._NotificationTypeID,this._NotificationTypeName);


  String get NotificationTypeID => _NotificationTypeID;

  set NotificationTypeID(String value) {
    _NotificationTypeID = value;
  }

  factory NotificationType.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return NotificationType(
        json['ItemsId'],
        json['ItemsName']);
  }

  static List<NotificationType> fromJsonList(List list) {
    if (list == null) return null;
    return list.map((item) => NotificationType.fromJson(item)).toList();
  }

  ///this method will prevent the override of toString
  String userAsString() {
    return '#${this.NotificationTypeID} ${this.NotificationTypeName}';
  }

  ///custom comparing function to check if two users are equal
  bool isEqual(NotificationType model) {
    return this?.NotificationTypeID == model?.NotificationTypeID;
  }


  @override
  String toString() => NotificationTypeName;

  String get NotificationTypeName => _NotificationTypeName;

  set NotificationTypeName(String value) {
    _NotificationTypeName = value;
  }
}