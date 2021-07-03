import 'package:onclickproperty/NetworkHelper/network_helper_OnClick.dart';
import 'package:onclickproperty/const/shared_preference_constants.dart';

class UserPostedItemsAdapoter{
  Future<dynamic> getUserPostedItemsAdapoter(
      String checkid) async {
    var map = new Map<String, dynamic>();
    var UID = await SharedPreferencesConstants.instance
        .getStringValue(SharedPreferencesConstants.USERID);

    if (checkid == "0") {
      map['actionId'] = "6";
      map['pagenumber'] = '1';
      map['Userid'] = UID;
    }else if(checkid == "1")
    {
      map['actionId'] = "7";
      map['pagenumber'] = "1";
      map['Userid'] = UID;
    }

    String apifile = 'Fetch_user_Posted_things.php';
    NetworkHelperOnClick networkHelper =
    new NetworkHelperOnClick(apiname: apifile, data: map);
    var fetchPropertyDetailsdata = await networkHelper.getData();
    return fetchPropertyDetailsdata;
  }
}
