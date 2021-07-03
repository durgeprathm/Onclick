import 'package:onclickproperty/NetworkHelper/network_helper_OnClick.dart';

class FetchLogin {
  Future<dynamic> FetchLoginData(String user, String pass, String token) async {
    var map = new Map<String, dynamic>();
    map['username'] = user;
    map['password'] = pass;
    map['token'] = token;

    String apifile = 'Login_Details.php';
    NetworkHelperOnClick networkHelper =
        new NetworkHelperOnClick(apiname: apifile, data: map);
    var fetchlogindata = await networkHelper.getData();
    return fetchlogindata;
  }
}
