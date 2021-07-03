import 'package:async/async.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ServiceAdImageSubmit {
  Future ServiceAduploadData(
      String actionid,
      List listfile1,
      List listfile2,
      String city,
      String area,
      String pincode,
      String service_type,
      String adhar_no,
      String date,
      String Name,
      String Email,
      String Mobile_no,
      String uid,
      String lat,
      String long,
      String alertnate_no,
      String std_code,
      String telphone_no) async {
    print("Inside Uploaddata Button $listfile1");

    String URL =
        "https://onclickproperty.com//Onclick_API/Insert_Services_ad.php";
    var request = http.MultipartRequest("POST", Uri.parse(URL));


    if(actionid =="0") {

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

      request.fields["actionId"] = actionid;
      request.fields["city"] = city;
      request.fields["area"] = area;
      request.fields["pincode"] = pincode;
      request.fields["servicetype"] = service_type;
      request.fields["adharno"] = adhar_no;
      request.fields["date"] = date;
      request.fields["Name"] = Name;
      request.fields["Email"] = Email;
      request.fields["Mobileno"] = Mobile_no;
      request.fields["uid"] = uid;
      request.fields["lat"] = lat;
      request.fields["long"] = long;
      request.fields["alertnateno"] = alertnate_no;
      request.fields["stdcode"] = std_code;
      request.fields["telphoneno"] = telphone_no;
    }else if(actionid =="1")
      {
        request.fields["actionId"] = actionid;
        request.fields["city"] = city;
        request.fields["area"] = area;
        request.fields["pincode"] = pincode;
        request.fields["servicetype"] = service_type;
        request.fields["adharno"] = adhar_no;
        request.fields["date"] = date;
        request.fields["Name"] = Name;
        request.fields["Email"] = Email;
        request.fields["Mobileno"] = Mobile_no;
        request.fields["uid"] = uid;
        request.fields["lat"] = lat;
        request.fields["long"] = long;
        request.fields["alertnateno"] = alertnate_no;
        request.fields["stdcode"] = std_code;
        request.fields["telphoneno"] = telphone_no;
      }else if(actionid =="2")
    {
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

      request.fields["actionId"] = actionid;
      request.fields["city"] = city;
      request.fields["area"] = area;
      request.fields["pincode"] = pincode;
      request.fields["servicetype"] = service_type;
      request.fields["adharno"] = adhar_no;
      request.fields["date"] = date;
      request.fields["Name"] = Name;
      request.fields["Email"] = Email;
      request.fields["Mobileno"] = Mobile_no;
      request.fields["uid"] = uid;
      request.fields["lat"] = lat;
      request.fields["long"] = long;
      request.fields["alertnateno"] = alertnate_no;
      request.fields["stdcode"] = std_code;
      request.fields["telphoneno"] = telphone_no;
    }else if(actionid =="3")
    {
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

      request.fields["actionId"] = actionid;
      request.fields["city"] = city;
      request.fields["area"] = area;
      request.fields["pincode"] = pincode;
      request.fields["servicetype"] = service_type;
      request.fields["adharno"] = adhar_no;
      request.fields["date"] = date;
      request.fields["Name"] = Name;
      request.fields["Email"] = Email;
      request.fields["Mobileno"] = Mobile_no;
      request.fields["uid"] = uid;
      request.fields["lat"] = lat;
      request.fields["long"] = long;
      request.fields["alertnateno"] = alertnate_no;
      request.fields["stdcode"] = std_code;
      request.fields["telphoneno"] = telphone_no;
    }




    print("avtion id ${actionid} is call");
    http.Response response =
        await http.Response.fromStream(await request.send());
    Map<String, dynamic> jsonObject = json.decode(response.body);
    return jsonObject;
  }
}
