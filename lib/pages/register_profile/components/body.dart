import 'package:flutter/material.dart';
import 'package:onclickproperty/const/modal_progress_hud.dart';
import 'package:onclickproperty/utilities/constants.dart';
import 'package:onclickproperty/utilities/size_config.dart';

import 'register_profile_form.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _showProgressBar = false;

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
                  // Text("Complete Profile", style: headingStyle),
                  // Text(
                  //   "Please enter your mobile no.",
                  //   textAlign: TextAlign.center,
                  // ),
                  // SizedBox(height: SizeConfig.screenHeight * 0.06),
                  RegisterProfileForm(_getLoading),
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
