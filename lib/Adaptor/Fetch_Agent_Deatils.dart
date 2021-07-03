import 'package:onclickproperty/NetworkHelper/network_helper_OnClick.dart';

class FetchAgentList {
  Future<dynamic> getFetchAgentList(
      String Checkid, String actionid, String CityName) async {
    var map = new Map<String, dynamic>();
    if (Checkid == "0") {
      map['actionId'] = actionid;
      map['Locality'] = CityName;
    } else if (Checkid == "1") {
      map['actionId'] = actionid;
      map['Locality'] = CityName;
    }

    String apifile = 'Fetch_Agent_Details.php';
    NetworkHelperOnClick networkHelper =
        new NetworkHelperOnClick(apiname: apifile, data: map);
    var fetchFeaturedata = await networkHelper.getData();
    return fetchFeaturedata;
  }
}
