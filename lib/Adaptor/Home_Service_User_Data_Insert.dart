import 'package:onclickproperty/NetworkHelper/network_helper_OnClick.dart';

class InsertHomeServiceUserData {
  Future<dynamic> getInsertHomeServiceUserData(
    String actionId,
    String SpID,
    String UserID,
    String full_Name,
    String Email_ID,
    String Mobile_Number,
    String date,
    String city,
    String area,
    String pincode,
    String lat,
    String long,
  ) async {
    var map = new Map<String, dynamic>();
    map['actionId'] = actionId;
    map['spid'] = SpID;
    map['uid'] = UserID;
    map['name'] = full_Name;
    map['email'] = Email_ID;
    map['mobileno'] = Mobile_Number;
    map['date'] = date;
    map['city'] = city;
    map['area'] = area;
    map['pincode'] = pincode;
    map['lat'] = lat;
    map['long'] = long;

    String apifile = 'Insert_Service_Provider_User_Data.php';
    NetworkHelperOnClick networkHelper =
        new NetworkHelperOnClick(apiname: apifile, data: map);
    var insertdepartment = await networkHelper.getData();
    return insertdepartment;
  }
}
