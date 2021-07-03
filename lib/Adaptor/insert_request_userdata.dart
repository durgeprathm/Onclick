import 'package:onclickproperty/NetworkHelper/network_helper_OnClick.dart';

class InsertUserRequest {
  Future<dynamic> insertUserRequest(
    String actionId,
    String userid,
    String Username,
    String Furnitureid,
    String email,
    String mobileno,
    String date,
  ) async {
    var map = new Map<String, dynamic>();
    map['actionId'] = actionId;
    map['userid'] = userid;
    map['name'] = Username;
    map['Furnitureid'] = Furnitureid;
    map['email'] = email;
    map['mobileno'] = mobileno;
    map['date'] = date;

    String apifile = 'Insert_Furniture_User_Data.php';
    NetworkHelperOnClick networkHelper =
        new NetworkHelperOnClick(apiname: apifile, data: map);
    var insertdepartment = await networkHelper.getData();
    return insertdepartment;
  }
}
