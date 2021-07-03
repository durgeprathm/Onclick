import 'package:async/async.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegistrationImageSubmit {
  Future RegistrationuploadData(
    List images,
    String full_Name,
    String UserName,
    String Date,
    String Email_ID,
    String Mobile_Number,
    String Password,
    String Description,
    String token,
    String area,
    String city,
    String pincode,
    String locationlat,
    String locationlong,
  ) async {
    print("Inside Uploaddata Button $images");

    String URL =
        "https://onclickproperty.com//Onclick_API/Insert_Registration_Details.php";
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
    request.fields["fullname"] = full_Name;
    request.fields["username"] = UserName;
    request.fields["date"] = Date;
    request.fields["email"] = Email_ID;
    request.fields["phone_no"] = Mobile_Number;
    request.fields["password"] = Password;
    request.fields["description"] = Description;
    request.fields["area"] = area;
    request.fields["city"] = city;
    request.fields["pincode"] = pincode;
    request.fields["locationlat"] = locationlat;
    request.fields["locationlong"] = locationlong;

    http.Response response =
        await http.Response.fromStream(await request.send());
    Map<String, dynamic> jsonObject = json.decode(response.body);
    return jsonObject;
  }
}
