import 'package:onclickproperty/NetworkHelper/network_helper_OnClick.dart';
import 'package:onclickproperty/const/shared_preference_constants.dart';

class InsertDataNotification {
  Future<dynamic> getInsertDataNotification(
      String actionId,String itemid,String Perticularitemid) async {
    var map = new Map<String, dynamic>();

    var userid = await SharedPreferencesConstants.instance
        .getStringValue(SharedPreferencesConstants.USERID);

    //notification for property post
    if (actionId == '0')
    {
      print("Call Action ID///////// ${actionId}");
      print("Call userid///////// ${userid}");
      print("Call locality///////// ${itemid}");
      print("Call propertyid///////// ${Perticularitemid}");

      map['actionId'] = actionId.toString();
      map['userid'] = userid.toString();
      map['locality'] = itemid.toString();
      map['propertyid'] = Perticularitemid.toString();
    }
    //notification for property like
    else if (actionId == '1')
    {
      print("Call Action ID///////// ${actionId}");
      print("Call userid///////// ${userid}");
      print("Call pid///////// ${itemid}");

      map['actionId'] = actionId.toString();
      map['userid'] = userid.toString();
      map['pid'] = itemid.toString();
    }
    //notification for property  details seen
    else if (actionId == '2')
    {
      print("Call Action ID///////// ${actionId}");
      print("Call userid///////// ${userid}");
      print("Call pid///////// ${itemid}");

      map['actionId'] = actionId;
      map['userid'] = userid;
      map['pid'] = itemid;
    }
    //notification for Furniture  post
    else if (actionId == '3')
    {
      print("Call Action ID///////// ${actionId}");
      print("Call userid///////// ${userid}");
      print("Call locality///////// ${itemid}");
      print("Call furnitureid///////// ${Perticularitemid}");

      map['actionId'] = actionId.toString();
      map['userid'] = userid.toString();
      map['locality'] = itemid.toString();
      map['furnitureid'] = Perticularitemid.toString();
    }
    //notification for Furniture  details seen
    else if (actionId == '4')
    {
      print("Call Action ID///////// ${actionId}");
      print("Call userid///////// ${userid}");
      print("Call FurnitureID///////// ${itemid}");

      map['actionId'] = actionId;
      map['userid'] = userid;
      map['FurnitureID'] = itemid;
    }

    //notification for Electonic  post
    else if (actionId == '5')
    {
      print("Call Action ID///////// ${actionId}");
      print("Call userid///////// ${userid}");
      print("Call locality///////// ${itemid}");
      print("Call Electonicid///////// ${Perticularitemid}");

      map['actionId'] = actionId.toString();
      map['userid'] = userid.toString();
      map['locality'] = itemid.toString();
      map['Electonicid'] = Perticularitemid.toString();
    }
    //notification for Electonic  details seen
    else if (actionId == '6')
    {
      print("Call Action ID///////// ${actionId}");
      print("Call userid///////// ${userid}");
      print("Call electonicID///////// ${itemid}");

      map['actionId'] = actionId;
      map['userid'] = userid;
      map['electonicID'] = itemid;
    }

    //notification for service  post
    else if (actionId == '7')
    {
      print("Call Action ID///////// ${actionId}");
      print("Call userid///////// ${userid}");
      print("Call locality///////// ${itemid}");
      print("Call ServiceID///////// ${Perticularitemid}");

      map['actionId'] = actionId.toString();
      map['userid'] = userid.toString();
      map['locality'] = itemid.toString();
      map['ServiceID'] = Perticularitemid.toString();
    }
    //notification for service  details seen
    else if (actionId == '8')
    {
      print("Call Action ID///////// ${actionId}");
      print("Call userid///////// ${userid}");
      print("Call ServiceID///////// ${itemid}");

      map['actionId'] = actionId;
      map['userid'] = userid;
      map['ServiceID'] = itemid;
    }
    //notification for LOAn Agent Data  POST
    else if (actionId == '9')
    {
      print("Call Action ID///////// ${actionId}");
      print("Call userid///////// ${userid}");
      print("Call locality///////// ${itemid}");
      print("Call LoanagentID///////// ${Perticularitemid}");

      map['actionId'] = actionId.toString();
      map['userid'] = userid.toString();
      map['locality'] = itemid.toString();
      map['LoanagentID'] = Perticularitemid.toString();
    }
    //notification for LOAn Agent  details seen
    else if (actionId == '10')
    {
      print("Call Action ID///////// ${actionId}");
      print("Call userid///////// ${userid}");
      print("Call LoanAgentID///////// ${itemid}");

      map['actionId'] = actionId;
      map['userid'] = userid;
      map['LoanAgentID'] = itemid;
    }
    //notification for Rental Agent Data  POST
    else if (actionId == '11')
    {
      print("Call Action ID///////// ${actionId}");
      print("Call userid///////// ${userid}");
      print("Call locality///////// ${itemid}");
      print("Call RentalagentID///////// ${Perticularitemid}");

      map['actionId'] = actionId.toString();
      map['userid'] = userid.toString();
      map['locality'] = itemid.toString();
      map['RentalagentID'] = Perticularitemid.toString();
    }
    //notification for Rental Agent  details seen
    else if (actionId == '12')
    {
      print("Call Action ID///////// ${actionId}");
      print("Call userid///////// ${userid}");
      print("Call RentalAgentID///////// ${itemid}");

      map['actionId'] = actionId;
      map['userid'] = userid;
      map['RentalAgentID'] = itemid;
    }

    print("MY MAP OBJECT???///${map.toString()}");



    String apifile = 'push_notification.php';
    NetworkHelperOnClick networkHelper =
        new NetworkHelperOnClick(apiname: apifile, data: map);
    var insertdatanotification = await networkHelper.getData();
    return insertdatanotification;
  }
}
