import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:onclickproperty/Adaptor/fetch_company_details.dart';
import 'package:onclickproperty/Adaptor/insert_contact_us_data.dart';
import 'package:onclickproperty/const/const.dart';
import 'package:onclickproperty/const/modal_progress_hud.dart';
import 'package:onclickproperty/const/shared_preference_constants.dart';
import 'package:onclickproperty/pages/home_page.dart';
import 'package:onclickproperty/utilities/constants.dart';
import 'package:onclickproperty/utilities/size_config.dart';
import 'package:url_launcher/url_launcher.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool showpass = true;
  bool showRepass = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  final format = DateFormat("yyyy-MM-dd");
  String _selectdate;
  bool showspinner = false;
  bool checkemail = false;
  bool checkusername = false;
  String erroremail;
  String errorusername;

  TextEditingController _FullNametext = TextEditingController();
  TextEditingController _EmailIDtext = TextEditingController();
  TextEditingController _MobileNumbertext = TextEditingController();
  TextEditingController _message = TextEditingController();

  String FullName;
  String EmailID;
  String MobileNumber;
  String Message;
  String UID;
  String UserFullName;
  String UserEmail;
  String UserMobile;
  Future<void> _launched;
  bool _showProgressBar = false;

  String companyAddress;
  String companyEmailId;
  String companyphone;

  void getUserdata() async {
    UID = await SharedPreferencesConstants.instance
        .getStringValue(SharedPreferencesConstants.USERID);

    UserFullName = await SharedPreferencesConstants.instance
        .getStringValue(SharedPreferencesConstants.USERFULLNAME);
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
    _getCompanyData();
    getUserdata();
    _selectdate = DateFormat('yyyy-MM-dd').format(new DateTime.now());
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ModalProgressHUD(
        inAsyncCall: _showProgressBar,
        child: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "images/OnClicklogo.png",
                        height: SizeConfig.screenHeight * 0.1, //40%
                      ),
                    ],
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.03),
                  Text(
                    "Address:",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(15),
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "${companyAddress != null ? companyAddress : ''}",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(12),
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "Phone:",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(15),
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => setState(() {
                      _launched = _makePhoneCall('tel:$companyphone');
                    }),
                    child: Text(
                      "${companyphone != null ? companyphone : ''}",
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(12),
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Text(
                    "Email ID:",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(15),
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "${companyEmailId != null ? companyEmailId : ''}",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(12),
                      color: Colors.black,
                    ),
                  ),
                  Divider(),
                  Column(
                    children: <Widget>[
                      SizedBox(height: 10.0),
                      Center(
                        child: Text(
                          "Fill Contact Details",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: primarycolor,
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      TextFormField(
                        controller: _FullNametext,
                        style: style,
                        onChanged: (value) {
                          FullName = value;
                        },
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(
                                top: 12.0, right: 0.0, left: 0.0),
                            child: FaIcon(
                              FontAwesomeIcons.user,
                              color: primarycolor,
                            ),
                          ),
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          hintText: "Enter Full Name",
                          errorText:
                              checkusername ? 'Please Enter Full Name' : null,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      TextFormField(
                        controller: _EmailIDtext,
                        obscureText: false,
                        style: style,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          EmailID = value;
                        },
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(
                                top: 12.0, right: 0.0, left: 0.0),
                            child: FaIcon(
                              FontAwesomeIcons.envelope,
                              color: primarycolor,
                            ),
                          ),
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          hintText: "Enter Email",
                          errorText: checkemail ? 'Please Enter Email' : null,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      TextFormField(
                        controller: _MobileNumbertext,
                        obscureText: false,
                        style: style,
                        keyboardType: TextInputType.phone,
                        onChanged: (value) {
                          MobileNumber = value;
                        },
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(
                                top: 12.0, right: 0.0, left: 0.0),
                            child: FaIcon(
                              FontAwesomeIcons.mobileAlt,
                              color: primarycolor,
                            ),
                          ),
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          hintText: "Mobile Number",
                        ),
                      ),
                      SizedBox(height: 10.0),
                      TextFormField(
                        controller: _message,
                        obscureText: false,
                        //maxLines: 2,
                        style: style,
                        onChanged: (value) {
                          Message = value;
                        },
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(
                                top: 10.0, right: 0.0, left: 0.0),
                            child: FaIcon(
                              FontAwesomeIcons.ad,
                              color: primarycolor,
                            ),
                          ),
                          hintText: "Message",
                        ),
                        maxLines: 2,
                      ),
                      SizedBox(height: 15.0),
                      SizedBox(
                        width: double.infinity,
                        height: getProportionateScreenHeight(56),
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          color: kPrimaryColor,
                          onPressed: () async {
                            setState(() {
                              _FullNametext.text.isEmpty
                                  ? checkusername = true
                                  : checkusername = false;
                              _EmailIDtext.text.isEmpty
                                  ? checkemail = true
                                  : checkemail = false;

                              bool errorCheck = (!checkusername && !checkemail);
                              if (errorCheck) {
                                sendEnquiryData();
                              }
                            });
                          },
                          child: Text(
                            'Submit',
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(18),
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 3.0,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  sendEnquiryData() async {
    setState(() {
      _showProgressBar = true;
    });
    try {
      ContactUsDetailsInsert registerSubmitData = new ContactUsDetailsInsert();
      var result = await registerSubmitData.getContactUsDetailsInsert(
          '0',
          FullName,
          EmailID,
          MobileNumber != null ? MobileNumber : '',
          Message != null ? Message : '');
      if (result != null) {
        print("sendEnquiryData  ///${result}");
        var resid = result['resid'];
        var message = result["message"];
        if (resid == 200) {
          setState(() {
            _showProgressBar = false;
          });

          Fluttertoast.showToast(
              msg: "$message",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) {
              return HomePage();
            }),
          );
        } else {
          setState(() {
            _showProgressBar = false;
          });
          Fluttertoast.showToast(
              msg: "$message",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      } else {
        setState(() {
          _showProgressBar = true;
        });
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text("Plz Try Again"),
          backgroundColor: Colors.green,
        ));
      }
    } catch (e) {
      print(e);
      setState(() {
        _showProgressBar = true;
      });
    }
  }

  _getCompanyData() async {
    setState(() {
      showspinner = true;
    });
    try {
      CompanyDetails fetchdata = new CompanyDetails();
      var result = await fetchdata.getCompanyDetails("0");
      if (result != null) {
        var resid = result["resid"];
        if (resid == 200) {
          setState(() {
            companyAddress = result["contactaddress"];
            companyEmailId = result["contactemail"];
            companyphone = result["contactmobileno"];
            showspinner = false;
          });
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
