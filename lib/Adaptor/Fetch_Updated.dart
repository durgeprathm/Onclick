import 'package:onclickproperty/NetworkHelper/network_helper_OnClick.dart';

class FetchUpdateList {
  Future<dynamic> getFetchUpdateList(
      String Checkid, String actionid, String id) async {
    var map = new Map<String, dynamic>();
    if (Checkid == "0") {
      map['actionId'] = actionid;
      map['id'] = id;
    }else if (Checkid == "1") {
      map['actionId'] = actionid;
      map['id'] = id;
    }

    String apifile = 'Fetch_user_Posted_things.php';
    NetworkHelperOnClick networkHelper =
    new NetworkHelperOnClick(apiname: apifile, data: map);
    var fetchupdateddata = await networkHelper.getData();
    return fetchupdateddata;
  }
}
