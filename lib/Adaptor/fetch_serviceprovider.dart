import 'package:onclickproperty/NetworkHelper/network_helper_OnClick.dart';
import 'package:onclickproperty/const/shared_preference_constants.dart';

class FetchServiceProvider {
  Future<dynamic> getserviceProviders(
      String actionid, String location, String servicetype) async {
    var localityPincode = await SharedPreferencesConstants.instance
        .getStringValue(SharedPreferencesConstants.PINCODE);
    var map = new Map<String, dynamic>();

    print(actionid);
    print(servicetype);
    print(location);
    print(localityPincode);

    map['actionid'] = actionid;
    map['stype'] = servicetype;
    map['localityname'] = location;
    map['pincode'] = localityPincode;

    String apifile = 'fetch_serviceproviders.php';
    NetworkHelperOnClick networkHelper =
        new NetworkHelperOnClick(apiname: apifile, data: map);
    var fetchFeaturedata = await networkHelper.getData();
    return fetchFeaturedata;
  }
}
