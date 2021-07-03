import 'package:async/async.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PropertyImageSubmit {
  Future PropertyuploadData(
      List images,
      String User_ID,
      String Post_property_type,
      String pos_bay_now,
      String post_residential_type,
      String Post_residential_bhk_type,
      String Post_project_possession_date,
      String Post_floor,
      String Post_total_floor,
      String Post_property_age,
      String Post_property_size,
      String Post_carpet_area,
      String Post_facing,
      String Post_excepted_price,
      String Post_excepted_rent,
      String Post_Excepted_deposite,
      String Post_power_cut,
      String Post_other_charge,
      String Post_Maintance,
      String Post_furnishing,
      String Post_tenants,
      String Post_date,
      String Post_parking,
      String Post_description,
      String Post_roadwidth,
      String Post_no_bathroom,
      String Post_no_balconies,
      String Post_water_supply,
      String Post_non_veg_allowed,
      String Post_features_available,
      String Post_i_am,
      String Post_Mobile_No,
      String Post_city,
      String Post_pincode,
      String Post_socity,
      String Post_street,
      String Post_negotiable,
      String Post_Search_location,
      String Post_latitude,
      String Post_longtitude,
      String Post_Alertnate_No,
      String Post_STD_Code,
      String Post_Telephone_No) async {
    print("Inside Uploaddata Button $images");

    String URL =
        "https://onclickproperty.com//Onclick_API/Insert_Post_Property.php";
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
    request.fields["rid"] = User_ID;
    request.fields["propertytype"] = Post_property_type;
    request.fields["baynow"] = pos_bay_now;
    request.fields["residentialtype"] = post_residential_type;
    request.fields["residentialbhktype"] = Post_residential_bhk_type;
    request.fields["projectpossession"] = Post_project_possession_date;

    request.fields["floor"] = Post_floor;
    request.fields["totalfloor"] = Post_total_floor;
    request.fields["propertyage"] = Post_property_age;
    request.fields["propertysize"] = Post_property_size;
    request.fields["carpetarea"] = Post_carpet_area;

    request.fields["facing"] = Post_facing;
    request.fields["exceptedprice"] = Post_excepted_price;
    request.fields["erent"] = Post_excepted_rent;
    request.fields["edeposite"] = Post_Excepted_deposite;
    request.fields["powercut"] = Post_power_cut;
    request.fields["othercharge"] = Post_other_charge;

    request.fields["maintenance"] = Post_Maintance;
    request.fields["furnishing"] = Post_furnishing;
    request.fields["tenants"] = Post_tenants;
    request.fields["date"] = Post_date;
    request.fields["parking"] = Post_parking;

    request.fields["description"] = Post_description;
    request.fields["roadwidth"] = Post_roadwidth;
    request.fields["nobathroom"] = Post_no_bathroom;
    request.fields["nobalconies"] = Post_no_balconies;
    request.fields["watersupply"] = Post_water_supply;

    request.fields["nonvegallowed"] = Post_non_veg_allowed;
    request.fields["featuresavailable"] = Post_features_available;
    request.fields["iam"] = Post_i_am;
    request.fields["mobileno"] = Post_Mobile_No;
    request.fields["city"] = Post_city;

    request.fields["pincode"] = Post_pincode;
    request.fields["socity"] = Post_socity;
    request.fields["street"] = Post_street;
    request.fields["negotiable"] = Post_negotiable;
    request.fields["larea"] = Post_Search_location;
    request.fields["lat"] = Post_latitude;
    request.fields["long"] = Post_longtitude;
    request.fields["alertnateno"] = Post_Alertnate_No;
    request.fields["stdcode"] = Post_STD_Code;
    request.fields["telphoneno"] = Post_Telephone_No;


    http.Response response =
        await http.Response.fromStream(await request.send());
    Map<String, dynamic> jsonObject = json.decode(response.body);
    return jsonObject;
  }
}
