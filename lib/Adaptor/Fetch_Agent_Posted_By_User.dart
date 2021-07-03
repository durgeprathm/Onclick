import 'package:onclickproperty/NetworkHelper/network_helper_OnClick.dart';
import 'package:onclickproperty/const/shared_preference_constants.dart';

class FetchUserPostedLoanAgent {
  Future<dynamic> getFetchUserPostedLoanAgentt(String Checkid,String Agentid) async {
    var UserId = await SharedPreferencesConstants.instance
        .getStringValue(SharedPreferencesConstants.USERID);
    var map = new Map<String, dynamic>();
    if (Checkid == "0") {
      map['actionId'] = "2";
      map['Userid'] = UserId;
    } else if (Checkid == "1") {
      map['actionId'] = "3";
      map['Userid'] = UserId;
    } else if (Checkid == "2") {
      map['actionId'] = "4";
      map['Agentid'] = Agentid;
    }else if (Checkid == "3") {
      map['actionId'] = "5";
      map['Rentalagentid'] = Agentid;
    }

    String apifile = 'Fetch_Agent_Details.php';
    NetworkHelperOnClick networkHelper =
    new NetworkHelperOnClick(apiname: apifile, data: map);
    var fetchUserpostedloanagent = await networkHelper.getData();
    return fetchUserpostedloanagent;
  }
}