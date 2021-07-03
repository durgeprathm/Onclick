import 'package:async/async.dart';
import 'package:onclickproperty/const/shared_preference_constants.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UpdateServiceAdImageSubmit {
  Future ServiceAduploadData(
    String actionId,
    List listfile1,
    List listfile2,
    String aadharfront,
    String aadharback,
    String Name,
    String Mobile_no,
    String city,
    String pincode,
    String area,
    String lat,
    String long,
    String service_type,
    String Email,
    String adhar_no,
    String date,
    String service_id,
    String alternateno,
    String stdcode,
    String telphoneno,
  ) async {
    print("Inside Uploaddata Button $listfile1");
    var User_id = await SharedPreferencesConstants.instance
        .getStringValue(SharedPreferencesConstants.USERID);
    String URL = "https://onclickproperty.com//Onclick_API/Update_Services.php";
    var request = http.MultipartRequest("POST", Uri.parse(URL));
    if (actionId == '0') {
      //for front image
      for (var image in listfile1) {
        var stream = http.ByteStream(DelegatingStream.typed(image.openRead()));
        final length = await image.length();
        request.files.add(http.MultipartFile(
          'img[]', // consider using a unique name per image here
          stream,
          length,
          filename: basename(image.path),
        ));
      }

      //for back image
      for (var image in listfile2) {
        var stream = http.ByteStream(DelegatingStream.typed(image.openRead()));
        final length = await image.length();
        request.files.add(http.MultipartFile(
          'img2[]', // consider using a unique name per image here
          stream,
          length,
          filename: basename(image.path),
        ));
      }

      request.fields["actionId"] = actionId;
      request.fields["Name"] = Name;
      request.fields["Userid"] = User_id;
      request.fields["Mobileno"] = Mobile_no;
      request.fields["city"] = city;
      request.fields["pincode"] = pincode;
      request.fields["area"] = area;
      request.fields["lat"] = lat;
      request.fields["long"] = long;
      request.fields["servicetype"] = service_type;
      request.fields["Email"] = Email;
      request.fields["adharno"] = adhar_no;
      request.fields["date"] = date;
      request.fields["serviceid"] = service_id;
      request.fields["alternateno"] = alternateno;
      request.fields["stdcode"] = stdcode;
      request.fields["telphoneno"] = telphoneno;
    } else if (actionId == '1') {
      request.fields["actionId"] = actionId;
      request.fields["adharfront"] = aadharfront;
      request.fields["adharback"] = aadharback;
      request.fields["Name"] = Name;
      request.fields["Userid"] = User_id;
      request.fields["Mobileno"] = Mobile_no;
      request.fields["city"] = city;
      request.fields["pincode"] = pincode;
      request.fields["area"] = area;
      request.fields["lat"] = lat;
      request.fields["long"] = long;
      request.fields["servicetype"] = service_type;
      request.fields["Email"] = Email;
      request.fields["adharno"] = adhar_no;
      request.fields["date"] = date;
      request.fields["serviceid"] = service_id;
      request.fields["alternateno"] = alternateno;
      request.fields["stdcode"] = stdcode;
      request.fields["telphoneno"] = telphoneno;
    }

    http.Response response =
        await http.Response.fromStream(await request.send());
    Map<String, dynamic> jsonObject = json.decode(response.body);
    return jsonObject;
  }
}
