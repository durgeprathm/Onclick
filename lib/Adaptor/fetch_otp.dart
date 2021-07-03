import 'package:onclickproperty/NetworkHelper/network_helper_OnClick.dart';

class FetchOTP {
  Future<dynamic> FetchOTPData(String actionId, String userName) async {
    var map = new Map<String, dynamic>();
    switch (actionId) {
      case "0":
        {
          map['actionId'] = actionId;
          map['mobile'] = userName;
        }
        break;

      case "1":
        {
          map['actionId'] = actionId;
          map['email'] = userName;
        }
        break;

      case "2":
        {
          map['actionId'] = actionId;
          map['mobile'] = userName;
        }
        break;
      case "3":
        {
          map['actionId'] = actionId;
          map['mobile'] = userName;
        }
        break;
    }

    String apifile = 'Send_OTP.php';
    NetworkHelperOnClick networkHelper =
        new NetworkHelperOnClick(apiname: apifile, data: map);
    var fetchlogindata = await networkHelper.getData();
    return fetchlogindata;
  }
}
