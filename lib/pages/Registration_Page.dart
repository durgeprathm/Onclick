import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:onclickproperty/Adaptor/Registration_Details_Image.dart';
import 'package:onclickproperty/const/const.dart';
import 'package:onclickproperty/const/shared_preference_constants.dart';
import 'package:onclickproperty/pages/Login_Page.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
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

  final _FullNametext = TextEditingController();
  final _UserNametext = TextEditingController();
  final _Passwordtext = TextEditingController();
  final _RePasswordtext = TextEditingController();
  final _EmailIDtext = TextEditingController();
  final _MobileNumbertext = TextEditingController();
  final _Descriptiontext = TextEditingController();

  String FullName;
  String UserName;
  String Password;
  String RePassword;
  String EmailID;
  String MobileNumber;
  String Description;

  bool _FullNamevalidate = false;
  bool _UserNamevalidate = false;
  bool _Passwordvalidate = false;
  bool _RePasswordvalidate = false;
  bool _EmailIdvalidate = false;
  bool _MobileNumbervalidate = false;
  bool _Descriptionvalidate = false;

  @override
  void initState() {
    _selectdate = DateFormat('yyyy-MM-dd').format(new DateTime.now());
    initApp();
  }

  void initApp() async {
    MobileNumber = await SharedPreferencesConstants.instance
        .getStringValue(SharedPreferencesConstants.USERMOBNO);
    _MobileNumbertext.text = MobileNumber;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
        SizedBox(
          height: 10,
        ),
        Image.asset(
          "images/OnClicklogo.png",
          fit: BoxFit.contain,
          width: 90.0,
          height: 60.0,
        ),
        SizedBox(height: 12.0),
        TextFormField(
          controller: _FullNametext,
          obscureText: false,
          style: style,
          validator: fullNameValidate,
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
          controller: _UserNametext,
          obscureText: false,
          style: style,
          validator: validateUsername,
          onChanged: (value) {
            UserName = value;
          },
          decoration: InputDecoration(
              prefixIcon: Padding(
                padding:
                    const EdgeInsets.only(top: 12.0, right: 0.0, left: 0.0),
                child: FaIcon(
                  FontAwesomeIcons.userSecret,
                  color: primarycolor,
                ),
              ),
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              hintText: "Username",
              errorText: checkusername ? errorusername : null),
        ),
        SizedBox(height: 10.0),
        TextFormField(
          controller: _EmailIDtext,
          obscureText: false,
          style: style,
          keyboardType: TextInputType.emailAddress,
          validator: validateEmail,
          onChanged: (value) {
            EmailID = value;
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
              hintText: "Enter Email",
              errorText: checkemail ? erroremail : null),
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
          validator: validateMobile,
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
        TextFormField(
          controller: _Passwordtext,
          obscureText: showpass,
          style: style,
          validator: validatePassword,
          onChanged: (value) {
            Password = value;
          },
          decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Enter Password",
            // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(top: 12.0, right: 0.0, left: 0.0),
              child: FaIcon(
                FontAwesomeIcons.lock,
                color: primarycolor,
              ),
            ),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(top: 12.0, right: 0.0, left: 0.0),
              child: GestureDetector(
                onTap: () {
                  if (showpass) {
                    setState(() {
                      showpass = false;
                    });
                  } else {
                    setState(() {
                      showpass = true;
                    });
                  }
                },
                child: showpass
                    ? FaIcon(
                        FontAwesomeIcons.eye,
                        color: primarycolor,
                      )
                    : FaIcon(
                        FontAwesomeIcons.eyeSlash,
                        color: primarycolor,
                      ),
              ),
            ),
          ),
        ),
        SizedBox(height: 10.0),
        TextFormField(
          controller: _RePasswordtext,
          obscureText: showRepass,
          style: style,
          validator: ConformvalidatePassword,
          // validator: (val) => ConformvalidatePassword(errorText: 'passwords do not match').validateMatch(val, Password),
          onChanged: (value) {
            RePassword = value;

            if (_Passwordtext == _RePasswordtext) {
              return null;
            } else {
              return 'Password Not Match';
            }
          },
          decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Confirm Password",
            // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(top: 12.0, right: 0.0, left: 0.0),
              child: FaIcon(
                FontAwesomeIcons.lock,
                color: primarycolor,
              ),
            ),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(top: 12.0, right: 0.0, left: 0.0),
              child: GestureDetector(
                onTap: () {
                  if (showRepass) {
                    setState(() {
                      showRepass = false;
                    });
                  } else {
                    setState(() {
                      showRepass = true;
                    });
                  }
                },
                child: showRepass
                    ? FaIcon(
                        FontAwesomeIcons.eye,
                        color: primarycolor,
                      )
                    : FaIcon(
                        FontAwesomeIcons.eyeSlash,
                        color: primarycolor,
                      ),
              ),
            ),
          ),
        ),
        SizedBox(height: 10.0),
        TextFormField(
          controller: _Descriptiontext,
          obscureText: false,
          //maxLines: 2,
          style: style,
          onChanged: (value) {
            Description = value;
          },
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: const EdgeInsets.only(top: 12.0, right: 0.0, left: 0.0),
              child: FaIcon(
                FontAwesomeIcons.audioDescription,
                color: primarycolor,
              ),
            ),
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Description",
          ),
        ),
        SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: RaisedButton(
                  color: Colors.blue,
                  child: new Text(
                    "Choose Photo",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () async {
                    // File result = await FilePicker.getFile(
                    //     type: FileType.image);
                    FilePickerResult result = await FilePicker.platform
                        .pickFiles(type: FileType.image);
                    if (result != null) {
                      setState(() {
                        print("inside if in image picker");
                        listfile.clear();
                        images = File(result.paths[0]);
                        listfile.add(images);
                        print("images:-${images}");
                      });
                    } else {
                      print("inside else in image picker");
                    }
                    // print("Inside Pressed Button $images");
                  }),
            ),
            Expanded(
              child: Container(
                  height: MediaQuery.of(context).size.height / 8,
                  width: MediaQuery.of(context).size.width / 2,
                  child: images != null
                      ? Center(
                          child: Image.file(images),
                        )
                      : Center(
                          child: Text('No image selected.'),
                        )),
            )
          ],
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
            _validateInputs();
          },
          child: Text("Register",
              textAlign: TextAlign.center,
              style: style.copyWith(
                  color: Colors.white, fontWeight: FontWeight.bold)),
        ),
        SizedBox(
          height: 3.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) {
                    return LogInPage();
                  }),
                );
              },
              child: Text(
                "Want To Login",
                style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 3.0,
        ),
      ],
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

//Validation For UserName
  String validateUsername(String value) {
    String pattern = r'(^[a-zA-Z0-9 ]*$)';
    RegExp regExp = new RegExp(pattern);
    if (value.isEmpty || value == null) {
      return 'Please Enter UserName';
    } else {
      if (!regExp.hasMatch(value)) {
        return 'Username must be a-z and A-Z';
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
      print("fullnumber:- ${FullName}");
      print("USerName:- ${UserName}");
      print("EmailID:- ${EmailID}");
      print("MobileNumber:- ${MobileNumber}");
      print("Password:- ${Password}");
      print("RePassword:-${RePassword}");
      print("Description:- ${Description}");

      _getRegistrationSubmitData(listfile, FullName, UserName, _selectdate,
          EmailID, MobileNumber, Password, Description, "", "", "", "", "");
    } else {
//    If all data are not valid then start auto validation.
      setState(() {
        _autoValidate = true;
      });
    }
  }

  //for validating password
  String validatePassword(String value) {
    if (value.isEmpty || value == null) {
      return 'Please Enter Password';
    } else {
      if (value.length < 6) {
        return 'Password must be at least 6 characters';
      } else {
        return null;
      }
    }
    //  return null;
  }

  //for validating Confrompassword
  String ConformvalidatePassword(String value) {
    if (value.isEmpty || value == null) {
      return 'Please Enter Conform  Password';
    } else {
      if (value.length < 6) {
        return 'Password must be at least 6 characters';
      } else {
        if (value == _Passwordtext.text) {
          return null;
        } else {
          return 'Password Not Match';
        }
      }
    }
    //  return null;
  }

  _getRegistrationSubmitData(
    List images,
    String full_Name,
    String UserName,
    String Date,
    String Email_ID,
    String Mobile_Number,
    String Password,
    String Description,
    String area,
    String city,
    String pincode,
    String locationlat,
    String locationlong,
  ) async {
    setState(() {
      showspinner = true;
    });
    FirebaseMessaging.instance.getToken().then((token) async {
      print('Token: $token');

      RegistrationImageSubmit registerSubmitData =
          new RegistrationImageSubmit();
      var registionData = await registerSubmitData.RegistrationuploadData(
        images,
        full_Name,
        UserName,
        Date,
        Email_ID,
        Mobile_Number,
        Password,
        Description,
        token,
        area,
        city,
        pincode,
        locationlat,
        locationlong,
      );
      if (registionData != null) {
        print("property data ///${registionData}");
        var resid = registionData['resid'];
        print("response from server ${resid}");
        if (resid == 200) {
          setState(() {
            showspinner = false;
          });
          Fluttertoast.showToast(
              msg: "Data Successfully Save !",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) {
              return LogInPage();
            }),
          );
        } else if (resid == 204) {
          setState(() {
            showspinner = false;
          });
          if (registionData['error'] == "username") {
            setState(() {
              checkusername = true;
              errorusername = registionData['message'];
            });
          } else if (registionData['error'] == "email") {
            setState(() {
              checkemail = true;
              erroremail = registionData['message'];
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
    }).catchError((e) {
      print(e);
      setState(() {
        showspinner = false;
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text("Some Technical Problem Plz Try Again Later"),
          backgroundColor: Colors.green,
        ));
      });
    });
  }

  Future<void> _showMyDialog(String msg, Color col) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: AlertDialog(
            title: Text(
              msg,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: col,
              ),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {},
              ),
            ],
          ),
        );
      },
    );
  }
}
