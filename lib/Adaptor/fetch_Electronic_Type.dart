
import 'package:onclickproperty/NetworkHelper/network_helper_OnClick.dart';

class FetchElectronicType {

  Future <dynamic> getFetchElectronicType(String actionid) async
  {
    var map = new Map<String, dynamic>();
    map['ActionID'] = actionid;

    String apifile = 'Fetch_Electronic_Type.php';
    NetworkHelperOnClick networkHelper = new NetworkHelperOnClick(apiname: apifile,data: map);
    var fetchfurnituretypedata = await networkHelper.getData();
    return fetchfurnituretypedata;
  }

}