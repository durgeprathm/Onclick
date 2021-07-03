import 'package:onclickproperty/NetworkHelper/network_helper_OnClick.dart';

class InsertFavList {
  Future<dynamic> getInsertFavList(
      String actionId, String userid, String pid, String datetime) async {
    var map = new Map<String, dynamic>();
    map['actionId'] = actionId;
    map['userid'] = userid;
    map['pid'] = pid;
    map['datetime'] = datetime;

    String apifile = 'insert_like_property.php';
    NetworkHelperOnClick networkHelper =
        new NetworkHelperOnClick(apiname: apifile, data: map);
    var insertdepartment = await networkHelper.getData();
    return insertdepartment;
  }
}
