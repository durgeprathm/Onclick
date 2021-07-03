
import 'package:onclickproperty/NetworkHelper/network_helper_OnClick.dart';

class CompanyDetails {

  Future <dynamic> getCompanyDetails(String actionid) async
  {
    var map = new Map<String, dynamic>();
    map['actionId'] = actionid;

    String apifile = 'Fetch_Contact_Us_Data.php';
    NetworkHelperOnClick networkHelper = new NetworkHelperOnClick(apiname: apifile,data: map);
    var fetchfurnituretypedata = await networkHelper.getData();
    return fetchfurnituretypedata;
  }

}