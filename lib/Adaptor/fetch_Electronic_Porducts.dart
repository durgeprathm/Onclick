import 'package:onclickproperty/NetworkHelper/network_helper_OnClick.dart';
import 'package:onclickproperty/const/shared_preference_constants.dart';

class FetchElectronicProducts {
  Future<dynamic> getFetchElectronicProducts(
      String checkid, String actionid, String itemid,String exceptid) async {
    var map = new Map<String, dynamic>();


    var location = await SharedPreferencesConstants.instance
        .getStringValue(SharedPreferencesConstants.CITY);
    var localityPincode = await SharedPreferencesConstants.instance
        .getStringValue(SharedPreferencesConstants.PINCODE);


    if (checkid == "1") {
      map['actionId'] = actionid;
      map['appliancestype'] = itemid;
    } else if (checkid == "2") {
      map['actionId'] = actionid;
      map['electonicid'] = exceptid;
      map['electonicappliancestypeid'] = itemid;
    }else if (checkid == "3") {
      map['actionId'] = actionid;
      map['electonicid'] = itemid;
    }else if (checkid == "4") {
      map['actionId'] = actionid;
      map['elecronicid'] = itemid;
    }

    map['localityname'] = location;
    map['pincode'] = localityPincode;

    String apifile = 'Fetch_All_Electronic_Details.php';
    NetworkHelperOnClick networkHelper =
        new NetworkHelperOnClick(apiname: apifile, data: map);
    var fetchelectronicproductsdata = await networkHelper.getData();
    return fetchelectronicproductsdata;
  }
}
