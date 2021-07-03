
import 'package:onclickproperty/NetworkHelper/network_helper_OnClick.dart';

class FetchBHKType {

  Future <dynamic> getFetchBHKType(String actionid) async
  {
    var map = new Map<String, dynamic>();
    map['ActionID'] = actionid;

    String apifile = 'Fetch_HouseType.php';
    NetworkHelperOnClick networkHelper = new NetworkHelperOnClick(apiname: apifile,data: map);
    var fetchbhktypedata = await networkHelper.getData();
    return fetchbhktypedata;
  }

}