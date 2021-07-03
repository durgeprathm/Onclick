import 'package:async/async.dart';
import 'package:onclickproperty/const/shared_preference_constants.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UpdateAdvertisment {
  Future UpdateAdvertismentImage(
    String actionId,
    List images,
    String company_name,
    String company_type,
    String company_web,
    String company_email,
    String company_title,
    String company_description,
    String company_city,
    String area,
    String lat,
    String long,
    String pincode,
    String date,
    String adversement_id,
    String banner_image,
    String alternateno,
    String stdcode,
    String telphoneno,
  ) async {
    print("Inside Uploaddata Button $images");
    var User_id = await SharedPreferencesConstants.instance
        .getStringValue(SharedPreferencesConstants.USERID);
    String URL =
        "https://onclickproperty.com//Onclick_API/Updated_advertisment.php";
    var request = http.MultipartRequest("POST", Uri.parse(URL));

    if (actionId == '0') {
      for (var image in images) {
        var stream = http.ByteStream(DelegatingStream.typed(image.openRead()));
        final length = await image.length();
        request.files.add(http.MultipartFile(
          'img[]', // consider using a unique name per image here
          stream,
          length,
          filename: basename(image.path),
        ));
      }

      request.fields["actionId"] = actionId;
      request.fields["Userid"] = User_id;
      request.fields["companyname"] = company_name;
      request.fields["companytype"] = company_type;
      request.fields["companyweb"] = company_web;
      request.fields["companyemail"] = company_email;
      request.fields["companytitle"] = company_title;
      request.fields["companydescription"] = company_description;
      request.fields["companycity"] = company_city;
      request.fields["area"] = area;
      request.fields["lat"] = lat;
      request.fields["long"] = long;
      request.fields["pincode"] = pincode;
      request.fields["date"] = date;
      request.fields["adversementid"] = adversement_id;
      request.fields["alternateno"] = alternateno;
      request.fields["stdcode"] = stdcode;
      request.fields["telphoneno"] = telphoneno;
    } else if (actionId == '1') {
      request.fields["actionId"] = actionId;
      request.fields["Userid"] = User_id;
      request.fields["companyname"] = company_name;
      request.fields["companytype"] = company_type;
      request.fields["companyweb"] = company_web;
      request.fields["companyemail"] = company_email;
      request.fields["companytitle"] = company_title;
      request.fields["companydescription"] = company_description;
      request.fields["companycity"] = company_city;
      request.fields["area"] = area;
      request.fields["lat"] = lat;
      request.fields["long"] = long;
      request.fields["pincode"] = pincode;
      request.fields["date"] = date;
      request.fields["adversementid"] = adversement_id;
      request.fields["bannerimage"] = banner_image;
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
