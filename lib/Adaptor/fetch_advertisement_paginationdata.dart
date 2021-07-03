import 'package:onclickproperty/NetworkHelper/network_helper_OnClick.dart';

import '../const/shared_preference_constants.dart';

class FetchAdvertisementsList {
  Future<dynamic> getFetchAdvertisementsPostedByUserList(
    String actionid,
    String pageno,
  ) async {
    var map = new Map<String, dynamic>();
    var CITYNAME = await SharedPreferencesConstants.instance
        .getStringValue(SharedPreferencesConstants.CITY);
    var UID = await SharedPreferencesConstants.instance
        .getStringValue(SharedPreferencesConstants.USERID);

    map['actionId'] = actionid;
    map['Userid'] = UID;
    map['pagenumber'] = pageno;

    String apifile = 'Fetch_user_Posted_things.php';
    NetworkHelperOnClick networkHelper =
        new NetworkHelperOnClick(apiname: apifile, data: map);
    var fetchelectronicproductsdata = await networkHelper.getData();
    return fetchelectronicproductsdata;
  }
}
