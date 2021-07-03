import 'package:onclickproperty/NetworkHelper/network_helper_OnClick.dart';

class ContactToBankDetailsInsert {
  Future<dynamic> getContactToBankDetailsInsert(
      String actionId,
      String full_Name,
      String Email_ID,
      String Mobile_Number,
      String date,
      String occupation,
      String income,
      String loan_type,
      String city,
      String area) async {
    var map = new Map<String, dynamic>();
    map['actionId'] = actionId;
    map['name'] = full_Name;
    map['email'] = Email_ID;
    map['mobileno'] = Mobile_Number;
    map['date'] = date;
    map['occupation'] = occupation;
    map['income'] = income;
    map['loantype'] = loan_type;
    map['city'] = city;
    map['area'] = area;

    String apifile = 'Insert_Contact_To_Bank_Details.php';
    NetworkHelperOnClick networkHelper =
        new NetworkHelperOnClick(apiname: apifile, data: map);
    var insertdepartment = await networkHelper.getData();
    return insertdepartment;
  }
}
