import 'package:onclickproperty/NetworkHelper/network_helper_OnClick.dart';
import 'package:onclickproperty/const/shared_preference_constants.dart';

class NewTokenInsert {
  Future<dynamic> getNewTokenInsert(
    String token,
  ) async {
    var UID = await SharedPreferencesConstants.instance
        .getStringValue(SharedPreferencesConstants.USERID);

    var map = new Map<String, dynamic>();
    map['userid'] = UID;
    map['token'] = token;

    String apifile = 'Update_Token.php';
    NetworkHelperOnClick networkHelper =
        new NetworkHelperOnClick(apiname: apifile, data: map);
    var insertdepartment = await networkHelper.getData();
    return insertdepartment;
  }
}
