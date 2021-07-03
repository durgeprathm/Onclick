
import 'package:onclickproperty/NetworkHelper/network_helper_OnClick.dart';

class FetchLikeByData {

  Future <dynamic> getFetchLikeByData(String actionid,String Propertieid) async
  {
    var map = new Map<String, dynamic>();
    map['ActionID'] = actionid;
    map['postid'] = Propertieid;

    String apifile = 'Fetch_Property_Like_By_Details.php';
    NetworkHelperOnClick networkHelper = new NetworkHelperOnClick(apiname: apifile,data: map);
    var FetchLikeByData = await networkHelper.getData();
    return FetchLikeByData;
  }

}