import 'package:onclickproperty/NetworkHelper/network_helper_OnClick.dart';

class ContactUsDetailsInsert {
  Future<dynamic> getContactUsDetailsInsert(String actionId, String full_Name,
      String Email_ID, String Mobile_Number, String message) async {
    var map = new Map<String, dynamic>();
    map['actionId'] = actionId;
    map['name'] = full_Name;
    map['email'] = Email_ID;
    map['mobile'] = Mobile_Number;
    map['message'] = message;

    String apifile = 'Mail_Contact_Us.php';
    NetworkHelperOnClick networkHelper =
        new NetworkHelperOnClick(apiname: apifile, data: map);
    var insertdepartment = await networkHelper.getData();
    return insertdepartment;
  }
}
