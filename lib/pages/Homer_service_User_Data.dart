import 'dart:async';
import 'dart:convert';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:onclickproperty/Adaptor/Home_Service_User_Data_Insert.dart';
import 'package:onclickproperty/Adaptor/Rental_Agent_User_Data_Insert.dart';
import 'package:onclickproperty/const/const.dart';
import 'package:onclickproperty/const/shared_preference_constants.dart';
import 'package:onclickproperty/pages/Agreement_Page.dart';
import 'package:onclickproperty/pages/HomeServices_Page.dart';
import 'package:onclickproperty/pages/View_Service_Details_Page.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'package:onclickproperty/pages/owner_details/getting_user_data_screen.dart';

class HomeServiceUserDataPage extends StatefulWidget {
  @override
  //String checkid;
  String ServiceId;
  //String mobileno;
  HomeServiceUserDataPage(this.ServiceId);
  _HomeServiceUserDataPageState createState() =>
      _HomeServiceUserDataPageState(this.ServiceId);
}

class _HomeServiceUserDataPageState extends State<HomeServiceUserDataPage> {
  //String checkid;
  String ServiceId;
  //String mobileno;
  _HomeServiceUserDataPageState(this.ServiceId);
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
  String pincode;
  double lat, long;
  var uuid = new Uuid();
  String _sessionToken;
  List<dynamic> _placeList = [];
  bool showPlaceList = false;

  final _FullNametext = TextEditingController();
  final _Emailtext = TextEditingController();
  final _Mobiletext = TextEditingController();
  final _textServiceLocation = TextEditingController();

  List<String> _Selectedcity = [
    'Mumbai',
    'Thane',
    'Nagpur',
    'Navi Mumbai',
    'Nashik',
    'Aurangabad',
  ];

  // _onSearchlocation() {
  //   if (_sessionToken == null) {
  //     setState(() {
  //       _sessionToken = uuid.v4();
  //     });
  //   }
  //   getSuggestionforserchloction(_textServiceLocation.text);
  // }
  //
  // void getSuggestionforserchloction(String input) async {
  //   String kPLACES_API_KEY = "AIzaSyA8k5z6GiCXvSa9JifqxE7-0v4z22kcbKw";
  //   String type = '(regions)';
  //   String baseURL =
  //       'https://maps.googleapis.com/maps/api/place/autocomplete/json';
  //   String request =
  //       '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$_sessionToken';
  //   var response = await http.get(request);
  //   if (response.statusCode == 200) {
  //     print(response.body);
  //     setState(() {
  //       _placeList = json.decode(response.body)['predictions'];
  //     });
  //   } else {
  //     throw Exception('Failed to load predictions');
  //   }
  // }

  //------------------------------------For Service Location--------------------------------------------------
  //for getting lat Long
  getServiceLatLong(String address) async {
    setState(() {
      final query = '$address';
      SearchLocation = address;
      print('getLatLong');
      locationFromAddress(query).then((locations) {
        final output = locations[0].toString();
        print(output);
        print(locations[0].latitude);
        print(locations[0].longitude);
        lat = locations[0].latitude;
        long = locations[0].longitude;
        print('//lat/////////${lat}');
        print('//long/////////${long}');
        placemarkFromCoordinates(lat, long).then((placemarks) {
          final output = placemarks[0].toString();
          City = placemarks[0].locality.toString();
          print('_selectedCity ${City}');
          pincode = placemarks[0].postalCode.toString();
          print('pincode ${pincode}');
        });
      });
    });
  }

  _onServiceSearchlocation() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    getServiceSuggestionforserchloction(_textServiceLocation.text);
  }

  void getServiceSuggestionforserchloction(String input) async {
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

//--------------------------------------------------------------------------------------

  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        title: Row(
          children: [
            Text(
              "View Provider Details",
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
            //enabled: false,
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
          // SizedBox(height: 15.0),
          // DropdownSearch(
          //   items: _Selectedcity,
          //   showClearButton: true,
          //   onChanged: (value) {
          //     City = value.toString();
          //   },
          //   dropdownSearchDecoration: InputDecoration(
          //     contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          //     hintText: "Select City",
          //     hintStyle: style,
          //     prefixIcon: Padding(
          //       padding:
          //           const EdgeInsets.only(top: 12.0, right: 0.0, left: 0.0),
          //       child: FaIcon(
          //         FontAwesomeIcons.list,
          //         color: primarycolor,
          //       ),
          //     ),
          //     //border: OutlineInputBorder(),
          //   ),
          // ),
          SizedBox(height: 15.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _textServiceLocation,
                decoration: InputDecoration(
                  hintText: 'Service Location Provider',
                  labelText: 'Service Location Provider',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintStyle: TextStyle(color: Colors.grey),
                  labelStyle: TextStyle(color: Colors.black87),
                ),
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'This is required';
                  }
                },
                onSaved: (String value) {
                  _textServiceLocation.text = value;
                },
                onChanged: (value) {
                  setState(() {
                    showPlaceList = true;
                  });
                  _onServiceSearchlocation();
                },
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
                          _textServiceLocation.text =
                              _placeList[index]["description"];

                          var placeId = _placeList[index]["place_id"];
                          var address = _placeList[index]["description"];
                          print('${_placeList[index]}');
                          getServiceLatLong(address);
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

  //for getting lat Long
  getLatLong(String address) async {
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
      print("ServiceId:- ${ServiceId}");
      print("UID:- ${UID}");
      print("fullnumber:- ${Fullname}");
      print("EmailID:- ${Email}");
      print("MobileNumber:- ${Mobile}");
      print("City:-${City}");
      print("SearchLocation:- ${SearchLocation}");
      print("_selectdate:- ${_selectdate}");
      print("lat:-${lat}");
      print("long:- ${long}");
      print("pincode:- ${pincode}");

      _getHomeServiceUserData(
        "0",
        ServiceId,
        UID,
        Fullname,
        Email,
        Mobile,
        _selectdate,
        City != null ? City.toString() : '',
        SearchLocation,
        pincode != null ? pincode.toString() : '',
        lat != null ? lat.toString() : '',
        long != null ? long.toString() : '',
      );
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  Future<String> _getHomeServiceUserData(
    String actionId,
    String SpID,
    String UserID,
    String full_Name,
    String Email_ID,
    String Mobile_Number,
    String date,
    String city,
    String area,
    String pincode,
    String lat,
    String long,
  ) async {
    setState(() {
      showspinner = true;
    });
    try {
      InsertHomeServiceUserData HomeUserData = new InsertHomeServiceUserData();
      var HomeServiceUserData = await HomeUserData.getInsertHomeServiceUserData(
        actionId,
        SpID,
        UserID,
        full_Name,
        Email_ID,
        Mobile_Number,
        date,
        city,
        area,
        pincode,
        lat,
        long,
      );
      if (HomeServiceUserData != null) {
        print("HomeServiceUser Data///${HomeServiceUserData}");
        var resid = HomeServiceUserData['resid'];
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
          // Navigator.pop(context);
          // Navigator.pop(context);
          // Navigator.pop(context);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) {
              return ViewServiceDetailsPage(widget.ServiceId,"1");
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
