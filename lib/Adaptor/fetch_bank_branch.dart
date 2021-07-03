import 'package:onclickproperty/NetworkHelper/network_helper_OnClick.dart';

class FetchBankBranch {
  Future<dynamic> getFetchBankBranch(String actionid) async {
    var map = new Map<String, dynamic>();
    map['actionId'] = actionid;

    String apifile = 'Fetch_Banks_For_Bank_Loan.php';
    NetworkHelperOnClick networkHelper =
        new NetworkHelperOnClick(apiname: apifile, data: map);
    var fetchpropertytypedata = await networkHelper.getData();
    return fetchpropertytypedata;
  }
}
