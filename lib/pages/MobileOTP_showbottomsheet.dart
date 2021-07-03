import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:onclickproperty/Adaptor/fetch_otp.dart';
import 'package:onclickproperty/const/const.dart';
import 'package:onclickproperty/const/shared_preference_constants.dart';
import 'package:onclickproperty/pages/Registration_Page.dart';

class MobileOTPShowBottomSheet extends StatefulWidget {
  @override
  _MobileOTPShowBottomSheetState createState() =>
      _MobileOTPShowBottomSheetState();
}

class _MobileOTPShowBottomSheetState extends State<MobileOTPShowBottomSheet> {
  bool showOTPFeild = false;
  bool _showcricleBar = false;
  final _mobileNoTextField = TextEditingController();
  final _otpTextField = TextEditingController();

  bool _mobileNoValidator = false;
  bool _otpValidator = false;
  String mobNo;
  String confirmMobNo = '';
  String otpNo;
  int _getOtpNo = 0;
  bool _visOtpTimerText = false;
  bool _visOtpReSendText = false;

  bool _visSendOtpBtn = false;
  bool _visConfirmOtpBtn = false;

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  void initState() {
    super.initState();
    setState(() {
      _visSendOtpBtn = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _showcricleBar
        ? Center(child: Container(child: CircularProgressIndicator()))
        : Container(
            color: Color(0xff757575),
            child: Container(
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: new Wrap(
                children: <Widget>[
                  SizedBox(
                    height: 30.0,
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  TextField(
                    controller: _mobileNoTextField,
                    obscureText: false,
                    style: style,
                    maxLength: 10,
                    maxLengthEnforced: true,
                    onChanged: (value) {
                      mobNo = value;
                    },
                    keyboardType: TextInputType.number,
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
                      hintText: "Enter Mobile Number",
                      errorText: _mobileNoValidator
                          ? 'Please Enter Mobile Number'
                          : null,
                    ),
                  ),
                  SizedBox(
                    height: 80.0,
                  ),
                  Visibility(
                    visible: showOTPFeild,
                    child: TextField(
                      controller: _otpTextField,
                      obscureText: false,
                      style: style,
                      onChanged: (value) {
                        otpNo = value;
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(
                              top: 12.0, right: 0.0, left: 0.0),
                          child: FaIcon(
                            FontAwesomeIcons.lock,
                            color: primarycolor,
                          ),
                        ),
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: "Enter OTP Number",
                        errorText:
                            _otpValidator ? 'Please Enter OTP Number' : null,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Visibility(
                    visible: _visOtpTimerText,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 20,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TweenAnimationBuilder(
                              tween: Tween(begin: 30.0, end: 0),
                              duration: Duration(seconds: 30),
                              builder: (context, value, child) => Text(
                                  "00:${value.toInt()}",
                                  style: TextStyle(color: primarycolor)),
                              onEnd: () {
                                setState(() {
                                  _visOtpReSendText = true;
                                  _visOtpTimerText = false;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: _visOtpReSendText,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () async {
                              setState(() {
                                _mobileNoTextField.text.isEmpty
                                    ? _mobileNoValidator = true
                                    : _mobileNoValidator = false;
                              });

                              if (!_mobileNoValidator) {
                                if (mobNo.length == 10) {
                                  getOtpData();
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "$errorMobileValideMatchText",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 3,
                                      backgroundColor: Colors.green,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                }
                              }
                            },
                            child: Text(
                              'Resend OTP',
                              style: TextStyle(
                                  color: primarycolor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Visibility(
                    visible: _visSendOtpBtn,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 5.0, right: 5.0, top: 10.0, bottom: 5.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(10.0),
                              ),
                              child: Text('Send OTP',
                                  textAlign: TextAlign.center,
                                  style: style.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                              color: primarycolor,
                              textColor: Colors.white,
                              padding:
                                  EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 15.0),
                              onPressed: () {
                                setState(() {
                                  _mobileNoTextField.text.isEmpty
                                      ? _mobileNoValidator = true
                                      : _mobileNoValidator = false;
                                });

                                if (!_mobileNoValidator) {
                                  if (mobNo.length == 10) {
                                    getOtpData();
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: "$errorMobileValideMatchText",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 3,
                                        backgroundColor: Colors.green,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  }
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: _visConfirmOtpBtn,
                    child: Padding(
                        padding: const EdgeInsets.only(
                            left: 5.0, right: 5.0, top: 10.0, bottom: 5.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: FlatButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(10.0),
                                ),
                                child: Text(
                                  'Confirm',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                color: primarycolor,
                                textColor: Colors.white,
                                padding:
                                    EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 15.0),
                                onPressed: () async {
                                  _otpTextField.text.isEmpty
                                      ? _otpValidator = true
                                      : _otpValidator = false;

                                  print('otp: $otpNo');
                                  print('_getOtpNo: $_getOtpNo');

                                  if (!_otpValidator) {
                                    if (confirmMobNo == mobNo) {
                                      if (_getOtpNo.toString() == otpNo) {
                                        await SharedPreferencesConstants
                                            .instance
                                            .setStringValue(
                                                SharedPreferencesConstants
                                                    .USERMOBNO,
                                                mobNo);
                                        Navigator.of(context).push(
                                          MaterialPageRoute(builder: (_) {
                                            return RegistrationPage();
                                          }),
                                        ).then((value) => _clearAllText(value));
                                      } else {
                                        Fluttertoast.showToast(
                                            msg: "$errorOtpText",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 3,
                                            backgroundColor: Colors.green,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                      }
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: "$errorMobileNoMatchText",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 3,
                                          backgroundColor: Colors.green,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    }
                                  }
                                },
                              ),
                            ),
                          ],
                        )),
                  ),
                ],
              ),
            ),
          );
  }

  void getOtpData() async {
    setState(() {
      _showcricleBar = true;
    });

    FetchOTP fetchlogindata = FetchOTP();
    var result = await fetchlogindata.FetchOTPData('0', mobNo);
    print(result);
    var resID = result["resid"];
    var message = result["message"];
    print(resID);
    if (resID == 200) {
      setState(() {
        _showcricleBar = false;
        _visSendOtpBtn = false;
        _visConfirmOtpBtn = true;
        showOTPFeild = true;
        _visOtpReSendText = false;
        _visOtpTimerText = true;
      });
      confirmMobNo = mobNo;
      _getOtpNo = result["OTP"];
      Fluttertoast.showToast(
          msg: "$message",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      // Navigator.of(context).push(
      //   MaterialPageRoute(builder: (_) {
      //     return RegistrationPage();
      //   }),
      // );
    } else {
      setState(() {
        _showcricleBar = false;
      });
      confirmMobNo = '';
      Fluttertoast.showToast(
          msg: "$message",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  _clearAllText(value) {
    setState(() {
      showOTPFeild = false;
      _visOtpTimerText = false;
      _visOtpReSendText = false;
      _visSendOtpBtn = true;
      _visConfirmOtpBtn = false;

      _mobileNoTextField.text = '';
      _otpTextField.text = '';
      mobNo = null;
      confirmMobNo = '';
      otpNo = null;
      _getOtpNo = 0;
      confirmMobNo = '';
    });
  }
}
