import 'package:async/async.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AdvertisementImageSubmit {
  Future AdvertisementuploadData(
      List images,
      String u_id,
      String company_name,
      String company_type,
      String company_web,
      String company_title,
      String company_description,
      String company_area,
      String company_city,
      String company_Pincode,
      String date,
      String company_email,
      String lat,
      String long,
      String alertnate_no,
      String std_code,
      String telphone_no) async {
    print("Inside Uploaddata Button $images");

    String URL =
        "https://onclickproperty.com//Onclick_API/Insert_Advertisements_Details.php";
    var request = http.MultipartRequest("POST", Uri.parse(URL));

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
    request.fields["actionId"] = "0";
    request.fields["uid"] = u_id;
    request.fields["companyname"] = company_name;
    request.fields["companytype"] = company_type;
    request.fields["companyweb"] = company_web;
    request.fields["companytitle"] = company_title;
    request.fields["companydescription"] = company_description;
    request.fields["area"] = company_area;
    request.fields["companycity"] = company_city;
    request.fields["pincode"] = company_Pincode;
    request.fields["date"] = date;
    request.fields["companyemail"] = company_email;
    request.fields["lat"] = lat;
    request.fields["long"] = long;
    request.fields["alertnateno"] = alertnate_no;
    request.fields["stdcode"] = std_code;
    request.fields["telphoneno"] = telphone_no;

    http.Response response =
        await http.Response.fromStream(await request.send());
    Map<String, dynamic> jsonObject = json.decode(response.body);
    return jsonObject;
  }
}
