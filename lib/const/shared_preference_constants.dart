import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesConstants {
  SharedPreferencesConstants._privateConstructor();

  static const String USERNAME = 'username';
  static const String USERFULLNAME = 'userfullname';
  static const String USERID = 'userid';
  static const String USEREMAILID = 'email';
  static const String USERMOBNO = 'mobno';
  static const String LOGGEDIN = 'loggedin';
  static const String INTROSCREENCHECK = 'introcheck';
  static const String CITY = 'city';
  static const String PINCODE = 'pincode';
  static const String USERPROFILEPIC = 'userprofilepic';

  static final SharedPreferencesConstants instance =
      SharedPreferencesConstants._privateConstructor();

  setBooleanValue(String key, bool value) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    myPrefs.setBool(key, value);
  }

  Future<bool> getBooleanValue(String key) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.getBool(key) ?? false;
  }

  setStringValue(String key, String value) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    myPrefs.setString(key, value);
  }

  Future<String> getStringValue(String key) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.getString(key) ?? '';
  }

  setIntegerValue(String key, int value) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    myPrefs.setInt(key, value);
  }

  Future<int> getIntegerValue(String key) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.getInt(key) ?? 0;
  }

  setDoubleValue(String key, double value) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    myPrefs.setDouble(key, value);
  }

  Future<double> getDoubleValue(String key) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.getDouble(key) ?? 0;
  }

  setStringListValue(String key, List<String> value) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    myPrefs.setStringList(key, value);
  }

  Future<List<String>> getStringListValue(String key) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.getStringList(key);
  }

  removeAll() async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    myPrefs.remove(USERNAME);
    myPrefs.remove(USERFULLNAME);
    myPrefs.remove(USERID);
    myPrefs.remove(USEREMAILID);
    myPrefs.remove(USERMOBNO);
    myPrefs.remove(LOGGEDIN);
    myPrefs.remove(CITY);
  }
}
