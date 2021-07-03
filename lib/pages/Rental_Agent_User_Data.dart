import 'dart:async';
import 'dart:convert';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:onclickproperty/Adaptor/Rental_Agent_User_Data_Insert.dart';
import 'package:onclickproperty/const/const.dart';
import 'package:onclickproperty/const/shared_preference_constants.dart';
import 'package:onclickproperty/pages/Agreement_Page.dart';
import 'package:onclickproperty/pages/View_Rental_Agent_Details.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class RentalAgentUserDataPage extends StatefulWidget {
  @override
  String checkid;
  String AgentId;
  // String mobileno;
  RentalAgentUserDataPage(this.checkid, this.AgentId);
  _RentalAgentUserDataPageState createState() =>
      _RentalAgentUserDataPageState(this.checkid, this.AgentId);
}

class _RentalAgentUserDataPageState extends State<RentalAgentUserDataPage> {
  String checkid;
  String AgentId;
  // String mobileno;
  _RentalAgentUserDataPageState(this.checkid, this.AgentId);
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final format = DateFormat("yyyy-MM-dd");
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  bool showspinner = false;
  String _selectdate;
  String Fullname;
  String Email;
  String Mobile;
  String City;
  String SearchLocation;
  String UID;
  var uuid = new Uuid();
  String _sessionToken;
  List<dynamic> _placeList = [];
  double lat;
  double long;
  bool showPlaceList = false;
  String AlternateMobile;
  String Std;
  String telephone;
  String _selectedCity;
  String Pincode;

  TextEditingController _FullNametext = TextEditingController();
  TextEditingController _Emailtext = TextEditingController();
  TextEditingController _Mobiletext = TextEditingController();
  TextEditingController _Occupationtext = TextEditingController();
  TextEditingController _Incometext = TextEditingController();
  TextEditingController _Locationtext = TextEditingController();
  TextEditingController _AlternateMobiletext = TextEditingController();
  TextEditingController _Stdtext = TextEditingController();
  TextEditingController _telephonetext = TextEditingController();

  List<String> _Selectedcity = [
    'Mumbai',
    'Thane',
    'Nagpur',
    'Navi Mumbai',
    'Nashik',
    'Aurangabad',
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        title: Row(
          children: [
            // CircleAvatar(
            //   radius: 18,
            //   backgroundImage: AssetImage('images/loan.png'),
            // ),
            // SizedBox(
            //   width: 10.0,
            // ),
            Text(
              "Details For Rental Agent",
              style: TextStyle(
                fontSize: 25,
                fontFamily: 'RobotoMono',
                fontWeight: FontWeight.bold,
                color: primarycolor,
              ),
            ),
          ],
        ),
      ),
      body: showspinner
          ? Center(child: CircularProgressIndicator())
          : SafeArea(
              child: SingleChildScrollView(
                  child: new Form(
                key: _formKey,
                autovalidate: _autoValidate,
                child: FormUI(),
              )),
            ),
    );
  }

  void getUserdata() async {
    UID = await SharedPreferencesConstants.instance
        .getStringValue(SharedPreferencesConstants.USERID);

    Fullname = await SharedPreferencesConstants.instance
        .getStringValue("userfullname");
    _FullNametext.text = Fullname;
    print(Fullname);

    Email = await SharedPreferencesConstants.instance
        .getStringValue(SharedPreferencesConstants.USEREMAILID);
    _Emailtext.text = Email;
    print(await SharedPreferencesConstants.instance
        .getStringValue(SharedPreferencesConstants.USEREMAILID));
    Mobile = await SharedPreferencesConstants.instance
        .getStringValue(SharedPreferencesConstants.USERMOBNO);
    ;
    _Mobiletext.text = Mobile;
  }

  @override
  void initState() {
    showspinner = true;
    getUserdata();
    _selectdate = DateFormat('yyyy-MM-dd').format(new DateTime.now());
    Timer(Duration(seconds: 3), () => show());
  }

  show() {
    setState(() {
      showspinner = false;
    });
  }

  Widget FormUI() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
      child: Column(
        children: [
          // SizedBox(height: 18.0),
          TextFormField(
            enabled: false,
            controller: _FullNametext,
            obscureText: false,
            style: style,
            validator: fullNameValidate,
            onChanged: (value) {
              Fullname = value;
            },
            decoration: InputDecoration(
              prefixIcon: Padding(
                padding:
                    const EdgeInsets.only(top: 12.0, right: 0.0, left: 0.0),
                child: FaIcon(
                  FontAwesomeIcons.user,
                  color: primarycolor,
                ),
              ),
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              hintText: "Full Name",
            ),
          ),
          SizedBox(height: 15.0),
          TextFormField(
            enabled: false,
            controller: _Emailtext,
            obscureText: false,
            style: style,
            keyboardType: TextInputType.emailAddress,
            validator: validateEmail,
            onChanged: (value) {
              Email = value;
            },
            decoration: InputDecoration(
              prefixIcon: Padding(
                padding:
                    const EdgeInsets.only(top: 12.0, right: 0.0, left: 0.0),
                child: FaIcon(
                  FontAwesomeIcons.envelope,
                  color: primarycolor,
                ),
              ),
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              hintText: "Email",
            ),
          ),
          SizedBox(height: 15.0),
          TextFormField(
            // enabled: false,
            controller: _Mobiletext,
            obscureText: false,
            style: style,
            validator: validateMobile,
            onChanged: (value) {
              Mobile = value;
            },
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              prefixIcon: Padding(
                padding:
                    const EdgeInsets.only(top: 12.0, right: 0.0, left: 0.0),
                child: FaIcon(
                  FontAwesomeIcons.mobileAlt,
                  color: primarycolor,
                ),
              ),
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              hintText: "Mobile Number",
            ),
          ),
          SizedBox(height: 15.0),
          TextFormField(
            //enabled: false,
            controller: _AlternateMobiletext,
            obscureText: false,
            style: style,
            //validator: validateMobile,
            onChanged: (value) {
              AlternateMobile = value;
            },
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              prefixIcon: Padding(
                padding:
                    const EdgeInsets.only(top: 12.0, right: 0.0, left: 0.0),
                child: FaIcon(
                  FontAwesomeIcons.mobileAlt,
                  color: primarycolor,
                ),
              ),
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              hintText: "Alternate Mobile Number",
            ),
          ),
          SizedBox(height: 15.0),
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      //  enabled: false,
                      controller: _Stdtext,
                      obscureText: false,
                      style: style,
                      //validator: validateMobile,
                      onChanged: (value) {
                        Std = value;
                      },
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        // prefixIcon: Padding(
                        //   padding:
                        //   const EdgeInsets.only(top: 12.0, right: 0.0, left: 0.0),
                        //   child: FaIcon(
                        //     FontAwesomeIcons.mobileAlt,
                        //     color: primarycolor,
                        //   ),
                        // ),
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: "STD Code",
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 25,
                  ),
                  Expanded(
                    flex: 3,
                    child: TextFormField(
                      // enabled: false,
                      controller: _telephonetext,
                      obscureText: false,
                      style: style,
                      //validator: validateMobile,
                      onChanged: (value) {
                        telephone = value;
                      },
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(
                              top: 12.0, right: 0.0, left: 0.0),
                          child: FaIcon(
                            FontAwesomeIcons.phone,
                            color: primarycolor,
                          ),
                        ),
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: "Telephone Number",
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
          SizedBox(height: 15.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: TextFormField(
                  controller: _Locationtext,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                        padding: const EdgeInsets.only(
                            top: 12.0, right: 0.0, left: 0.0),
                        child: FaIcon(
                          FontAwesomeIcons.search,
                          color: primarycolor,
                        )),
                    suffixIcon: IconButton(
                        icon: Icon(Icons.cancel),
                        onPressed: () {
                          _Locationtext.clear();
                          setState(() {
                            _placeList.clear();
                            _selectedCity = null;
                            Pincode = null;
                            showPlaceList = false;
                          });
                        }),
                    hintText: 'Search Location',
                    hintStyle: style,
                  ),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'This is required';
                    }
                  },
                  onSaved: (String value) {
                    _Locationtext.text = value;
                  },
                  onChanged: (value) {
                    setState(() {
                      showPlaceList = true;
                    });
                    _onSearchlocation();
                  },
                ),
              ),
              Visibility(
                visible: showPlaceList,
                child: Container(
                  height: 100,
                  child: ListView.builder(
                    // physics: NeverScrollableScrollPhysics()
                    shrinkWrap: true,
                    itemCount: _placeList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_placeList[index]["description"]),
                        onTap: () {
                          _Locationtext.text = _placeList[index]["description"];

                          var placeId = _placeList[index]["place_id"];
                          var address = _placeList[index]["description"];
                          print('${_placeList[index]}');
                          getPlaceInfoDetails(address);
                          // lat = detail.result.geometry.location.lat;
                          // long = detail.result.geometry.location.lng;
                          setState(() {
                            _placeList.clear();
                            showPlaceList = false;
                          });
                        },
                      );
                    },
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 15.0),
          FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10.0),
            ),
            color: primarycolor,
            minWidth: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 15.0),
            onPressed: () {
              _validateInputs();
              // Navigator.of(context).push(
              //   MaterialPageRoute(builder: (_) {
              //     return HomePage();
              //   }),
              // );
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
      ),
    );
  }

  _onSearchlocation() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    getSuggestionforserchloction(_Locationtext.text);
  }

  void getSuggestionforserchloction(String input) async {
    String kPLACES_API_KEY = "AIzaSyA8k5z6GiCXvSa9JifqxE7-0v4z22kcbKw";
    String type = '(regions)';
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$_sessionToken';
    var uri = Uri.parse(request);
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
    SearchLocation = query;
    print('getLatLong');
    locationFromAddress(query).then((locations) {
      final output = locations[0].toString();
      print(output);
      print(locations[0].latitude);
      print(locations[0].longitude);
      lat = locations[0].latitude;
      long = locations[0].longitude;

      placemarkFromCoordinates(lat, long).then((placemarks) {
        final output = placemarks[0].toString();
        print(placemarks[0].locality);
        print('postalCode${placemarks[0].postalCode}');

        _selectedCity = placemarks[0].locality.toString();
        Pincode = placemarks[0].postalCode.toString();
      });
    });
  }

  //for getting lat Long
  getLatLong(String address) async {
    // From a query
    final query = '$address';
    SearchLocation = address;
    print('getLatLong');
  }

  //validation for full name
  String fullNameValidate(String value) {
    String patttern = r'^[a-z A-Z,.\-]+$';
    RegExp regExp = new RegExp(patttern);

    if (value.isEmpty || value == null) {
      return 'Please Enter Full Name';
    } else {
      if (!regExp.hasMatch(value)) {
        return 'Please enter valid full name';
      } else {
        return null;
      }
    }
  }

  // validation for mobile Number
  String validateMobile(String value) {
    Pattern pattern = r'/^\(?(\d{3})\)?[- ]?(\d{3})[- ]?(\d{4})$/';
    RegExp regex = new RegExp(pattern);
    if (value == null || value == null) {
      return 'Please Enter Mobile Number';
    } else {
      if (!regex.hasMatch(value) && value.length != 10)
        return 'Mobile Number must be of 10 digit';
      else
        return null;
    }
  }

//validation for email id
  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);

    if (value == null || value == null) {
      return 'Please Enter Email';
    } else {
      if (!regex.hasMatch(value))
        return 'Enter Valid Email';
      else
        return null;
    }
  }

  //for checking all the validation
  Future<void> _validateInputs() async {
    if (_formKey.currentState.validate()) {
//    If all data are correct then save data to out variables
      _formKey.currentState.save();
      print("AgentId:- ${AgentId}");
      print("fullnumber:- ${Fullname}");
      print("EmailID:- ${Email}");
      print("MobileNumber:- ${Mobile}");
      print("City:-${_selectedCity}");
      print("SearchLocation:- ${SearchLocation}");
      print("_selectdate:- ${_selectdate}");
      print("Pincode:-${Pincode}");
      print("lat:- ${lat}");
      print("long:- ${long}");
      print("AlternateMobile:-${AlternateMobile}");
      print("Std:- ${Std}");
      print("telephone:- ${telephone}");

      _getRentalUserData(
          "0",
          AgentId,
          Fullname,
          Mobile,
          Email,
          _selectedCity != null ? _selectedCity.toString() : '',
          SearchLocation,
          _selectdate,
          AlternateMobile != null ? AlternateMobile.toString() : '',
          Std != null ? Std.toString() : '',
          telephone != null ? telephone.toString() : '',
          Pincode != null ? Pincode.toString() : '',
          lat.toString() != null ? lat.toString() : '',
          long.toString() != null ? long.toString() : '');
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  Future<String> _getRentalUserData(
      String actionId,
      String AgentID,
      String full_Name,
      String Mobile_Number,
      String Email_ID,
      String city,
      String area,
      String date,
      String alternateno,
      String stdcode,
      String telphoneno,
      String pincode,
      String lat,
      String long) async {
    setState(() {
      showspinner = true;
    });
    try {
      InsertRentalAgentUserData RentalUserData =
          new InsertRentalAgentUserData();
      var RentalAgentUserData =
          await RentalUserData.getInsertRentalAgentUserData(
              actionId,
              AgentID,
              full_Name,
              Mobile_Number,
              Email_ID,
              city,
              area,
              date,
              alternateno,
              stdcode,
              telphoneno,
              pincode,
              lat,
              long);
      if (RentalAgentUserData != null) {
        print("RentalAgentUser Data///${RentalAgentUserData}");
        var resid = RentalAgentUserData['resid'];
        print("response from server ${resid}");
        if (resid == 200) {
          setState(() {
            showspinner = false;
          });

          Fluttertoast.showToast(
              msg: "You Will Get Details Soon !",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);

          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) {
              return ViewRentDetailsPage(widget.AgentId,"1");
            }),
          );
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
}
