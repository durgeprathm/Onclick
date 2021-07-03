import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkHelperOnClick {
  NetworkHelperOnClick({this.apiname, this.data});

  final String apiname;
  var data;
  final String baseurl = "https://onclickproperty.com//Onclick_API/";

  Future getData() async
  {
    String surl = baseurl + apiname;
    var url = Uri.parse(surl);
    var response = await http.post(url, body: data);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print("Inside networkHelper : //////$data");
      return data;
    }
    else {
      print(response.statusCode);
      print("Inside Helper else: //////$data");
    }
  }
}