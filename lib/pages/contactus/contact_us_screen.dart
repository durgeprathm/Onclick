import 'package:flutter/material.dart';
import 'package:onclickproperty/const/const.dart';

import 'components/body.dart';

class ContactUsScreen extends StatelessWidget {
  static String routeName = "/login_success";

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        title: Text(
          "Contact Us",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: primarycolor,
          ),
        ),
      ),
      body: Body(),
    );
  }
}
