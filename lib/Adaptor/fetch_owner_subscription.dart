import 'package:onclickproperty/NetworkHelper/network_helper_OnClick.dart';
import 'package:onclickproperty/const/shared_preference_constants.dart';

class FetchOwnerSubscription {
  Future<dynamic> getOwnerSubscription(String actionid) async {
    var userid = await SharedPreferencesConstants.instance
        .getStringValue(SharedPreferencesConstants.USERID);

    var map = new Map<String, dynamic>();
    map['actionId'] = actionid;
    map['Userid'] = userid;

    String apifile = 'Fetch_subscription_data.php';
    NetworkHelperOnClick networkHelper =
        new NetworkHelperOnClick(apiname: apifile, data: map);
    var fetchFeaturedata = await networkHelper.getData();
    return fetchFeaturedata;
  }
}
