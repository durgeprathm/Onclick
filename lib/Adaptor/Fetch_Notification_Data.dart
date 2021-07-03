import 'package:onclickproperty/NetworkHelper/network_helper_OnClick.dart';
import 'package:onclickproperty/const/shared_preference_constants.dart';

class FetchNotification {
  Future<dynamic> getFetchNotification(String actionid, String itemsid) async {
    var map = new Map<String, dynamic>();

    var Userid = await SharedPreferencesConstants.instance
        .getStringValue(SharedPreferencesConstants.USERID);

    // fetching all notification
    if (actionid == "0") {
      map['actionId'] = actionid;
      map['userid'] = Userid;

      //upadting notification status
    } else if (actionid == "1") {
      map['actionId'] = actionid;
      map['notificationId'] = itemsid;

      // fetching notification type
    }else if (actionid == "2") {
      map['actionId'] = actionid;
      map['userid'] = Userid;

      // fetching According to  notification type and userid
    }else if (actionid == "3") {
      map['actionId'] = actionid;
      map['notificationitem'] = itemsid;
      map['userid'] = Userid;
    }
    // fetching  notification Count
    else if (actionid == "4") {
      map['actionId'] = actionid;
      map['notificationuserid'] = Userid;
    }


    String apifile = 'Fetch_Notification_Details.php';
    NetworkHelperOnClick networkHelper =
        new NetworkHelperOnClick(apiname: apifile, data: map);
    var fetchnotificationdata = await networkHelper.getData();
    return fetchnotificationdata;
  }
}
