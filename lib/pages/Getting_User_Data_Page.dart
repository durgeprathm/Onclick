import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:onclickproperty/Adaptor/fetch_Furniture_Porducts.dart';
import 'package:onclickproperty/Model/FurnitureProducts.dart';
import 'package:onclickproperty/const/const.dart';
import 'package:onclickproperty/const/shared_preference_constants.dart';
import 'package:onclickproperty/pages/Furniture_Items_Page.dart';
import 'package:onclickproperty/Adaptor/insert_request_userdata.dart';
import 'package:http/http.dart' as http;

import 'ElectronicUpdatedDetails_User_Posted.dart';

class GettingUserDataPage extends StatefulWidget {
  @override
  //String CheckId;
  String FurnitutrID;
  //String Mobileno;
  GettingUserDataPage(this.FurnitutrID);
  _GettingUserDataPageState createState() =>
      _GettingUserDataPageState(this.FurnitutrID);
}

class _GettingUserDataPageState extends State<GettingUserDataPage> {
  //String CheckId;
  String FurnitutrID;
  //String Mobileno;
  _GettingUserDataPageState(this.FurnitutrID);
  List<FurnitureProducts> FurnitureProductslist = new List();
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool showpass = true;
  bool showRepass = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  final format = DateFormat("yyyy-MM-dd");
  String _selectdate;
  File images;
  List<File> listfile = [];
  bool showspinner = false;
  bool checkemail = false;
  bool checkusername = false;
  String erroremail;
  String errorusername;
  String Usercity;
  String City;
  String Pincode;
  double lat, long;
  String _SearchLocation;
  InsertUserRequest insertUserRequest = new InsertUserRequest();

  TextEditingController _FullNametext = TextEditingController();
  TextEditingController _EmailIDtext = TextEditingController();
  TextEditingController _MobileNumbertext = TextEditingController();
  TextEditingController _title = TextEditingController();
  TextEditingController _price = TextEditingController();

  String FullName;
  String UserName;
  String Password;
  String RePassword;
  String EmailID;
  String MobileNumber;
  String Title;
  String Price;
  String UID;
  String UserFullName;
  String UserEmail;
  String UserMobile;
  String _sessionToken;
  List<dynamic> _placeList = [];

  void getUserdata() async {
    UID = await SharedPreferencesConstants.instance
        .getStringValue(SharedPreferencesConstants.USERID);

    UserFullName = await SharedPreferencesConstants.instance
        .getStringValue("userfullname");
    FullName = UserFullName;
    _FullNametext.text = UserFullName;
    print(UserFullName);

    UserEmail = await SharedPreferencesConstants.instance
        .getStringValue(SharedPreferencesConstants.USEREMAILID);
    EmailID = UserEmail;
    _EmailIDtext.text = UserEmail;

    UserMobile = await SharedPreferencesConstants.instance
        .getStringValue(SharedPreferencesConstants.USERMOBNO);
    _MobileNumbertext.text = UserMobile;
    MobileNumber = UserMobile;
  }

  @override
  void initState() {
    getUserdata();
    print("//////ID//////////////////${FurnitutrID}");
    _getFurnitureProducts(FurnitutrID.toString());
    _selectdate = DateFormat('yyyy-MM-dd').format(new DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.transparent,
          title: Text(
            "",
            style: TextStyle(
              fontSize: 25,
              fontFamily: 'RobotoMono',
              fontWeight: FontWeight.normal,
              color: primarycolor,
            ),
          )),
      body: showspinner
          ? Center(child: CircularProgressIndicator())
          : SafeArea(
              child: SingleChildScrollView(
                child: Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: new Form(
                        key: _formKey,
                        autovalidate: _autoValidate,
                        child: FormUI(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  Widget FormUI() {
    return ListView(
      children: <Widget>[
        SizedBox(height: 10.0),
        Center(
          child: Text(
            "Fill Contact Details",
            style: TextStyle(
              fontSize: 25,
              fontFamily: 'RobotoMono',
              fontWeight: FontWeight.normal,
              color: primarycolor,
            ),
          ),
        ),
        SizedBox(height: 20.0),
        TextFormField(
          controller: _FullNametext,
          style: style,
          onChanged: (value) {
            FullName = value;
          },
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: const EdgeInsets.only(top: 12.0, right: 0.0, left: 0.0),
              child: FaIcon(
                FontAwesomeIcons.user,
                color: primarycolor,
              ),
            ),
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Enter Full Name",
          ),
        ),
        SizedBox(height: 10.0),
        TextFormField(
          controller: _title,
          obscureText: false,
          //maxLines: 2,
          style: style,
          enabled: false,
          onChanged: (value) {
            Title = value;
          },
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: const EdgeInsets.only(top: 12.0, right: 0.0, left: 0.0),
              child: FaIcon(
                FontAwesomeIcons.heading,
                color: primarycolor,
              ),
            ),
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Title",
          ),
        ),
        SizedBox(height: 10.0),
        TextFormField(
          controller: _price,
          obscureText: false,
          //maxLines: 2,
          enabled: false,
          style: style,
          onChanged: (value) {
            Price = value;
          },
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: const EdgeInsets.only(top: 12.0, right: 0.0, left: 0.0),
              child: FaIcon(
                FontAwesomeIcons.moneyCheck,
                color: primarycolor,
              ),
            ),
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Price",
          ),
        ),
        SizedBox(height: 10.0),
        TextFormField(
          controller: _EmailIDtext,
          obscureText: false,
          style: style,
          enabled: false,
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) {
            EmailID = value;
          },
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: const EdgeInsets.only(top: 12.0, right: 0.0, left: 0.0),
              child: FaIcon(
                FontAwesomeIcons.envelope,
                color: primarycolor,
              ),
            ),
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Enter Email",
          ),
        ),
        SizedBox(height: 10.0),
        TextFormField(
          controller: _MobileNumbertext,
          obscureText: false,
          enabled: false,
          style: style,
          keyboardType: TextInputType.phone,
          onChanged: (value) {
            MobileNumber = value;
          },
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: const EdgeInsets.only(top: 12.0, right: 0.0, left: 0.0),
              child: FaIcon(
                FontAwesomeIcons.mobileAlt,
                color: primarycolor,
              ),
            ),
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Mobile Number",
          ),
        ),
        SizedBox(height: 10.0),
        FlatButton(
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10.0),
          ),
          color: primarycolor,
          minWidth: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 15.0),
          onPressed: () {
            _onSearchlocation();
            print("//////////UID//////////${UID}");
            print("//////////UserName//////////${FullName}");
            print("//////////EmailID//////////${EmailID}");
            print("//////////MobileNumber//////////${MobileNumber}");
            print("//////////_selectdate//////////${_selectdate}");
            print("//////////FurnitutrID//////////${FurnitutrID}");
            print("//////////City//////////${City}");
            print("//////////_SearchLocation//////////${_SearchLocation}");
            print("//////////Pincode//////////${Pincode}");
            print("//////////lat//////////${lat}");
            print("//////////long//////////${long}");
            var resid = _getRegistrationSubmitData("0", UID, FullName,
                FurnitutrID, EmailID, MobileNumber, _selectdate);
            print(resid);
          },
          child: Text("Submit",
              textAlign: TextAlign.center,
              style: style.copyWith(
                  color: Colors.white, fontWeight: FontWeight.bold)),
        ),
        SizedBox(
          height: 3.0,
        ),
      ],
    );
  }

  _getRegistrationSubmitData(String actionId, String userid, String username,
      String typeid, String email, String mobileno, String date) async {
    setState(() {
      showspinner = true;
    });
    try {
      InsertUserRequest UsertData = new InsertUserRequest();
      var UsertDatafetch = await UsertData.insertUserRequest(
        actionId,
        userid,
        username,
        typeid,
        email,
        mobileno,
        date,
      );
      if (UsertDatafetch != null) {
        print("User data ///${UsertDatafetch}");
        var resid = UsertDatafetch['resid'];
        print("response from server ${resid}");
        if (resid == 200) {
          setState(() {
            showspinner = false;
          });
          Fluttertoast.showToast(
              msg: "You Will Get Details Soon !",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) {
              return FurnitureItemsPage(
                  FurnitureProductslist[0].Furnituretypeid.toString(),
                  FurnitureProductslist[0].Furnituretypename);
            }),
          );
        } else if (resid == 204) {
          setState(() {
            showspinner = false;
          });
          if (UsertDatafetch['error'] == "username") {
            setState(() {
              checkusername = true;
              errorusername = UsertDatafetch['message'];
            });
          } else if (UsertDatafetch['error'] == "email") {
            setState(() {
              checkemail = true;
              erroremail = UsertDatafetch['message'];
            });
          }
        } else {
          setState(() {
            showspinner = false;
          });
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text("Plz Try Again"),
            backgroundColor: Colors.green,
          ));
        }
      } else {
        setState(() {
          showspinner = false;
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text("Some Technical Problem Plz Try Again Later"),
            backgroundColor: Colors.green,
          ));
        });
      }
    } catch (e) {
      print(e);
    }
  }

  void _getFurnitureProducts(String itemid) async {
    setState(() {
      showspinner = true;
    });
    try {
      FetchFurnitureProducts fetchfurnitureproductsdata =
          new FetchFurnitureProducts();
      var fetchfurnitureproducts = await fetchfurnitureproductsdata
          .getFetchFurnitureProducts("4", "3", itemid, "");
      if (fetchfurnitureproducts != null) {
        var resid = fetchfurnitureproducts["resid"];
        var rowcount = fetchfurnitureproducts["rowcount"];
        print(
            "///////////////////-----------------------Furniture Response-------------------------");
        print(fetchfurnitureproducts);
        print(
            "///////////////////-----------------------Furniture Response-------------------------");
        if (resid == 200) {
          if (rowcount > 0) {
            var fetchfurnitureprodcutssd =
                fetchfurnitureproducts["furnitureproductlist"];
            print(fetchfurnitureprodcutssd.length);
            List<FurnitureProducts> tempfetchfurnitureprodcutslist = [];
            for (var n in fetchfurnitureprodcutssd) {
              FurnitureProducts pro = FurnitureProducts(
                int.parse(n["id"]),
                int.parse(n["uid"]),
                int.parse(n["furnituretypeID"]),
                n["furniturename"],
                n["furnituresubtype"],
                n["condition"],
                n["brand"],
                n["title"],
                n["price"],
                n["mobileno"],
                n["username"],
                n["email"],
                n["pincode"],
                n["city"],
                n["area"],
                n["yourare"],
                n["furniturematerial"],
                n["model"],
                n["quality"],
                n["description"],
                n["alternateno"],
                n["std"],
                n["telephoneno"],
                n["date"],
                n["lat"],
                n["long"],
                n["Firstimg"],
                n["img"],
              );
              tempfetchfurnitureprodcutslist.add(pro);
            }
            setState(() {
              this.FurnitureProductslist = tempfetchfurnitureprodcutslist;
              _title.text = FurnitureProductslist[0].FurniturnTitle;
              Title = FurnitureProductslist[0].FurniturnTitle;
              _price.text = FurnitureProductslist[0].FurniturnPrice;
              Price = FurnitureProductslist[0].FurniturnPrice;
              showspinner = false;
            });

            print(
                "//////FurnitureProductslist/////////${FurnitureProductslist.length}");
          } else {
            setState(() {
              //showNoProduct = true;
              showspinner = false;
            });
          }
        } else {
          setState(() {
            showspinner = false;
          });
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text("Plz Try Again"),
            backgroundColor: Colors.green,
          ));
        }
      } else {
        setState(() {
          showspinner = false;
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text("Some Technical Problem Plz Try Again Later"),
            backgroundColor: Colors.green,
          ));
        });
      }
    } catch (e) {
      print(e);
    }
  }

  _onSearchlocation() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    getSuggestionforserchloction(Usercity);
  }

  void getSuggestionforserchloction(String input) async {
    String kPLACES_API_KEY = "AIzaSyA8k5z6GiCXvSa9JifqxE7-0v4z22kcbKw";
    String type = '(regions)';
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$_sessionToken';
    var uri  = Uri.parse(request);
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      print(response.body);
      setState(() {
        _placeList = json.decode(response.body)['predictions'];
      });
    } else {
      throw Exception('Failed to load predictions');
    }
  }

  getPlaceInfoDetails(String address) async {
    final query = '$address';
    _SearchLocation = query;
    print('getLatLong');
    locationFromAddress(query).then((locations) {
      final output = locations[0].toString();
      print(output);
      double latd, longd;
      print(locations[0].latitude);
      print(locations[0].longitude);
      latd = locations[0].latitude;
      longd = locations[0].longitude;
      lat = locations[0].latitude;
      long = locations[0].longitude;

      placemarkFromCoordinates(latd, longd).then((placemarks) {
        final output = placemarks[0].toString();
        print(placemarks[0].locality);
        print('postalCode${placemarks[0].postalCode}');

        City = placemarks[0].locality.toString();
        Pincode = placemarks[0].postalCode.toString();
      });
    });
  }
}
