class Notificationitems {
  String _notification_Id;
  String _notification_userid;
  String _notification_title;
  String _notification_body;
  String _notification_itemID;
  String _notification_item;
  String _notification_date;
  String _notification_status;
  String _notificationitems_subtype;
  String _notification_forwhat;

  Notificationitems(
    this._notification_Id,
    this._notification_userid,
    this._notification_title,
    this._notification_body,
    this._notification_itemID,
    this._notification_item,
    this._notificationitems_subtype,
    this._notification_date,
    this._notification_status,
    this._notification_forwhat,
  );

  String get notification_status => _notification_status;

  set notification_status(String value) {
    _notification_status = value;
  }

  String get notification_date => _notification_date;

  set notification_date(String value) {
    _notification_date = value;
  }

  String get notification_item => _notification_item;

  set notification_item(String value) {
    _notification_item = value;
  }

  String get notification_itemID => _notification_itemID;

  set notification_itemID(String value) {
    _notification_itemID = value;
  }

  String get notification_body => _notification_body;

  set notification_body(String value) {
    _notification_body = value;
  }

  String get notification_title => _notification_title;

  set notification_title(String value) {
    _notification_title = value;
  }

  String get notification_userid => _notification_userid;

  set notification_userid(String value) {
    _notification_userid = value;
  }

  String get notification_Id => _notification_Id;

  set notification_Id(String value) {
    _notification_Id = value;
  }

  String get notification_forwhat => _notification_forwhat;

  set notification_forwhat(String value) {
    _notification_forwhat = value;
  }

  String get notificationitems_subtype => _notificationitems_subtype;

  set notificationitems_subtype(String value) {
    _notificationitems_subtype = value;
  }
}
