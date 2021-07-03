import 'package:flutter/material.dart';
import 'package:onclickproperty/const/modal_progress_hud.dart';
import 'package:onclickproperty/utilities/size_config.dart';

import 'components/body.dart';

class OtpScreen extends StatefulWidget {
  static String routeName = "/otp";

  OtpScreen(this.mobileNo, this.otpNo);

  final String mobileNo;
  final int otpNo;

  @override
  _OtpScreenState createState() => _OtpScreenState(this.mobileNo, this.otpNo);
}

class _OtpScreenState extends State<OtpScreen> {
  _OtpScreenState(this.mobileNo, this.otpNo);

  final String mobileNo;
  final int otpNo;
  bool _showProgressBar = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("OTP Verification"),
      ),
      body: ModalProgressHUD(
          inAsyncCall: _showProgressBar,
          child: Body(mobileNo, otpNo, _getLoading)),
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
}
