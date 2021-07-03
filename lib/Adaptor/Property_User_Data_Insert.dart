import 'package:onclickproperty/NetworkHelper/network_helper_OnClick.dart';

class InsertPropertyUserData {
  Future<dynamic> getInsertPropertyUserData(
      String actionId,
      String PropertyID,
      String UserID,
      String full_Name,
      String Email_ID,
      String Mobile_Number,
      String Date,
      ) async {
    var map = new Map<String, dynamic>();
    map['actionId'] = actionId;
    map['PropertyID'] = PropertyID;
    map['uid'] = UserID;
    map['name'] = full_Name;
    map['email'] = Email_ID;
    map['mobileno'] = Mobile_Number;
    map['date'] = Date;


    String apifile = 'Insert_Property_User_Data.php';
    NetworkHelperOnClick networkHelper =
        new NetworkHelperOnClick(apiname: apifile, data: map);
    var insertdepartment = await networkHelper.getData();
    return insertdepartment;
  }
}
