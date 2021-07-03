import 'package:onclickproperty/NetworkHelper/network_helper_OnClick.dart';

class FetchFilterPropertiesList {
  Future<dynamic> getFetchFilterPropertiesList(
      String tabType,
      String pageNo,
      String actionId,
      String lookingfor,
      String location,
      String pincode,
      String bedrooms,
      String propertytypes,
      String squrefeetstart,
      String squrefeetend,
      String bathroom,
      String pricestart,
      String priceend,
      String Furniture,
      String postedby,
      String typeofsort) async {
    var map = new Map<String, dynamic>();
    map['pagenumber'] = pageNo;
    map['actionId'] = actionId;
    map['lookingfor'] = lookingfor;
    map['location'] = location;
    map['pincode'] = pincode;
    map['bedrooms'] = bedrooms;
    map['propertytypes'] = propertytypes;
    map['squrefeetstart'] = squrefeetstart;
    map['squrefeetend'] = squrefeetend;
    map['bathroom'] = bathroom;
    map['pricestart'] = pricestart;
    map['priceend'] = priceend;
    map['Furniture'] = Furniture;
    map['iam'] = postedby;
    map['typeofsort'] = typeofsort;

    String apifile;

    if (tabType == '1') {
      apifile = 'Residential_Sort.php';
    } else if (tabType == '2') {
      print('Commercial_Sort');
      apifile = 'Commercial_Sort.php';
    } else if (tabType == '3') {
      apifile = 'Project_Sort.php';
    }

    NetworkHelperOnClick networkHelper =
        new NetworkHelperOnClick(apiname: apifile, data: map);
    var fetchFeaturedata = await networkHelper.getData();
    return fetchFeaturedata;
  }
}
