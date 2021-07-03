
import 'package:onclickproperty/NetworkHelper/network_helper_OnClick.dart';

class FetchServiceType {

  Future <dynamic> getserviceType(String actionid) async
  {
    var map = new Map<String, dynamic>();
    map['actionid'] = actionid;

    String apifile = 'fetch_homeserviceslist.php';
    NetworkHelperOnClick networkHelper = new NetworkHelperOnClick(apiname: apifile,data: map);
    var fetchFeaturedata = await networkHelper.getData();
    return fetchFeaturedata;
  }

}