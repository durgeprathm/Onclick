import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:onclickproperty/Adaptor/fetch_otp.dart';
import 'package:onclickproperty/const/shared_preference_constants.dart';
import 'package:onclickproperty/pages/complete_profile/complete_profile_screen.dart';
import 'package:onclickproperty/utilities/constants.dart';
import 'package:onclickproperty/utilities/size_config.dart';

class OtpForm extends StatefulWidget {
  Function setLoading;
  final String otpno;
  final String mobileNo;
  Function visTimershow;

  OtpForm(this.setLoading, this.otpno, this.mobileNo, this.visTimershow);

  @override
  _OtpFormState createState() => _OtpFormState(
      this.setLoading, this.otpno, this.mobileNo, this.visTimershow);
}

class _OtpFormState extends State<OtpForm> {
  Function setLoading;
  String otpno;
  final String mobileNo;
  Function visTimershow;

  _OtpFormState(this.setLoading, this.otpno, this.mobileNo, this.visTimershow);

  FocusNode pin2FocusNode;
  FocusNode pin3FocusNode;
  FocusNode pin4FocusNode;

  String sPassword1 = '', sPassword2 = '', sPassword3 = '', sPassword4 = '';

  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    pin2FocusNode.dispose();
    pin3FocusNode.dispose();
    pin4FocusNode.dispose();
  }

  void nextField(String value, FocusNode focusNode) {
    if (value.length == 1) {
      focusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          SizedBox(height: SizeConfig.screenHeight * 0.15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: getProportionateScreenWidth(60),
                child: TextFormField(
                  autofocus: true,
                  obscureText: false,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    nextField(value, pin2FocusNode);
                    sPassword1 = value;
                  },
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(60),
                child: TextFormField(
                    focusNode: pin2FocusNode,
                    obscureText: false,
                    style: TextStyle(fontSize: 24),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: otpInputDecoration,
                    onChanged: (value) {
                      nextField(value, pin3FocusNode);
                      sPassword2 = value;
                    }),
              ),
              SizedBox(
                width: getProportionateScreenWidth(60),
                child: TextFormField(
                    focusNode: pin3FocusNode,
                    obscureText: false,
                    style: TextStyle(fontSize: 24),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: otpInputDecoration,
                    onChanged: (value) {
                      nextField(value, pin4FocusNode);
                      sPassword3 = value;
                    }),
              ),
              SizedBox(
                width: getProportionateScreenWidth(60),
                child: TextFormField(
                  focusNode: pin4FocusNode,
                  obscureText: false,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    if (value.length == 1) {
                      pin4FocusNode.unfocus();
                      // Then you need to check is the code is correct or not
                    }

                    sPassword4 = value;
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.15),
          SizedBox(
            width: double.infinity,
            height: getProportionateScreenHeight(56),
            child: FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: kPrimaryColor,
              onPressed: () async {
                if (sPassword1.isNotEmpty ||
                    sPassword2.isNotEmpty ||
                    sPassword3.isNotEmpty ||
                    sPassword4.isNotEmpty) {
                  String megerOtp =
                      '$sPassword1$sPassword2$sPassword3$sPassword4';
                  print(megerOtp);
                  if (otpno == megerOtp) {
                    // await SharedPreferencesConstants.instance.setStringValue(
                    //     SharedPreferencesConstants.USERMOBNO, mobileNo);
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) {
                        return CompleteProfileScreen(mobileNo);
                      }),
                    );
                  } else {
                    setLoading(false);
                    Fluttertoast.showToast(
                        msg: "Check Otp No",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 3,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  }
                } else {
                  setLoading(false);
                  Fluttertoast.showToast(
                      msg: "Check Otp No",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 3,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
              },
              child: Text(
                'Confirm',
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(18),
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.1),
          GestureDetector(
            onTap: () {
              getOtpData();
            },
            child: Text(
              "Resend OTP Code",
              style: TextStyle(decoration: TextDecoration.underline),
            ),
          )
        ],
      ),
    );
  }

  void getOtpData() async {
    setState(() {
      setLoading(true);
      visTimershow(false);
    });

    FetchOTP fetchlogindata = FetchOTP();
    var result = await fetchlogindata.FetchOTPData('0', mobileNo.toString());
    print(result);
    var resID = result["resid"];
    var message = result["message"];
    print(resID);
    if (resID == 200) {
      setState(() {
        setLoading(false);
        visTimershow(true);
        otpno = result["OTP"].toString();
      });

      Fluttertoast.showToast(
          msg: "$message",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      setState(() {
        setLoading(false);
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
  }
}
