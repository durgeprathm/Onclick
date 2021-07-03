import 'package:onclickproperty/NetworkHelper/network_helper_OnClick.dart';

class InsertForgetPassword {
  Future<dynamic> sendForgetPassword(
      String actionId, String username, String password) async {
    var map = new Map<String, dynamic>();
    switch (actionId) {
      case "0":
        {
          map['actionId'] = actionId;
          map['password'] = password;
          map['email'] = username;
        }
        break;

      case "1":
        {
          map['actionId'] = actionId;
          map['password'] = password;
          map['mobile'] = actionId;
        }
        break;
    }
    String apifile = 'Forget_Password.php';
    NetworkHelperOnClick networkHelper =
        new NetworkHelperOnClick(apiname: apifile, data: map);
    var insertdepartment = await networkHelper.getData();
    return insertdepartment;
  }
}
