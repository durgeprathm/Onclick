import 'package:onclickproperty/NetworkHelper/network_helper_OnClick.dart';

class FetchAllDashboardProperty {
  Future<dynamic> getFetchAllDashboardProperty(
      String actionid, String localityName,String localityPincode, String ptype) async {
    var map = new Map<String, dynamic>();

    map['actionId'] = actionid;
    map['localityname'] = localityName;
    map['propertytype'] = ptype;
    map['pincode'] = localityPincode;


    String apifile = 'Fetch_All_Dashboard_Details.php';
    NetworkHelperOnClick networkHelper =
        new NetworkHelperOnClick(apiname: apifile, data: map);
    var fetchelectronicproductsdata = await networkHelper.getData();
    return fetchelectronicproductsdata;
  }
}
