import 'package:onclickproperty/NetworkHelper/network_helper_OnClick.dart';

class InsertLoanAgentUserData {
  Future<dynamic> getInsertLoanAgentUserData(
      String actionId,
      String AgentID,
      String full_Name,
      String Email_ID,
      String Mobile_Number,
      String date,
      String occupation,
      String income,
      String loan_type,
      String city,
      String area,
      String alternateno,
      String stdcode,
      String telphoneno,
      String pincode,
      String lat,
      String long) async {
    var map = new Map<String, dynamic>();
    map['actionId'] = actionId;
    map['uid'] = AgentID;
    map['name'] = full_Name;
    map['email'] = Email_ID;
    map['mobileno'] = Mobile_Number;
    map['date'] = date;
    map['occupation'] = occupation;
    map['income'] = income;
    map['loantype'] = loan_type;
    map['city'] = city;
    map['area'] = area;
    map['alternateno'] = alternateno;
    map['stdcode'] = stdcode;
    map['telphoneno'] = telphoneno;
    map['pincode'] = pincode;
    map['lat'] = lat;
    map['long'] = long;

    String apifile = 'Insert_Loan_Agent_User_Data.php';
    NetworkHelperOnClick networkHelper =
        new NetworkHelperOnClick(apiname: apifile, data: map);
    var insertdepartment = await networkHelper.getData();
    return insertdepartment;
  }
}
