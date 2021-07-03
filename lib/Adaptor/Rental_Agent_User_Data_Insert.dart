import 'package:onclickproperty/NetworkHelper/network_helper_OnClick.dart';

class InsertRentalAgentUserData {
  Future<dynamic> getInsertRentalAgentUserData(
      String actionId,
      String AgentID,
      String full_Name,
      String Mobile_Number,
      String Email_ID,
      String city,
      String area,
      String date,
      String alternateno,
      String stdcode,
      String telphoneno,
      String pincode,
      String lat,
      String long) async {
    var map = new Map<String, dynamic>();
    map['actionId'] = actionId;
    map['uid'] = AgentID;
    map['name'] = full_Name;
    map['mobileno'] = Mobile_Number;
    map['email'] = Email_ID;
    map['city'] = city;
    map['area'] = area;
    map['date'] = date;
    map['alternateno'] = alternateno;
    map['stdcode'] = stdcode;
    map['telphoneno'] = telphoneno;
    map['pincode'] = pincode;
    map['lat'] = lat;
    map['long'] = long;

    String apifile = 'Insert_Rental_Agent_User_Data.php';
    NetworkHelperOnClick networkHelper =
    new NetworkHelperOnClick(apiname: apifile, data: map);
    var insertdepartment = await networkHelper.getData();
    return insertdepartment;
  }
}
