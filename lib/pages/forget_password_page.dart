import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:onclickproperty/Adaptor/Insert_forget_password.dart';
import 'package:onclickproperty/Adaptor/fetch_otp.dart';
import 'package:onclickproperty/const/const.dart';
import 'package:onclickproperty/const/modal_progress_hud.dart';
import 'package:onclickproperty/pages/Login_Page.dart';
import 'package:onclickproperty/pages/sign_in/sign_in_screen.dart';

class ForgetPasswordPage extends StatefulWidget {
  @override
  _ForgetPasswordPageState createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  bool showpass = true;
  bool showconfirmpass = true;
  String UserName;
  String Password;
  String confirmPassword;
  String otp;
  final _usernametext = TextEditingController();
  final _passwordtext = TextEditingController();
  final _confimpasswordtext = TextEditingController();
  final _otptext = TextEditingController();

  bool _uvalidate = false;
  bool _pvalidate = false;
  bool _confirmpvalidate = false;
  bool _otpvalidate = false;

  bool _showcricleBar = false;
  bool _visotpText = false;
  bool _visOtpTimerText = false;
  bool _visOtpReSendText = false;

  String confirmUsername = '';
  int _getOtpNo = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      _visotpText = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final emailField = TextField(
      controller: _usernametext,
      obscureText: false,
      style: style,
      onChanged: (value) {
        UserName = value;
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Mobile no. or Email",
        errorText: _uvalidate ? 'Please Enter email or mobile no' : null,
      ),
    );
    final passwordField = TextField(
      controller: _passwordtext,
      obscureText: showpass,
      style: style,
      onChanged: (value) {
        Password = value;
      },
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "New Password",
          // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          errorText: _pvalidate ? 'Please Enter New Password' : null,
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
                      color: Colors.grey,
                    )
                  : FaIcon(
                      FontAwesomeIcons.eyeSlash,
                      color: Colors.grey,
                    ),
            ),
          )),
    );
    final confiPasswordField = TextField(
      controller: _confimpasswordtext,
      obscureText: showconfirmpass,
      style: style,
      onChanged: (value) {
        confirmPassword = value;
      },
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Repeat Password",
          errorText: _confirmpvalidate ? 'Please check Repeat Password' : null,
          suffixIcon: Padding(
            padding: const EdgeInsets.only(top: 12.0, right: 0.0, left: 0.0),
            child: GestureDetector(
              onTap: () {
                if (showconfirmpass) {
                  setState(() {
                    showconfirmpass = false;
                  });
                } else {
                  setState(() {
                    showconfirmpass = true;
                  });
                }
              },
              child: showconfirmpass
                  ? FaIcon(
                      FontAwesomeIcons.eye,
                      color: Colors.grey,
                    )
                  : FaIcon(FontAwesomeIcons.eyeSlash, color: Colors.grey),
            ),
          )),
    );
    final finaloginButon = FlatButton(
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(10.0),
      ),
      color: primarycolor,
      minWidth: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 15.0),
      onPressed: () async {
        _usernametext.text.isEmpty ? _uvalidate = true : _uvalidate = false;
        _passwordtext.text.isEmpty ? _pvalidate = true : _pvalidate = false;
        _confimpasswordtext.text.isEmpty
            ? _confirmpvalidate = true
            : _confirmpvalidate = false;
        _otptext.text.isEmpty ? _otpvalidate = true : _otpvalidate = false;
        bool errorCheck =
            (!_uvalidate && !_pvalidate && !_confirmpvalidate && !_otpvalidate);
        if (errorCheck) {
          if (Password == confirmPassword) {
            if (UserName == confirmUsername) {
              bool isNumber = isNumericUsingRegularExpression(UserName);
              if (isNumber) {
                if (_getOtpNo.toString() == otp) {
                  _sendForgetPasswordData('1', UserName, Password);
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
                if (_getOtpNo.toString() == otp) {
                  _sendForgetPasswordData('0', UserName, Password);
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
          } else {
            _confimpasswordtext.text.isEmpty
                ? _confirmpvalidate = true
                : _confirmpvalidate = false;
          }
        }
      },
      child: Text("Reset Password",
          textAlign: TextAlign.center,
          style:
              style.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
    );
    final otpField = TextField(
      controller: _otptext,
      obscureText: false,
      style: style,
      keyboardType: TextInputType.number,
      onChanged: (value) {
        otp = value;
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Enter Otp",
        errorText: _otpvalidate ? 'Please Enter Otp' : null,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        title: Text(
          'Reset Password',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: primarycolor,
          ),
        ),
        // centerTitle: false,
      ),
      body: ModalProgressHUD(
        inAsyncCall: _showcricleBar,
        child: GestureDetector(
          // close keyboard on outside input tap
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },

          child: Builder(
            builder: (context) => ListView(
              padding: EdgeInsets.all(20),
              children: <Widget>[
                // header text
                Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                    ),
                    child: Container(
                        padding: EdgeInsets.all(3.0), child: emailField)),
                SizedBox(height: 15.0),
                Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                    ),
                    child: Container(
                        padding: EdgeInsets.all(3.0), child: passwordField)),
                SizedBox(height: 15.0),
                Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                    ),
                    child: Container(
                        padding: EdgeInsets.all(3.0),
                        child: confiPasswordField)),
                SizedBox(
                  height: 15.0,
                ),
                Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                    ),
                    child: Container(
                        padding: EdgeInsets.all(3.0), child: otpField)),
                SizedBox(
                  height: 10.0,
                ),
                Visibility(
                  visible: _visotpText,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _usernametext.text.isEmpty
                                ? _uvalidate = true
                                : _uvalidate = false;
                          });

                          if (!_uvalidate) {
                            bool isNumber =
                                isNumericUsingRegularExpression(UserName);
                            if (isNumber) {
                              if (UserName.length == 10) {
                                setState(() {
                                  _visotpText = false;
                                  _visOtpTimerText = true;
                                  _visOtpReSendText = false;
                                });
                                getOtpData('2');
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
                            } else {
                              setState(() {
                                _visotpText = false;
                                _visOtpTimerText = true;
                                _visOtpReSendText = false;
                              });
                              getOtpData('1');
                            }
                          }
                        },
                        child: Text(
                          'Send OTP',
                          style: TextStyle(
                              color: primarycolor, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: _visOtpTimerText,
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
                              _visotpText = false;
                              _visOtpReSendText = true;
                              _visOtpTimerText = false;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: _visOtpReSendText,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _usernametext.text.isEmpty
                                ? _uvalidate = true
                                : _uvalidate = false;
                          });

                          if (!_uvalidate) {
                            bool isNumber =
                                isNumericUsingRegularExpression(UserName);
                            if (isNumber) {
                              if (UserName.length == 10) {
                                setState(() {
                                  _visotpText = false;
                                  _visOtpTimerText = true;
                                  _visOtpReSendText = false;
                                });
                                getOtpData('2');
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
                            } else {
                              setState(() {
                                _visotpText = false;
                                _visOtpTimerText = true;
                                _visOtpReSendText = false;
                              });
                              getOtpData('1');
                            }
                          }
                        },
                        child: Text(
                          'Resend OTP',
                          style: TextStyle(
                              color: primarycolor, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 35.0,
                ),
                finaloginButon,
                SizedBox(
                  height: 7.0,
                ),
                // sign up button
                Padding(
                  padding: EdgeInsets.only(top: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Don\'t have an account?',
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => SignInScreen()),
                        ),
                        child: Text(
                          'Sign Up',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void getOtpData(actionId) async {
    setState(() {
      _showcricleBar = true;
    });

    FetchOTP fetchlogindata = FetchOTP();
    var result = await fetchlogindata.FetchOTPData(actionId, UserName);
    print(result);
    var resID = result["resid"];
    var message = result["message"];
    print(resID);
    if (resID == 200) {
      setState(() {
        _showcricleBar = false;
      });
      confirmUsername = UserName;
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
      confirmUsername = '';
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

  _sendForgetPasswordData(String actionId, String userName, password) async {
    setState(() {
      _showcricleBar = true;
    });
    try {
      InsertForgetPassword insertForPass = new InsertForgetPassword();
      var result =
          await insertForPass.sendForgetPassword(actionId, userName, password);
      if (result != null) {
        print("property data ///${result}");
        var resid = result['resid'];
        var message = result["message"];
        if (resid == 200) {
          setState(() {
            _showcricleBar = false;
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
              return SignInScreen();
            }),
          );
        } else {
          setState(() {
            _showcricleBar = false;
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
          _showcricleBar = true;
        });
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text("Plz Try Again"),
          backgroundColor: Colors.green,
        ));
      }
    } catch (e) {
      print(e);
      setState(() {
        _showcricleBar = true;
      });
    }
  }

  bool isNumericUsingRegularExpression(String string) {
    final numericRegex = RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$');

    return numericRegex.hasMatch(string);
  }
}
