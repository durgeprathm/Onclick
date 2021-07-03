import 'package:onclickproperty/NetworkHelper/network_helper_OnClick.dart';

import '../const/shared_preference_constants.dart';

class FetchPropertiesList {
  Future<dynamic> getPropertiesList(
      String actionid,
      String loacalityName,
      String pageno,
      String propertytype,
      String checktype,
      String agentid,
      String usertype) async {
    var map = new Map<String, dynamic>();
    var CITYNAME = await SharedPreferencesConstants.instance
        .getStringValue(SharedPreferencesConstants.CITY);
    var UID = await SharedPreferencesConstants.instance
        .getStringValue(SharedPreferencesConstants.USERID);

    print('Uid: $UID');
    print('actionid: $actionid');
    if (actionid == '7') {
      map['actionId'] = actionid;
      map['uid'] = UID;
      map['pagenumber'] = pageno;
    } else {
      if (checktype == "1") {
        map['actionId'] = actionid;
        map['uid'] = UID;
        map['localityname'] = CITYNAME;
        map['pagenumber'] = pageno;
        map['propertytype'] = propertytype;
      } else if (checktype == "2") {
        map['actionId'] = actionid;
        map['uid'] = UID;
        map['localityname'] = loacalityName;
        map['pagenumber'] = pageno;
        map['propertytype'] = propertytype;
        map['agentid'] = agentid;
        map['usertype'] = usertype;
      } else if (checktype == "3") {
        map['actionId'] = actionid;
        map['uid'] = UID;
        map['localityname'] = loacalityName;
        map['pagenumber'] = pageno;
        map['propertytype'] = propertytype;
      }
    }

    String apifile = 'All_Top_Property_List_Fetch.php';
    NetworkHelperOnClick networkHelper =
        new NetworkHelperOnClick(apiname: apifile, data: map);
    var fetchelectronicproductsdata = await networkHelper.getData();
    return fetchelectronicproductsdata;
  }

  Future<dynamic> getFilterPropertiesList(
      String actionid,
      String pageno,
      String loacalityName,
      String propertytype,
      String baynow,
      String residentialtype,
      String bhktype) async {
    var map = new Map<String, dynamic>();
    var CITYNAME = await SharedPreferencesConstants.instance
        .getStringValue(SharedPreferencesConstants.CITY);
    var UID = await SharedPreferencesConstants.instance
        .getStringValue(SharedPreferencesConstants.USERID);

    switch (actionid) {
      case "0":
        {
          map['actionId'] = actionid;
          map['pagenumber'] = pageno;
          map['localityname'] = loacalityName;
          map['propertytype'] = propertytype;
          map['baynow'] = baynow;
        }
        break;
      case "1":
        {
          map['actionId'] = actionid;
          map['pagenumber'] = pageno;
          map['localityname'] = loacalityName;
          map['propertytype'] = propertytype;
          map['baynow'] = baynow;
          map['residentialtype'] = residentialtype;
        }
        break;
      case "2":
        {
          map['actionId'] = actionid;
          map['pagenumber'] = pageno;
          map['localityname'] = loacalityName;
          map['propertytype'] = propertytype;
          map['baynow'] = baynow;
          map['bhktype'] = bhktype;
        }
        break;
      case "3":
        {
          map['actionId'] = actionid;
          map['pagenumber'] = pageno;
          map['localityname'] = loacalityName;
          map['propertytype'] = propertytype;
          map['baynow'] = baynow;
          map['residentialtype'] = residentialtype;
          map['bhktype'] = bhktype;
        }
        break;
      case "4":
        {
          map['actionId'] = actionid;
          map['pagenumber'] = pageno;
          map['localityname'] = loacalityName;
          map['propertytype'] = propertytype;
          map['baynow'] = baynow;
          map['commercialtype'] = residentialtype;
        }
        break;
      case "4":
        {
          map['actionId'] = actionid;
          map['pagenumber'] = pageno;
          map['localityname'] = loacalityName;
          map['propertytype'] = propertytype;
          map['baynow'] = baynow;
          map['commercialtype'] = residentialtype;
        }
        break;
    }

    String apifile = 'FilterProperty.php';
    NetworkHelperOnClick networkHelper =
        new NetworkHelperOnClick(apiname: apifile, data: map);
    var fetchelectronicproductsdata = await networkHelper.getData();
    return fetchelectronicproductsdata;
  }

  Future<dynamic> getProjectFilterPropertiesList(
      String actionid,
      String pageno,
      String loacalityName,
      String propertytype,
      String projectresidential,
      String residentialbhktype) async {
    var map = new Map<String, dynamic>();
    var CITYNAME = await SharedPreferencesConstants.instance
        .getStringValue(SharedPreferencesConstants.CITY);
    var UID = await SharedPreferencesConstants.instance
        .getStringValue(SharedPreferencesConstants.USERID);

    switch (actionid) {
      case "5":
        {
          map['actionId'] = actionid;
          map['pagenumber'] = pageno;
          map['localityname'] = loacalityName;
          map['propertytype'] = propertytype;
          map['projectresidential'] = projectresidential;
          map['residentialbhktype'] = residentialbhktype;
        }
        break;
      case "6":
        {
          map['actionId'] = actionid;
          map['pagenumber'] = pageno;
          map['localityname'] = loacalityName;
          map['propertytype'] = propertytype;
          map['commercialtype'] = projectresidential;
        }
        break;
    }

    String apifile = 'FilterProperty.php';
    NetworkHelperOnClick networkHelper =
        new NetworkHelperOnClick(apiname: apifile, data: map);
    var fetchelectronicproductsdata = await networkHelper.getData();
    return fetchelectronicproductsdata;
  }

  Future<dynamic> getPropertiesPostedByUserList(
    String actionid,
    String pageno,
      String propertytype,
      String Forwhat,
  ) async {
    var map = new Map<String, dynamic>();
    var CITYNAME = await SharedPreferencesConstants.instance
        .getStringValue(SharedPreferencesConstants.CITY);
    var UID = await SharedPreferencesConstants.instance
        .getStringValue(SharedPreferencesConstants.USERID);

    map['actionId'] = actionid;
    map['Userid'] = UID;
    map['pagenumber'] = pageno;
    map['Propertytypeid'] = propertytype;
    map['forwhat'] = Forwhat;

    String apifile = 'Fetch_user_Posted_things.php';
    NetworkHelperOnClick networkHelper =
        new NetworkHelperOnClick(apiname: apifile, data: map);
    var fetchelectronicproductsdata = await networkHelper.getData();
    return fetchelectronicproductsdata;
  }
}
