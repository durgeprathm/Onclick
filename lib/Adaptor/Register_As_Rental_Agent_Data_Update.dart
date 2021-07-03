import 'package:async/async.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterAsRentalAgentImageDataUpdate{
  Future RegisterAsRentalAgentDataUpload(
      String ActionID,
      List images,
      String imageslink,
      String u_id,
      String Full_name,
      String mobile_no,
      String email,
      String company_city,
      String service_location,
      String company_name,
      String address,
      String description,
      String category,
      String register_type,
      String provdcustomrlocat,
      String date,
      String CompanyName,
      String CompanyMobileNo,
      String CompanyEmail,
      String CompanyLocation,
      String CompanyCity,
      String CompanyLat,
      String CompanyLong,
      String CompanyDescription,
      String companyAddress,
      String CompanyPincode,
      String CompanyYear,
      String CompanyNoEmp,
      String CompanyWebsite,
      String lat,
      String long,
      String pincode,
      String companyalternateno,
      String companystdcode,
      String companytel,
      String alternateno,
      String stdcode,
      String telphoneno) async {
    String URL =
        "https://onclickproperty.com//Onclick_API/Updated_Rental_Agent_Details.php";
    var request = http.MultipartRequest("POST", Uri.parse(URL));

    if(ActionID == '0') {
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

      request.fields["actionId"] = ActionID;
      request.fields["uid"] = u_id;
      request.fields["name"] = Full_name;
      request.fields["mobileno"] = mobile_no;
      request.fields["email"] = email;
      request.fields["city"] = company_city;
      request.fields["servicelocation"] = service_location;
      request.fields["address"] = address;
      request.fields["description"] = description;
      request.fields["category"] = category;
      request.fields["registertype"] = register_type;
      request.fields["provdcustomrlocat"] = provdcustomrlocat;
      request.fields["date"] = date;
      request.fields["CompanyName"] = CompanyName;
      request.fields["CompanyMobileNo"] = CompanyMobileNo;
      request.fields["CompanyEmail"] = CompanyEmail;
      request.fields["CompanyLocation"] = CompanyLocation;
      request.fields["CompanyCity"] = CompanyCity;
      request.fields["CompanyLat"] = CompanyLat;
      request.fields["CompanyLong"] = CompanyLong;
      request.fields["CompanyDescription"] = CompanyDescription;
      request.fields["companyAddress"] = companyAddress;
      request.fields["CompanyPincode"] = CompanyPincode;
      request.fields["CompanyYear"] = CompanyYear;
      request.fields["CompanyNoEmp"] = CompanyNoEmp;
      request.fields["CompanyWebsite"] = CompanyWebsite;
      request.fields["lat"] = lat;
      request.fields["long"] = long;
      request.fields["pincode"] = pincode;
      request.fields["companyalternateno"] = companyalternateno;
      request.fields["companystdcode"] = companystdcode;
      request.fields["companytel"] = companytel;
      request.fields["alternateno"] = alternateno;
      request.fields["stdcode"] = stdcode;
      request.fields["telphoneno"] = telphoneno;
    }else if(ActionID == '1')
      {
        request.fields["actionId"] = ActionID;
        request.fields["images"] = imageslink;
        request.fields["uid"] = u_id;
        request.fields["name"] = Full_name;
        request.fields["mobileno"] = mobile_no;
        request.fields["email"] = email;
        request.fields["city"] = company_city;
        request.fields["servicelocation"] = service_location;
        request.fields["address"] = address;
        request.fields["description"] = description;
        request.fields["category"] = category;
        request.fields["registertype"] = register_type;
        request.fields["provdcustomrlocat"] = provdcustomrlocat;
        request.fields["date"] = date;
        request.fields["CompanyName"] = CompanyName;
        request.fields["CompanyMobileNo"] = CompanyMobileNo;
        request.fields["CompanyEmail"] = CompanyEmail;
        request.fields["CompanyLocation"] = CompanyLocation;
        request.fields["CompanyCity"] = CompanyCity;
        request.fields["CompanyLat"] = CompanyLat;
        request.fields["CompanyLong"] = CompanyLong;
        request.fields["CompanyDescription"] = CompanyDescription;
        request.fields["companyAddress"] = companyAddress;
        request.fields["CompanyPincode"] = CompanyPincode;
        request.fields["CompanyYear"] = CompanyYear;
        request.fields["CompanyNoEmp"] = CompanyNoEmp;
        request.fields["CompanyWebsite"] = CompanyWebsite;
        request.fields["lat"] = lat;
        request.fields["long"] = long;
        request.fields["pincode"] = pincode;
        request.fields["companyalternateno"] = companyalternateno;
        request.fields["companystdcode"] = companystdcode;
        request.fields["companytel"] = companytel;
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
