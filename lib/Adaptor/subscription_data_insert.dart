import 'package:onclickproperty/NetworkHelper/network_helper_OnClick.dart';
import 'package:onclickproperty/const/shared_preference_constants.dart';

class SubscriptionDataInsert {
  Future<dynamic> getSubscriptionDataInsert(
      String amount,
      String Productinfo,
      String date,
      String datetime,
      String status,
      String usertranscationid,
      String orderid,
      String signatureid,
      String paymenttype) async {
    var userid = await SharedPreferencesConstants.instance
        .getStringValue(SharedPreferencesConstants.USERID);
    var uName = await SharedPreferencesConstants.instance
        .getStringValue(SharedPreferencesConstants.USERFULLNAME);
    var uEmail = await SharedPreferencesConstants.instance
        .getStringValue(SharedPreferencesConstants.USEREMAILID);
    var uMobNo = await SharedPreferencesConstants.instance
        .getStringValue(SharedPreferencesConstants.USERMOBNO);
    var map = new Map<String, dynamic>();
    map['actionId'] = "0";
    map['amount'] = amount;
    map['name'] = uName;
    map['Email'] = uEmail;
    map['mobileno'] = uMobNo;
    map['Productinfo'] = Productinfo;
    map['date'] = date;
    map['datetime'] = datetime;
    map['status'] = status;

    map['userid'] = userid;
    map['usertranscationid'] = usertranscationid;
    map['orderid'] = orderid;
    map['signatureid'] = signatureid;
    map['paymenttype'] = paymenttype;

    String apifile = 'Insert_Transcation_Details.php';
    NetworkHelperOnClick networkHelper =
        new NetworkHelperOnClick(apiname: apifile, data: map);
    var insertdepartment = await networkHelper.getData();
    return insertdepartment;
  }
}
