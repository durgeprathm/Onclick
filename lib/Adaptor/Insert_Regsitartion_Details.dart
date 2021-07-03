import 'package:onclickproperty/NetworkHelper/network_helper_OnClick.dart';

class RegistrationDetailsInsert {
  Future<dynamic> getRegistrationDetailsInsert(
      String actionId,
      String full_Name,
      String profile,
      String Date,
      String Email_ID,
      String Mobile_Number,
      String token) async {
    var map = new Map<String, dynamic>();
    map['actionId'] = actionId;
    map['fullname'] = full_Name;
    map['profile'] = profile;
    map['date'] = Date;
    map['email'] = Email_ID;
    map['phone_no'] = Mobile_Number;
    map['token'] = token;

    String apifile = 'Insert_Registration_Details.php';
    NetworkHelperOnClick networkHelper =
        new NetworkHelperOnClick(apiname: apifile, data: map);
    var insertdepartment = await networkHelper.getData();
    return insertdepartment;
  }
}
