import 'package:onclickproperty/NetworkHelper/network_helper_OnClick.dart';

class FetchPayKey {

  Future <dynamic> getFetchPayKey(String actionid) async
  {
    var map = new Map<String, dynamic>();
    map['ActionID'] = actionid;

    String apifile = 'Fetch_Key.php';
    NetworkHelperOnClick networkHelper = new NetworkHelperOnClick(
        apiname: apifile, data: map);
    var fetchfurnituretypedata = await networkHelper.getData();
    return fetchfurnituretypedata;
  }

}