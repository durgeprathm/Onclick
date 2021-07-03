import 'package:async/async.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ElectronicImageSubmit {
  Future ElectronicuploadData(
      List images,
      String u_id,
      String appliances_type,
      String brand,
      String condition,
      String capacity,
      String title,
      String price,
      String pin_code,
      String city,
      String area,
      String your_are,
      String wattage,
      String model,
      String description,
      String date,
      String lat,
      String long,
      String alertnate_no,
      String std_code,
      String telphone_no) async {
    print("Inside Uploaddata Button $images");

    String URL =
        "https://onclickproperty.com//Onclick_API/Insert_Electronic_Details.php";
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
    request.fields["appliancestype"] = appliances_type;
    request.fields["brand"] = brand;
    request.fields["condition"] = condition;
    request.fields["capacity"] = capacity;
    request.fields["title"] = title;
    request.fields["price"] = price;
    request.fields["pincode"] = pin_code;
    request.fields["city"] = city;
    request.fields["area"] = area;
    request.fields["yourare"] = your_are;
    request.fields["wattage"] = wattage;
    request.fields["model"] = model;
    request.fields["description"] = description;
    request.fields["date"] = date;
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
