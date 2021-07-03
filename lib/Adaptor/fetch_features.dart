
import 'package:onclickproperty/NetworkHelper/network_helper_OnClick.dart';

class FetchFeatureType {

    Future <dynamic> getFetchFeaturesType(String actionid) async
  {
    var map = new Map<String, dynamic>();
    map['ActionID'] = "0";

    String apifile = 'Fetch_Features.php';
    NetworkHelperOnClick networkHelper = new NetworkHelperOnClick(apiname: apifile,data: map);
    var fetchFeaturedata = await networkHelper.getData();
    return fetchFeaturedata;
  }

}