import 'package:onclickproperty/NetworkHelper/network_helper_OnClick.dart';
import 'package:onclickproperty/const/shared_preference_constants.dart';

class UserPostedItemsCount {
  Future<dynamic> getUserPostedItemsCount(String ActionID) async {

    var userid = await SharedPreferencesConstants.instance
        .getStringValue(SharedPreferencesConstants.USERID);

    var map = new Map<String, dynamic>();
    map['actionId'] = ActionID;
    map['Userid'] = userid;

    String apifile = 'User_Posted_Items_Count.php';
    NetworkHelperOnClick networkHelper =
    new NetworkHelperOnClick(apiname: apifile, data: map);
    var UserPostedItemsCountdata = await networkHelper.getData();
    return UserPostedItemsCountdata;
  }
}
