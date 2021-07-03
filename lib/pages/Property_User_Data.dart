import 'dart:async';
import 'dart:convert';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:onclickproperty/Adaptor/Home_Service_User_Data_Insert.dart';
import 'package:onclickproperty/Adaptor/Property_User_Data_Insert.dart';
import 'package:onclickproperty/Adaptor/Rental_Agent_User_Data_Insert.dart';
import 'package:onclickproperty/const/const.dart';
import 'package:onclickproperty/const/shared_preference_constants.dart';
import 'package:onclickproperty/pages/Agreement_Page.dart';
import 'package:onclickproperty/pages/HomeServices_Page.dart';
import 'package:onclickproperty/pages/home_page.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'package:onclickproperty/pages/owner_details/getting_user_data_screen.dart';

class PropertyUserDataPage extends StatefulWidget {
  @override
  String checkid;
  String PropertyId;
  String mobileno;
  PropertyUserDataPage(this.checkid, this.PropertyId, this.mobileno);
  _PropertyUserDataPageState createState() =>
      _PropertyUserDataPageState(this.checkid, this.PropertyId, this.mobileno);
}

class _PropertyUserDataPageState extends State<PropertyUserDataPage> {
  String checkid;
  String PropertyId;
  String mobileno;
  _PropertyUserDataPageState(this.checkid, this.PropertyId, this.mobileno);
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
  String UID;
  var uuid = new Uuid();
  String _sessionToken;
  List<dynamic> _placeList = [];
  String lat;
  String long;
  bool showPlaceList = false;

  final _FullNametext = TextEditingController();
  final _Emailtext = TextEditingController();
  final _Mobiletext = TextEditingController();

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
              "View Property Details",
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
    Mobile = mobileno;
    _Mobiletext.text = mobileno;
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
            enabled: false,
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
      print("PropertyId:- ${PropertyId}");
      print("UID:- ${UID}");
      print("fullnumber:- ${Fullname}");
      print("EmailID:- ${Email}");
      print("MobileNumber:- ${Mobile}");
      print("_selectdate:- ${_selectdate}");

      _getPropertyUserData(
          "0", PropertyId, UID, Fullname, Email, Mobile, _selectdate);
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  Future<String> _getPropertyUserData(
    String actionId,
    String PropertyID,
    String UserID,
    String full_Name,
    String Email_ID,
    String Mobile_Number,
    String Date,
  ) async {
    setState(() {
      showspinner = true;
    });
    try {
      InsertPropertyUserData PropertyData = new InsertPropertyUserData();
      var PropertyUserData = await PropertyData.getInsertPropertyUserData(
          actionId,
          PropertyID,
          UserID,
          full_Name,
          Email_ID,
          Mobile_Number,
          Date);
      if (PropertyUserData != null) {
        print("PropertyUser Data///${PropertyUserData}");
        var resid = PropertyUserData['resid'];
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
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) {
              return HomePage();
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
