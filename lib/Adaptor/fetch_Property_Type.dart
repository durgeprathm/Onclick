
import 'package:onclickproperty/NetworkHelper/network_helper_OnClick.dart';

class FetchPropertyType {

  Future <dynamic> getFetchPropertyType(String actionid,String type) async
  {
    var map = new Map<String, dynamic>();
    if(actionid=='0')
      {
        map['ActionID'] = actionid;
      }else if(actionid == '1')
      {
        map['ActionID'] = actionid;
        map['SubMainPropertyTypeID'] = type;
      }


    String apifile = 'Fetch_Property_Type.php';
    NetworkHelperOnClick networkHelper = new NetworkHelperOnClick(apiname: apifile,data: map);
    var fetchpropertytypedata = await networkHelper.getData();
    return fetchpropertytypedata;
  }

}