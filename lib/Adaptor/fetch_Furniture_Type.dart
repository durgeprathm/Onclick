
import 'package:onclickproperty/NetworkHelper/network_helper_OnClick.dart';

class FetchFurnitureType {

  Future <dynamic> getFetchFurnitureType(String actionid) async
  {

    var map = new Map<String, dynamic>();
    map['ActionID'] = actionid;


    String apifile = 'Fetch_Furniture_Type.php';
    NetworkHelperOnClick networkHelper = new NetworkHelperOnClick(apiname: apifile,data: map);
    var fetchfurnituretypedata = await networkHelper.getData();
    return fetchfurnituretypedata;
  }

}