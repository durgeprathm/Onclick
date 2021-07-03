import 'package:async/async.dart';
import 'package:onclickproperty/const/shared_preference_constants.dart';
import 'package:onclickproperty/pages/ElectronicUpdatedDetails_User_Posted.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UpdateUserProfile {
  Future insertUpdateUserProfile(
    String actionId,
    String userid,
    List images,
    String full_Name,
    String UserName,
    String phonenumber,
    String email,
  ) async {
    print("Inside Uploaddata Button $images");

    String URL =
        "https://onclickproperty.com//Onclick_API/update_profiledetails.php";
    var request = http.MultipartRequest("POST", Uri.parse(URL));

    userid = await SharedPreferencesConstants.instance
        .getStringValue(SharedPreferencesConstants.USERID);
    print("userid///////////${userid}");

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
    }

    request.fields["actionid"] = actionId;
    request.fields["userid"] = userid;
    request.fields["updatedfullname"] = full_Name;
    request.fields["username"] = UserName;
    request.fields["mobileno"] = phonenumber;
    request.fields["email"] = email;

    http.Response response =
        await http.Response.fromStream(await request.send());
    Map<String, dynamic> jsonObject = json.decode(response.body);
    return jsonObject;
  }
}
