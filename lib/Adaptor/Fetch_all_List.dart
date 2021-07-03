import 'package:onclickproperty/NetworkHelper/network_helper_OnClick.dart';

class FetchAllLists {

  Future<dynamic> getallTypeList(String CityName,String usertype) async {

    var map = new Map<String, dynamic>();

      map['actionId'] = "0";
      map['cityname'] = CityName;
      map['usertype'] = usertype;

    String apifile = 'Fetch_all_typeLists.php';
    NetworkHelperOnClick networkHelper =
    new NetworkHelperOnClick(apiname: apifile, data: map);
    var fetchFeaturedata = await networkHelper.getData();
    return fetchFeaturedata;
  }
}
