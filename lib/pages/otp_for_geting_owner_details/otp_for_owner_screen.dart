import 'package:flutter/material.dart';
import 'package:onclickproperty/const/modal_progress_hud.dart';
import 'package:onclickproperty/pages/otp_for_geting_owner_details/components/body.dart';
import 'package:onclickproperty/utilities/size_config.dart';


class OtpforownerdetailsScreen extends StatefulWidget {
  static String routeName = "/otp";
  String CheckId;
  String ID;
  OtpforownerdetailsScreen(this.mobileNo, this.otpNo,this.CheckId,this.ID);

  final String mobileNo;
  final int otpNo;

  @override
  _OtpforownerdetailsScreenState createState() => _OtpforownerdetailsScreenState(this.mobileNo, this.otpNo,this.CheckId,this.ID);
}

class _OtpforownerdetailsScreenState extends State<OtpforownerdetailsScreen> {
  _OtpforownerdetailsScreenState(this.mobileNo, this.otpNo,this.CheckId,this.ID);
  String CheckId;
  String ID;
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
          child: Body(mobileNo, otpNo, _getLoading,CheckId,ID)),
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
