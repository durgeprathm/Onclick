import 'package:async/async.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterAsLoanAgentImageSubmit {
  Future RegisterAsLoanAgentuploadData(
      String actionid,
      List images,
      String u_id,
      String Full_name,
      String mobile_no,
      String email,
      String company_city,
      String service_location,
      String description,
      String address,
      String bank_name,
      String rate_of_interest,
      String loan_type,
      String date,
      String CompanyName,
      String Companymobileno,
      String CompanyEmail,
      String CompanyLocation,
      String CompanyCity,
      String Companylat,
      String Companylong,
      String CompanyDescription,
      String CompanyAddreess,
      String CompanyPincode,
      String Companyyear,
      String CompanyNoEmp,
      String CompanyWebite,
      String pincode,
      String lat,
      String long,
      String companyalternateno,
      String companystdcode,
      String companytel,
      String alternateno,
      String stdcode,
      String telphoneno) async {
    print("Inside Uploaddata Button $images");

    String URL =
        "https://onclickproperty.com//Onclick_API/Insert_Register_As_Loan_Agent.php";
    var request = http.MultipartRequest("POST", Uri.parse(URL));
if(actionid=="0") {

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

  request.fields["actionId"] = actionid;
  request.fields["uid"] = u_id;
  request.fields["name"] = Full_name;
  request.fields["mobileno"] = mobile_no;
  request.fields["email"] = email;
  request.fields["city"] = company_city;
  request.fields["servicelocation"] = service_location;
  request.fields["description"] = description;
  request.fields["address"] = address;
  request.fields["bankname"] = bank_name;
  request.fields["rateofinterest"] = rate_of_interest;
  request.fields["loantype"] = loan_type;
  request.fields["date"] = date;
  request.fields["CompanyName"] = CompanyName;
  request.fields["Companymobileno"] = Companymobileno;
  request.fields["CompanyEmail"] = CompanyEmail;
  request.fields["CompanyLocation"] = CompanyLocation;
  request.fields["CompanyCity"] = CompanyCity;
  request.fields["Companylat"] = Companylat;
  request.fields["Companylong"] = Companylong;
  request.fields["CompanyDescription"] = CompanyDescription;
  request.fields["CompanyAddreess"] = CompanyAddreess;
  request.fields["CompanyPincode"] = CompanyPincode;
  request.fields["Companyyear"] = Companyyear;
  request.fields["CompanyNoEmp"] = CompanyNoEmp;
  request.fields["CompanyWebite"] = CompanyWebite;
  request.fields["pincode"] = pincode;
  request.fields["lat"] = lat;
  request.fields["long"] = long;
  request.fields["companyalternateno"] = companyalternateno;
  request.fields["companystdcode"] = companystdcode;
  request.fields["companytel"] = companytel;
  request.fields["alternateno"] = alternateno;
  request.fields["stdcode"] = stdcode;
  request.fields["telphoneno"] = telphoneno;
}else if(actionid=="1")
  {
    request.fields["actionId"] = actionid;
    request.fields["uid"] = u_id;
    request.fields["name"] = Full_name;
    request.fields["mobileno"] = mobile_no;
    request.fields["email"] = email;
    request.fields["city"] = company_city;
    request.fields["servicelocation"] = service_location;
    request.fields["description"] = description;
    request.fields["address"] = address;
    request.fields["bankname"] = bank_name;
    request.fields["rateofinterest"] = rate_of_interest;
    request.fields["loantype"] = loan_type;
    request.fields["date"] = date;
    request.fields["CompanyName"] = CompanyName;
    request.fields["Companymobileno"] = Companymobileno;
    request.fields["CompanyEmail"] = CompanyEmail;
    request.fields["CompanyLocation"] = CompanyLocation;
    request.fields["CompanyCity"] = CompanyCity;
    request.fields["Companylat"] = Companylat;
    request.fields["Companylong"] = Companylong;
    request.fields["CompanyDescription"] = CompanyDescription;
    request.fields["CompanyAddreess"] = CompanyAddreess;
    request.fields["CompanyPincode"] = CompanyPincode;
    request.fields["Companyyear"] = Companyyear;
    request.fields["CompanyNoEmp"] = CompanyNoEmp;
    request.fields["CompanyWebite"] = CompanyWebite;
    request.fields["pincode"] = pincode;
    request.fields["lat"] = lat;
    request.fields["long"] = long;
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
