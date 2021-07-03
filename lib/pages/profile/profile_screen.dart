import 'package:flutter/material.dart';
import 'package:onclickproperty/const/const.dart';

import 'components/body.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = "/profile";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile" ,style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: primarycolor,
        ),),
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,

      ),
      body: Body(),
    );
  }
}
