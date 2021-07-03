import 'package:onclickproperty/NetworkHelper/network_helper_OnClick.dart';
import 'package:onclickproperty/const/shared_preference_constants.dart';

class FetchPropertyDetails{
  Future<dynamic> getFetchPropertyDetails(
      String checkid, String actionid, String itemid,String PropertyTypeid,String CityName) async {
    var map = new Map<String, dynamic>();
    var UID = await SharedPreferencesConstants.instance
        .getStringValue(SharedPreferencesConstants.USERID);

    if (checkid == "0") {
      map['actionId'] = actionid;
      map['propertyid'] = itemid;
      map['propertytype'] = PropertyTypeid;
      map['uid'] = UID;
    }else if(checkid == "1")
      {
        map['actionId'] = actionid;
        map['propertyid'] = itemid;
        map['propertytype'] = PropertyTypeid;
        map['localityname'] = CityName;
      }else if(checkid == "2")
    {
      map['actionId'] = actionid;
      map['propertyid'] = itemid;
    }

    String apifile = 'Fetch_Property_Details.php';
    NetworkHelperOnClick networkHelper =
        new NetworkHelperOnClick(apiname: apifile, data: map);
    var fetchPropertyDetailsdata = await networkHelper.getData();
    return fetchPropertyDetailsdata;
  }
}
