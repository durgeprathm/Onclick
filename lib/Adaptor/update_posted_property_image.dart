import 'package:async/async.dart';
import 'package:onclickproperty/const/shared_preference_constants.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UpdatePostedPropertyImage {
  Future PostedPropertyData(
      String actionId, List newimages, String propertyid, String preimg) async {
    print("Ipropertyid $propertyid");

    var UID = await SharedPreferencesConstants.instance
        .getStringValue(SharedPreferencesConstants.USERID);

    String URL =
        "https://onclickproperty.com//Onclick_API/Updated_Property_Images.php";
    var request = http.MultipartRequest("POST", Uri.parse(URL));
print("actionId in adpoter/////////////////////${actionId}");
   if(actionId=='0')
     {
       for (var image in newimages) {
         var stream = http.ByteStream(DelegatingStream.typed(image.openRead()));
         final length = await image.length();
         request.files.add(http.MultipartFile(
           'img[]', // consider using a unique name per image here
           stream,
           length,
           filename: basename(image.path),
         ));
       }
       request.fields["actionId"] = actionId;
       request.fields["Userid"] = UID;
       request.fields["id"] = propertyid;
       request.fields["preimg"] = preimg;
     }else if(actionId=='1')
       {
         request.fields["actionId"] = actionId;
         request.fields["Userid"] = UID;
         request.fields["id"] = propertyid;
         request.fields["preimg"] = preimg;
       }

    http.Response response =
        await http.Response.fromStream(await request.send());
    Map<String, dynamic> jsonObject = json.decode(response.body);
    return jsonObject;
  }
}
