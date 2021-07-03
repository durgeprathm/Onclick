import 'package:flutter/material.dart';
import 'package:onclickproperty/const/modal_progress_hud.dart';
import 'package:onclickproperty/utilities/constants.dart';
import 'package:onclickproperty/utilities/size_config.dart';

import 'complete_profile_form.dart';

class Body extends StatefulWidget {
  final String mobileNo;

  Body(this.mobileNo);

  @override
  _BodyState createState() => _BodyState(this.mobileNo);
}

class _BodyState extends State<Body> {
  bool _showProgressBar = false;
  final String mobileNo;

  _BodyState(this.mobileNo);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ModalProgressHUD(
        inAsyncCall: _showProgressBar,
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: SizeConfig.screenHeight * 0.03),
                  Text("Complete Profile", style: headingStyle),
                  Text(
                    "Complete your details",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.06),
                  CompleteProfileForm(_getLoading,mobileNo),
                  SizedBox(height: getProportionateScreenHeight(30)),
                  // Text(
                  //   "By continuing your confirm that you agree \nwith our Term and Condition",
                  //   textAlign: TextAlign.center,
                  //   style: Theme.of(context).textTheme.caption,
                  // ),
                ],
              ),
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
}
