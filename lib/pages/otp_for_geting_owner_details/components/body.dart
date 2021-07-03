import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:onclickproperty/Adaptor/fetch_otp.dart';
import 'package:onclickproperty/const/modal_progress_hud.dart';
import 'package:onclickproperty/utilities/constants.dart';
import 'package:onclickproperty/utilities/size_config.dart';

import 'otp_for_owner_form.dart';

class Body extends StatefulWidget {
  Body(this.mobileNo, this.otpNo, this.setLoading,this.CheckId,this.ID);
  String ID;
  String CheckId;
  final String mobileNo;
  final int otpNo;
  Function setLoading;

  @override
  _BodyState createState() =>
      _BodyState(this.mobileNo, this.otpNo, this.setLoading,this.CheckId,this.ID);
}

class _BodyState extends State<Body> {
  _BodyState(this.mobileNo, this.otpNo, this.setLoading,this.CheckId,this.ID);
  String ID;
  String CheckId;
  final String mobileNo;
  final int otpNo;
  Function setLoading;
  int _getOtpNo = 0;
  int durationTimeinSecond = 30;
  bool visTimershow = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _showProgressBar = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      _getOtpNo = otpNo;
      visTimershow = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _showProgressBar,
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.05),
                Text(
                  "OTP Verification",
                  style: headingStyle,
                ),
                Text("We sent your code to $mobileNo"),
                Visibility(visible: visTimershow, child: buildTimer()),
                OtpownerForm(_getLoading, _getOtpNo.toString(), mobileNo.toString(),
                    _getVisForTimer,CheckId,ID),
                // SizedBox(height: SizeConfig.screenHeight * 0.1),
                // GestureDetector(
                //   onTap: () {
                //     getOtpData();
                //   },
                //   child: Text(
                //     "Resend OTP Code",
                //     style: TextStyle(decoration: TextDecoration.underline),
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _getLoading(value) {
    if (value == true) {
      setState(() {
        _showProgressBar = true;
      });
    } else {
      setState(() {
        _showProgressBar = false;
      });
    }
  }

  _getVisForTimer(value) {
    if (value == true) {
      visTimershow = true;
    } else {
      visTimershow = false;
    }
  }

  Row buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("This code will expired in "),
        TweenAnimationBuilder(
          tween: Tween(begin: 30.0, end: 0.0),
          duration: Duration(seconds: durationTimeinSecond),
          builder: (_, value, child) => Text(
            "00:${value.toInt()}",
            style: TextStyle(color: kPrimaryColor),
          ),
        ),
      ],
    );
  }

// void getOtpData() async {
//   setState(() {
//     setLoading(true);
//     visTimershow =false;
//   });
//
//   FetchOTP fetchlogindata = FetchOTP();
//   var result = await fetchlogindata.FetchOTPData('0', mobileNo.toString());
//   print(result);
//   var resID = result["resid"];
//   var message = result["message"];
//   print(resID);
//   if (resID == 200) {
//     setState(() {
//       setLoading(false);
//       visTimershow=true;
//       durationTimeinSecond = 30;
//       _getOtpNo = result["OTP"];
//     });
//
//     Fluttertoast.showToast(
//         msg: "$message",
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.BOTTOM,
//         timeInSecForIosWeb: 3,
//         backgroundColor: Colors.green,
//         textColor: Colors.white,
//         fontSize: 16.0);
//   } else {
//     setState(() {
//       setLoading(false);
//     });
//     Fluttertoast.showToast(
//         msg: "$message",
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.BOTTOM,
//         timeInSecForIosWeb: 3,
//         backgroundColor: Colors.green,
//         textColor: Colors.white,
//         fontSize: 16.0);
//   }
// }
}
