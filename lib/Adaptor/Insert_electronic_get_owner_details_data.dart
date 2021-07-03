import 'package:onclickproperty/NetworkHelper/network_helper_OnClick.dart';

class InsertElectronicGetOwnerDetails{
  Future<dynamic> insertElectronicGetOwnerDetails(
      String actionId,
      String userid,
      String username,
      String Electronicid,
      String email,
      String mobileno,
      String date,) async {
    var map = new Map<String, dynamic>();
    map['actionId'] = actionId;
    map['userid'] = userid;
    map['name'] = username;
    map['Electronicid'] = Electronicid;
    map['email'] = email;
    map['mobileno'] = mobileno;
    map['date'] = date;

    String apifile = 'Insert_Electronic_User_Data.php';
    NetworkHelperOnClick networkHelper =
    new NetworkHelperOnClick(apiname: apifile, data: map);
    var insertdepartment = await networkHelper.getData();
    return insertdepartment;
  }
}
